enum Gender {
  male("male"),
  female("female");

  final String name;

  const Gender(this.name);
}
List<Gender> genders = [
  Gender.male,
  Gender.female,
];
Gender handleGender(dynamic rawValue) {
  if (rawValue == "male") {
    return Gender.male;
  } else {
    return Gender.female;
  }
}
