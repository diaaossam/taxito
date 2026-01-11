import '../../generated/l10n.dart';

enum OrderType {
  pending("pending"),
  inPreparation("in_preparation"),
  confirmed("confirmed"),
  readyForDeleivery("ready_for_delivery"),
  outForDeleivery("out_for_delivery"),
  delivered("delivered"),
  canceled("canceled");

  final String name;

  const OrderType(this.name);
}

String handleOrderTypeToString({required OrderType code}) {
  if (code == OrderType.pending) {
    return S.current.pending;
  }
  if (code == OrderType.inPreparation) {
    return S.current.inPreparation;
  }
  if (code == OrderType.readyForDeleivery) {
    return S.current.orderIsReady;
  } else if (code == OrderType.confirmed) {
    return S.current.confirmed;
  } else if (code == OrderType.outForDeleivery) {
    return S.current.outForDeleivery;
  } else if (code == OrderType.delivered) {
    return S.current.delivered;
  } else {
    return S.current.canceled;
  }
}

OrderType handleStringToOrderType({required String code}) {
  if (code == OrderType.pending.name) {
    return OrderType.pending;
  } else if (code == OrderType.confirmed.name) {
    return OrderType.confirmed;
  } else if (code == OrderType.readyForDeleivery.name) {
    return OrderType.readyForDeleivery;
  } else if (code == OrderType.inPreparation.name) {
    return OrderType.inPreparation;
  } else if (code == OrderType.outForDeleivery.name) {
    return OrderType.outForDeleivery;
  } else if (code == OrderType.delivered.name) {
    return OrderType.delivered;
  } else {
    return OrderType.canceled;
  }
}
