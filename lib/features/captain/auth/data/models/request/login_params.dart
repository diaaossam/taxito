import 'package:taxito/core/enum/user_type.dart';

class LoginParams {
  final String phone;
  final UserType userType;

  LoginParams({required this.phone, required this.userType});

  Map<String, dynamic> map() => {
        "phone": phone,
        "user_type": userType.name,
      };
}
