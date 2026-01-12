import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/supplier/data/datasources/supplier_remote_data_source.dart';
import 'package:taxito/features/user/supplier/domain/repositories/suppliers_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../models/requests/suppliers_params.dart';

@LazySingleton(as: SuppliersRepository)
class SuppliersRepositoryImpl implements SuppliersRepository {
  final SuppliersRemoteDataSource suppliersRemoteDataSource;

  SuppliersRepositoryImpl({required this.suppliersRemoteDataSource});

  @override
  Future<Either<Failure, ApiSuccessResponse>> getSupplierCategory(
      {required SuppliersParams params}) async {
    try {
      final response =
          await suppliersRemoteDataSource.getSupplierCategory(params: params);
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getSupplierDetailsCategory(
      {required num id}) async {
    try {
      final response =
          await suppliersRemoteDataSource.getSupplierDetailsCategory(id: id);
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }
}
