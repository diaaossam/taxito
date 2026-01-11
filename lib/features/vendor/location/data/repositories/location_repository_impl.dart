import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_local_data_source.dart';
import '../datasources/location_remote_data_source.dart';

@Injectable(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource locationRemoteDataSource;
  final LocationLocalDataSource locationLocalDataSource;

  LocationRepositoryImpl({
    required this.locationRemoteDataSource,
    required this.locationLocalDataSource,
  });

  @override
  Future<Either<Failure, ApiSuccessResponse>> getGovernorates() async {
    try {
      final response = await locationRemoteDataSource.getGovernorates();
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getRegion({
    required num id,
  }) async {
    try {
      final response = await locationRemoteDataSource.getRegion(id: id);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }
}
