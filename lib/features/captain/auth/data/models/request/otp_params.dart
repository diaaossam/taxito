import 'package:taxito/core/enum/user_type.dart';

class OtpParams {
  final String otp;
  final String phoneNumber;
  final String deviceToken;
  final String deviceType;
  final UserType userType;

  OtpParams({
    required this.otp,
    required this.phoneNumber,
    required this.deviceToken,
    required this.deviceType,
    required this.userType,
  });

  Map<String, dynamic> toJson() => {
    "phone": phoneNumber,
    "otp_code": otp,
    "device_type": deviceType,
    "device_token": deviceToken,
    "user_type": userType == UserType.delivery
        ? UserType.driver.name
        : userType.name,
  };
}
