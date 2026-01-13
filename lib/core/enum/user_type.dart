import 'package:taxito/features/vendor/product/data/models/response/review_model.dart';

enum UserType {
  user('user'),
  supplier('supplier'),
  driver("driver"),
  delivery("delivery");

  final String name;

  const UserType(this.name);
}

UserType handleUserType({required String userType}) {
  if (userType == "supplier") {
    return UserType.supplier;
  } else if (userType == "user") {
    return UserType.user;
  } else {
    return UserType.driver;
  }
}

List<UserType> usersType = [
  UserType.user,
  UserType.supplier,
  UserType.delivery,
  UserType.driver,
];
