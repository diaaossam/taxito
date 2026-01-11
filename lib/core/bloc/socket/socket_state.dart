part of 'socket_cubit.dart';

@immutable
sealed class SocketState {}

final class SocketInitial extends SocketState {}

final class SocketConnecting extends SocketState {}

final class SocketConnected extends SocketState {
  final Set<String> activeRooms;
  
  SocketConnected({this.activeRooms = const {}});
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SocketConnected && 
           other.activeRooms.length == activeRooms.length &&
           other.activeRooms.every((room) => activeRooms.contains(room));
  }
  
  @override
  int get hashCode => activeRooms.hashCode;
}

final class SocketDisconnected extends SocketState {}

final class SocketError extends SocketState {
  final String message;
  final SocketErrorType type;
  final int code;
  final DateTime timestamp;
  
  SocketError({
    required this.message,
    required this.type,
    required this.code,
    required this.timestamp,
  });
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SocketError &&
           other.message == message &&
           other.type == type &&
           other.code == code;
  }
  
  @override
  int get hashCode => Object.hash(message, type, code);
}

enum SocketErrorType {
  connection,
  authentication,
  room,
  emit,
  general,
}