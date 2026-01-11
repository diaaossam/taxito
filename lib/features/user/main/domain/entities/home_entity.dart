import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HomeEntity extends Equatable {
  final int id;
  final String title;
  final String icon;
  final VoidCallback onPress;

  const HomeEntity({
    required this.id,
    required this.title,
    required this.icon,
    required this.onPress,
  });

  @override
  List<Object> get props => [
        id,
        title,
        icon,
        onPress,
      ];

  static List<HomeEntity> staticHomeList({required BuildContext context}) {
    return [

    ];
  }
}
