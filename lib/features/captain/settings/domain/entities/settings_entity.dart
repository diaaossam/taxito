import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsEntity extends Equatable {
  final int id;
  final String title;
  final String? image;
  final VoidCallback press;
  final Color? iconColor;
  final Widget? widget;

  const SettingsEntity({
    required this.id,
    required this.title,
    this.image,
    required this.press,
    this.widget,
    this.iconColor,
  });

  @override
  List<Object?> get props => [id, title, image, press, iconColor, widget];
}
