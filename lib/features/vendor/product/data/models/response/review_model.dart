class ReviewModel {
  ReviewModel({
      this.id, 
      this.rating, 
      this.comment, 
      this.user, 
      this.createdAt,});

  ReviewModel.fromJson(dynamic json) {
    id = json['id'];
    rating = json['rating'];
    comment = json['comment'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    createdAt = json['created_at'];
  }
  num? id;
  num? rating;
  String? comment;
  User? user;
  String? createdAt;
ReviewModel copyWith({  num? id,
  num? rating,
  String? comment,
  User? user,
  String? createdAt,
}) => ReviewModel(  id: id ?? this.id,
  rating: rating ?? this.rating,
  comment: comment ?? this.comment,
  user: user ?? this.user,
  createdAt: createdAt ?? this.createdAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['rating'] = rating;
    map['comment'] = comment;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['created_at'] = createdAt;
    return map;
  }

}

class User {
  User({
      this.id, 
      this.name, 
      this.image,});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
  num? id;
  String? name;
  String? image;
User copyWith({  num? id,
  String? name,
  String? image,
}) => User(  id: id ?? this.id,
  name: name ?? this.name,
  image: image ?? this.image,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    return map;
  }

}