import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class AppImageLoading extends StatelessWidget {
  final int? size;

  const AppImageLoading({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: BlurHash(
        imageFit: BoxFit.cover,
        hash: 'L@IY97M{M_of~qRjRjax-.j[t8WB',
        decodingHeight: size ?? 50,
        decodingWidth: size ?? 50,
      ),
    );
  }
}
