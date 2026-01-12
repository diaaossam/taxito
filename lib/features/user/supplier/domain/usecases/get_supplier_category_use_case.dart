import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/supplier/data/models/requests/suppliers_params.dart';
import 'package:taxito/features/user/supplier/domain/repositories/suppliers_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetSupplierCategoryUseCase {
  final SuppliersRepository suppliersRepository;

  GetSupplierCategoryUseCase({required this.suppliersRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required SuppliersParams params}) async {
    return await suppliersRepository.getSupplierCategory(params: params);
  }
}
