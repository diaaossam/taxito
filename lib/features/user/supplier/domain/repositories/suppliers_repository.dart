import 'package:dartz/dartz.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../data/models/requests/suppliers_params.dart';

abstract class SuppliersRepository {
  Future<Either<Failure, ApiSuccessResponse>> getSupplierCategory(
      {required SuppliersParams params});

  Future<Either<Failure, ApiSuccessResponse>> getSupplierDetailsCategory(
      {required num id});
}
