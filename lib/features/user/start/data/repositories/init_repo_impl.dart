import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/start/data/datasources/init_remote_data_source.dart';
import 'package:aslol/features/start/domain/repositories/init_repostory.dart';

@LazySingleton(as: InitRepository)
class InitRepoImpl implements InitRepository {
  final InitRemoteDataSource initRemoteDataSource;

  InitRepoImpl({required this.initRemoteDataSource});

  @override
  Future<Either<Failure, ApiSuccessResponse>> getIntroData() async {
    try {
      final response = await initRemoteDataSource.getIntroData();
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> initUser() async {
    try {
      final response = await initRemoteDataSource.initUser();
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }
}
