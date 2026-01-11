part of 'network_cubit.dart';

@immutable
sealed class NetworkState {}

final class NetworkInitial extends NetworkState {}

class ConnectionInitial extends NetworkState {}

class ConnectionSuccess extends NetworkState {}

class ConnectionFailure extends NetworkState {}
