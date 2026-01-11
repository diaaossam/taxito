part of 'global_location_cubit.dart';

@immutable
class GlobalLocationState extends Equatable {
  final bool isLoading;
  final List<GenericModel>? location;
  final String? error;

  const GlobalLocationState({
    this.isLoading = false,
    this.location,
    this.error,
  });

  GlobalLocationState copyWith({
    bool? isLoading,
    List<GenericModel>? location,
    String? error,
  }) {
    return GlobalLocationState(
      isLoading: isLoading ?? this.isLoading,
      location: location ?? this.location,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, location, error];
}
