import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/supplier/data/models/requests/suppliers_params.dart';
import 'package:aslol/features/supplier/domain/repositories/suppliers_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetSupplierDetailsCategoryUseCase {
  final SuppliersRepository suppliersRepository;

  GetSupplierDetailsCategoryUseCase({required this.suppliersRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({required num id}) async {
    return await suppliersRepository.getSupplierDetailsCategory(id: id);
  }
}
