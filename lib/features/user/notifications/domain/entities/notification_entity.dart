import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String? title;
  final String? description;
  final String? image;
  final bool isRead;
  final DateTime? createdAt;
  final String? metaName;

  const NotificationEntity(
      {required this.id,
      required this.title,
      required this.description,
      this.image,
      this.metaName,
      this.isRead = false,
      this.createdAt});

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        image,
        isRead,
        metaName,
        createdAt,
      ];
}
