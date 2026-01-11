import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/services/network/dio_consumer.dart';
import '../../../../../core/services/network/end_points.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../../../captain/app/data/models/generic_model.dart';

abstract class LocationRemoteDataSource {
  Future<ApiSuccessResponse> getGovernorates();

  Future<ApiSuccessResponse> getRegion({required num id});
}

@Injectable(as: LocationRemoteDataSource)
class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final DioConsumer dioConsumer;
  var uuid = const Uuid();

  LocationRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<ApiSuccessResponse> getGovernorates() async {
    final response = await dioConsumer.get(path: EndPoints.governorates);
    final List<GenericModel> list = response['data']
        .map<GenericModel>((element) => GenericModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> getRegion({required num id}) async {
    final response = await dioConsumer.get(
      path: EndPoints.region,
      params: {"province_id": id},
    );
    final List<GenericModel> list = response['data']
        .map<GenericModel>((element) => GenericModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: list);
  }
}
