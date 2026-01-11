import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../domain/repositories/main_repository.dart';
import '../datasources/main_remote_data_source.dart';

@Injectable(as: DriverMainRepository)
class DriverMainRepositoryImpl implements DriverMainRepository {
  final DriverMainRemoteDataSource mainRemoteDataSource;

  DriverMainRepositoryImpl({required this.mainRemoteDataSource});

  @override
  Future<Either<Failure, ApiSuccessResponse>> toggleAvailitiablity() async {
    try {
      final response = await mainRemoteDataSource.toggleAvailitiablity();
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }
}
