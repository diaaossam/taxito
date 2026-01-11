import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../config/helper/token_repository.dart';
import '../../services/socket/socket.dart';

part 'socket_state.dart';

@injectable
class SocketCubit extends Cubit<SocketState> with WidgetsBindingObserver {
  final SocketService socketService;
  final TokenRepository tokenRepository;
  final Logger _logger = Logger();

  bool _isInitialized = false;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Timer? _reconnectTimer;
  Timer? _connectionTimeoutTimer;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;
  static const Duration _connectionTimeout = Duration(seconds: 5);

  SocketCubit(
    this.socketService,
    this.tokenRepository,
  ) : super(SocketInitial()) {
    WidgetsBinding.instance.addObserver(this);
  }

  void initSocketConnection() async {
    if (_isInitialized) {
      _logger.w("SocketCubit: Socket already initialized");
      return;
    }

    emit(SocketConnecting());
    _logger.i("SocketCubit: Starting socket connection...");

    try {
      final String? token = await tokenRepository.token;
      if (token == null) {
        _logger.e("SocketCubit: No authentication token available");
        emit(SocketError(
          message: 'No authentication token available',
          type: SocketErrorType.authentication,
          code: 401,
          timestamp: DateTime.now(),
        ));
        return;
      }

      _logger.i("SocketCubit: Token retrieved successfully");
      _isInitialized = true;
      _reconnectAttempts = 0;

      // Cancel any existing timeout timer
      _connectionTimeoutTimer?.cancel();

      // Initialize socket
      socketService.initSocket(token);
      _logger.i("SocketCubit: Socket initialization called");

      _connectionTimeoutTimer = Timer(_connectionTimeout, () {
        if (!socketService.isConnected()) {
          _logger.e("SocketCubit: Connection timeout - server not responding");
          if (!isClosed) {
            emit(SocketError(
              message: 'Connection timeout - server not responding',
              type: SocketErrorType.connection,
              code: 408,
              timestamp: DateTime.now(),
            ));
          }
        } else {
          emit(SocketConnected());
        }
      });
    } catch (e) {
      _logger.e("SocketCubit: Failed to initialize socket: $e");
      if (!isClosed) {
        emit(SocketError(
          message: 'Failed to initialize socket: $e',
          type: SocketErrorType.connection,
          code: 500,
          timestamp: DateTime.now(),
        ));
      }
    }
  }

  void forceReconnect() async {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      _logger.e("SocketCubit: Maximum reconnection attempts reached");
      if (!isClosed) {
        emit(SocketError(
          message: 'Maximum reconnection attempts reached',
          type: SocketErrorType.connection,
          code: 503,
          timestamp: DateTime.now(),
        ));
      }
      return;
    }

    _reconnectAttempts++;
    _logger.i("SocketCubit: Force reconnecting... attempt $_reconnectAttempts");

    if (!isClosed) {
      emit(SocketConnecting());
    }

    try {
      final String? token = await tokenRepository.token;
      if (token == null) {
        _logger.e(
            "SocketCubit: No authentication token available for reconnection");
        if (!isClosed) {
          emit(SocketError(
            message: 'No authentication token available for reconnection',
            type: SocketErrorType.authentication,
            code: 401,
            timestamp: DateTime.now(),
          ));
        }
        return;
      }

      // Cancel any existing timeout timer
      _connectionTimeoutTimer?.cancel();

      socketService.initSocket(token);
      _isInitialized = true;

      // Set up timeout for reconnection
      _connectionTimeoutTimer = Timer(_connectionTimeout, () {
        if (!socketService.isConnected()) {
          _logger.e("SocketCubit: Reconnection timeout");
          if (!isClosed) {
            emit(SocketError(
              message: 'Reconnection timeout',
              type: SocketErrorType.connection,
              code: 408,
              timestamp: DateTime.now(),
            ));
          }
        }
      });
    } catch (e) {
      _logger.e("SocketCubit: Failed to reconnect socket: $e");
      if (!isClosed) {
        emit(SocketError(
          message: 'Failed to reconnect socket: $e',
          type: SocketErrorType.connection,
          code: 500,
          timestamp: DateTime.now(),
        ));
      }
    }
  }

  void disconnectSocket() {
    _logger.i("SocketCubit: Disconnecting socket...");
    _connectionTimeoutTimer?.cancel();
    _reconnectTimer?.cancel();
    socketService.disconnect();
    _isInitialized = false;
    _reconnectAttempts = 0;
    if (!isClosed) {
      emit(SocketDisconnected());
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.paused:
        // Keep socket connected but reduce activity
        break;
      case AppLifecycleState.detached:
        disconnectSocket();
        break;
      case AppLifecycleState.inactive:
        // Keep socket connected
        break;
      case AppLifecycleState.hidden:
        // Keep socket connected
        break;
    }
  }

  @override
  Future<void> close() {
    _logger.i("SocketCubit: Closing cubit...");
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySubscription?.cancel();
    _reconnectTimer?.cancel();
    _connectionTimeoutTimer?.cancel();
    disconnectSocket();
    return super.close();
  }
}
