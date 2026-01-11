enum UserType {
  user('user'),
  supplier('supplier'),
  driver("driver"),
  delivery("delivery");

  final String name;

  const UserType(this.name);
}

List<UserType> usersType = [
  UserType.user,
  UserType.supplier,
  UserType.delivery,
  UserType.driver,
];
