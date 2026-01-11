class OtpParams {
  final String otp;
  final String phoneNumber;
  final String deviceToken;
  final String deviceType;

  OtpParams(
      {required this.otp,
      required this.phoneNumber,
      required this.deviceToken,
      required this.deviceType});

  Map<String, dynamic> toJson() => {
        "phone": phoneNumber,
        "otp_code": otp,
        "device_type": deviceType,
        "device_token": deviceToken,
        "user_type": "supplier"
      };
}
