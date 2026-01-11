import 'package:equatable/equatable.dart';

class AttributeParams extends Equatable {
  final int? id;
  final Map<String, String>? title;
  final bool? isRequired;
  final bool? isMultiple;
  final bool? isColor;

  const AttributeParams({
    required this.id,
    required this.title,
    this.isRequired,
    this.isMultiple,
    this.isColor,
  });

  factory AttributeParams.fromJson(Map<String, dynamic> map) => AttributeParams(
        id: map['id'],
        title: map['title'] != null ? Map<String, String>.from(map['title']) : null,
        isRequired: map['is_required'],
        isMultiple: map['is_multiple'],
        isColor: map['is_color'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "is_required": isRequired,
        "is_multiple": isMultiple,
        "is_color": isColor,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        isRequired,
        isMultiple,
        isColor,
      ];
}
