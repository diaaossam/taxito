enum LoginUserType {
  student("student"),
  employee("employee");

  final String name;

  const LoginUserType(this.name);
}

LoginUserType handleLoginUserType(String? rawValue) {
  if (rawValue == "student") {
    return LoginUserType.student;
  } else {
    return LoginUserType.employee;
  }
}

List<LoginUserType> usersType = [
  LoginUserType.student,
  LoginUserType.employee,
];
