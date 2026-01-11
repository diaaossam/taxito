import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import '../../domain/repositories/attributes_repository.dart';
import '../datasources/attributes_remote_data_source.dart';
import '../models/sub_attribute_value_model.dart';

@LazySingleton(as: AttributesRepository)
class AttributesRepositoryImpl implements AttributesRepository {
  final AttributesRemoteDataSource remoteDataSource;

  AttributesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiSuccessResponse>> getAttributes({
    required int page,
  }) async {
    try {
      final res = await remoteDataSource.getAttributes(pageKey: page);
      return right(res);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> addAttribute({
    required Map<String, dynamic> body,
  }) async {
    try {
      final res = await remoteDataSource.addAttribute(body: body);
      return right(res);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> updateAttribute({
    required num id,
    required Map<String, dynamic> body,
  }) async {
    try {
      final res = await remoteDataSource.updateAttribute(id: id, body: body);
      return right(res);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> deleteAttribute({
    required num id,
  }) async {
    try {
      final res = await remoteDataSource.deleteAttribute(id: id);
      return right(res);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> uploadSubAttribute({
    required Map<num, List<SubAttributeValueModel>> map,
  }) async {
    try {
      final res = await remoteDataSource.uploadSubAttribute(map: map);
      return right(res);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }
}
