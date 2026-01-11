class RegisterParams {
  final String? name;
  final String? phone;
  final String? email;
  final String? gender;
  final String? jobTitle;
  final String? imagePath;

  RegisterParams({
    this.name,
    this.phone,
    this.email,
    this.gender,
    this.jobTitle,
    this.imagePath,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "name": name,
      "email": email,
      "gender": gender,
      "phone": phone,
      "job_title": jobTitle,
    };
    map.removeWhere(
      (key, value) => value == null,
    );
    return map;
  }
}
