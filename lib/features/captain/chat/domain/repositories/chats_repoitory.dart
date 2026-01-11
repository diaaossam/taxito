import 'package:dartz/dartz.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../../driver_trip/data/models/trip_model.dart';
import '../entities/send_chat_params.dart';

abstract class ChatsRepository {
  Future<Either<Failure, ApiSuccessResponse>> sendChat(
      {required SendChatParams sendChatParams});

  Future<Either<Failure, ApiSuccessResponse>> getChatMessages(
      {required int pageKey, required TripModel tripModel});
}
