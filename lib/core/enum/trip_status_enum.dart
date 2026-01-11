import '../../generated/l10n.dart';

enum TripStatusEnum {
  coming("coming"),
  waitingDriver("pending"),
  cancelled("cancelled"),
  pickedClient("driver_arrived_to_client"),
  pickingClient("driver_in_the_way_to_client"),
  started("started"),
  delivered("completed");

  final String name;

  const TripStatusEnum(this.name);
}

TripStatusEnum? handleStringToTripStatusEnum({required String data}) {
  if (data == "pending") {
    return TripStatusEnum.waitingDriver;
  } else if (data == "cancelled") {
    return TripStatusEnum.cancelled;
  } else if (data == "driver_in_the_way_to_client") {
    return TripStatusEnum.pickingClient;
  } else if (data == "driver_arrived_to_client") {
    return TripStatusEnum.pickedClient;
  } else if (data == "started") {
    return TripStatusEnum.started;
  } else {
    return TripStatusEnum.delivered;
  }
}

String handleTripStatusEnumToString({required TripStatusEnum tripStatusEnum}) {
  if (tripStatusEnum == TripStatusEnum.waitingDriver) {
    return S.current.waitingDriver;
  } else if (tripStatusEnum == TripStatusEnum.cancelled) {
    return S.current.cancelled;
  } else if (tripStatusEnum == TripStatusEnum.started) {
    return S.current.in_progress;
  } else if (tripStatusEnum == TripStatusEnum.pickingClient) {
    return S.current.waitingDriver;
  } else if (tripStatusEnum == TripStatusEnum.pickedClient) {
    return S.current.pickedClient;
  } else {
    return S.current.completed1;
  }
}
