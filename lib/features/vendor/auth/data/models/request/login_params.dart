
class LoginParams {
  final String phone;

  LoginParams({required this.phone});

  Map<String, dynamic> map() => {
        "phone": phone,
      };
}
