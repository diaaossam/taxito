import 'dart:convert';
/// id : 1
/// title : "Banner #1"
/// url : "https://google.com"
/// image : "https://taxi.jacksi.dev/storage/b380d0c9c8d0a609acc97187e81129fc/01.jpg"

BannersModel bannersModelFromJson(String str) => BannersModel.fromJson(json.decode(str));
String bannersModelToJson(BannersModel data) => json.encode(data.toJson());
class BannersModel {
  BannersModel({
      this.id, 
      this.title, 
      this.url, 
      this.image,});

  BannersModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    image = json['image'];
  }
  num? id;
  String? title;
  String? url;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['url'] = url;
    map['image'] = image;
    return map;
  }

}