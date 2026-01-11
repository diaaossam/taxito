class IntroModel {
  final int id;
  final String title, description, image;

  IntroModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.image});

  factory IntroModel.fromJson(Map<String, dynamic> map) => IntroModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      image: map['image']);
}
