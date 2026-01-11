import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/dio_consumer.dart';
import '../../../../../core/services/network/end_points.dart';
import '../../../../../core/services/network/success_response.dart';

abstract class DriverMainRemoteDataSource {
  Future<ApiSuccessResponse> toggleAvailitiablity();
}

@Injectable(as: DriverMainRemoteDataSource)
class DriverMainRemoteDataSourceImpl implements DriverMainRemoteDataSource {
  final DioConsumer dioConsumer;

  DriverMainRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<ApiSuccessResponse> toggleAvailitiablity() async {
    final response = await dioConsumer.post(path: EndPoints.toggleAvailabilty);
    return ApiSuccessResponse();
  }
}
