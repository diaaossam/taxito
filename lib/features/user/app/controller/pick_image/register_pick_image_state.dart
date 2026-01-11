import 'package:flutter/material.dart';

@immutable
sealed class PickImageState {}

final class PickImageInitial extends PickImageState {}

class UploadEditImageLoading extends PickImageState {}

class UploadEditImageSuccess extends PickImageState {
  final String data;
  final String? type;
  final String ? path;

  UploadEditImageSuccess({required this.data, this.type,this.path});
}

class UploadEditImageFailure extends PickImageState {
  final String msg;

  UploadEditImageFailure({required this.msg});
}

class DeleteImageLoading extends PickImageState {}

class DeleteImageSuccess extends PickImageState {
  final String msg;

  DeleteImageSuccess({required this.msg});
}

class DeleteImageFailure extends PickImageState {
  final String msg;

  DeleteImageFailure({required this.msg});
}