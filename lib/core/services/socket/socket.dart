import 'dart:async';
import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:taxito/config/environment/environment_helper.dart' as env;
import 'package:taxito/core/data/models/user_model_helper.dart';
import 'package:taxito/core/data/models/user_type_helper.dart';
import 'package:taxito/core/enum/user_type.dart';

@lazySingleton
class SocketService {
  io.Socket? _socket;
  final Logger _logger = Logger();
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;
  static const Duration _baseReconnectDelay = Duration(seconds: 2);
  static const Duration _heartbeatInterval = Duration(seconds: 30);
  String? _currentToken;
  bool _isConnecting = false;
  final Map<String, Function(dynamic)> _eventListeners = {};
  final Map<String, Function(dynamic)> _internalEventListeners = {};

  void initSocket(String token) {
    if (_isConnecting) {
      _logger.w("SocketService: Already connecting, ignoring init request");
      return;
    }

    _isConnecting = true;
    _currentToken = token;

    _logger.i(
      'Initializing socket connection with token: ${token.substring(0, 10)}...',
    );
    _cleanupSocket();

    try {
      _socket = io.io(env.Environment.socketUrl, <String, dynamic>{
        'transports': ['websocket'],
        'query': {
          'token': token,
          "user_type": UserTypeService().getUserType() == UserType.delivery
              ? "driver"
              : UserTypeService().getUserType()?.name,
        },
        'autoConnect': false, // We'll connect manually
        'reconnection': false, // We'll handle reconnection manually
        'timeout': const Duration(seconds: 20).inMilliseconds,
      });

      _setupEventListeners();
      _socket?.connect();
    } catch (e) {
      _logger.e("SocketService: Failed to create socket: $e");
      _isConnecting = false;
      _emitInternalEvent('connect_error', e);
    }
  }

  void _setupEventListeners() {
    if (_socket == null) return;

    _socket!.onConnect((data) {
      _logger.i("SocketService: Connected successfully");
      _isConnecting = false;
      _reconnectAttempts = 0;
      _startHeartbeat();
      _emitInternalEvent('connect', data);
    });

    _socket!.onConnectError((error) {
      _logger.e("SocketService: Connection error: $error");
      _isConnecting = false;
      _handleConnectionError(error);
      _emitInternalEvent('connect_error', error);
    });

    _socket!.onDisconnect((reason) {
      _logger.w("SocketService: Disconnected: $reason");
      _stopHeartbeat();
      _handleDisconnection(reason);
      _emitInternalEvent('disconnect', reason);
    });

    _socket!.onError((error) {
      _logger.e("SocketService: Socket error: $error");
      _handleSocketError(error);
      _emitInternalEvent('connect_error', error);
    });
  }

  void _emitInternalEvent(String eventName, dynamic data) {
    // Emit to internal event listeners (SocketCubit)
    for (final listener in _internalEventListeners.values) {
      try {
        listener(data);
      } catch (e) {
        _logger.e("SocketService: Error in internal event listener: $e");
      }
    }
  }

  void _cleanupSocket() {
    _stopHeartbeat();
    _reconnectTimer?.cancel();
    _socket?.disconnect();
    _socket?.destroy();
    _socket = null;
  }

  void _startHeartbeat() {
    _stopHeartbeat();
    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (timer) {
      if (_socket?.connected == true) {
        _socket?.emit('ping', {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });
      }
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  void _handleConnectionError(dynamic error) {
    _isConnecting = false;
    _reconnectAttempts++;

    if (_isUnauthorized(error)) {
      _logger.e("SocketService: Authentication failed - token may be invalid");
      return;
    }

    _scheduleReconnection();
  }

  void _handleDisconnection(dynamic reason) {
    _stopHeartbeat();

    // Only attempt reconnection if it wasn't a manual disconnect
    if (reason != 'io client disconnect') {
      _scheduleReconnection();
    }
  }

  void _handleSocketError(dynamic error) {
    _logger.e("SocketService: Socket error occurred: $error");
  }

  void _scheduleReconnection() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      _logger.w("SocketService: Max reconnection attempts reached");
      return;
    }

    _reconnectTimer?.cancel();
    final delay = Duration(
      milliseconds:
          (_baseReconnectDelay.inMilliseconds * pow(2, _reconnectAttempts - 1))
              .toInt(),
    );

    _logger.i(
      "SocketService: Scheduling reconnection attempt $_reconnectAttempts in ${delay.inSeconds}s",
    );

    _reconnectTimer = Timer(delay, () {
      if (_currentToken != null && !_isConnecting) {
        initSocket(_currentToken!);
      }
    });
  }

  bool _isUnauthorized(dynamic errorData) {
    if (errorData is Map && errorData['code'] == 401) return true;
    if (errorData.toString().contains("401")) return true;
    return false;
  }

  // Emit an event with error handling
  void emitEvent(String eventName, dynamic data) {
    if (_socket?.connected != true) {
      _logger.w("Cannot emit event '$eventName' - socket not connected");
      return;
    }

    try {
      _socket?.emit(eventName, data);
      _logger.w("Emitted event: $eventName");
    } catch (e) {
      _logger.e("Failed to emit event '$eventName': $e");
    }
  }

  void disconnectFromRoom(String currentChatUUID) {
    _socket?.off("messageResponse.$currentChatUUID");
    _eventListeners.remove("messageResponse.$currentChatUUID");
  }

  void disconnectFromCustomerRoom(String currentChatUUID) {
    _socket?.off("messageResponse.$currentChatUUID");
    _eventListeners.remove("messageResponse.$currentChatUUID");
  }

  void disconnectFromRoomEvent(String event) {
    _socket?.off(event);
    _eventListeners.remove(event);
  }

  void onEvent(String eventName, Function(dynamic) callback) {
    try {
      _socket?.on(eventName, callback);
      _eventListeners[eventName] = callback;
      _logger.d("SocketService: Listening to event: $eventName");
    } catch (e) {
      _logger.e("SocketService: Failed to listen to event '$eventName': $e");
    }
  }

  void onInternalEvent(String eventName, Function(dynamic) callback) {
    _internalEventListeners[eventName] = callback;
    _logger.d("SocketService: Listening to internal event: $eventName");
  }

  Future<void> disconnect() async {
    _logger.i("SocketService: Disconnecting socket...");
    _cleanupSocket();
    _isConnecting = false;
  }

  void reconnect() {
    if (_currentToken != null && !_isConnecting) {
      _logger.i("SocketService: Manually reconnecting socket...");
      _reconnectAttempts = 0;
      initSocket(_currentToken!);
    }
  }

  // Check if socket is connected
  bool isConnected() {
    return _socket != null && _socket!.connected;
  }

  Future<void> ensureAuthorizedConnected() async {
    if (_socket != null && _socket!.connected) {
      final completer = Completer<void>();
      bool done = false;

      _socket!.once('connect_error', (error) async {
        if (_isUnauthorized(error) && !done) {
          done = true;
          completer.complete();
        }
      });

      completer.complete();
      return completer.future;
    } else {
      final completer = Completer<void>();

      _socket?.once('connect', (_) => completer.complete());

      if (_currentToken != null) {
        initSocket(_currentToken!);
      }

      return completer.future;
    }
  }

  // Cleanup method
  void dispose() {
    _logger.i("SocketService: Disposing socket service...");
    _cleanupSocket();
    _eventListeners.clear();
    _internalEventListeners.clear();
    _isConnecting = false;
    _reconnectAttempts = 0;
    _currentToken = null;
  }
}
