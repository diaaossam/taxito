import 'package:taxito/core/services/network/dio_consumer.dart';
import 'package:taxito/core/services/network/end_points.dart';
import 'package:taxito/features/user/payment/data/models/transaction_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/success_response.dart';

abstract class PaymentRemoteDataSource {
  Future<ApiSuccessResponse> getTransaction({required int pageKey});

  Future<ApiSuccessResponse> addBalance({required num data});

  Future<ApiSuccessResponse> getCurrentBalance();
}

@LazySingleton(as: PaymentRemoteDataSource)
class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final DioConsumer dioConsumer;

  PaymentRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<ApiSuccessResponse> getTransaction({required int pageKey}) async {
    final response = await dioConsumer.get(
      path: EndPoints.transaction,
      params: {"page": pageKey},
    );

    final List<TransactionModel> list = response['data']
        .map<TransactionModel>((element) => TransactionModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> addBalance({required num data}) async {
    final response = await dioConsumer.post(
      path: EndPoints.transaction,
      body: {"amount": data},
    );
    return ApiSuccessResponse(message: response['message']);
  }

  @override
  Future<ApiSuccessResponse> getCurrentBalance() async {
    final response = await dioConsumer.get(path: EndPoints.currentWallet);
    return ApiSuccessResponse(data: response['data']['wallet_balance']);
  }
}
