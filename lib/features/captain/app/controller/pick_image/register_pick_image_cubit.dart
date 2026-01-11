import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/features/captain/app/domain/use_case/delete_image_use_case.dart';

import '../../domain/use_case/upload_image_use_case.dart';
import 'register_pick_image_state.dart';

@LazySingleton()
class PickImageCubit extends Cubit<PickImageState> {
  final UploadImageUseCase uploadImageUseCase;
  final DeleteImageUseCase deleteImageUseCase;

  PickImageCubit(this.uploadImageUseCase, this.deleteImageUseCase)
    : super(PickImageInitial());

  Future<void> uploadImage({
    required File file,
    String? faceType,
    String? path,
  }) async {
    emit(UploadEditImageLoading());
    final response = await uploadImageUseCase(file: file);
    emit(
      response.fold(
        (l) => UploadEditImageFailure(msg: l.msg),
        (r) => UploadEditImageSuccess(data: r, type: faceType, path: path),
      ),
    );
  }

  Future<void> deleteImage({required int id}) async {
    emit(DeleteImageLoading());
    final response = await deleteImageUseCase(id: id);
    emit(
      response.fold(
        (l) => DeleteImageFailure(msg: l.msg),
        (r) => DeleteImageSuccess(msg: r.message ?? ""),
      ),
    );
  }
}
