import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:travel_tips_admin/src/core/domain/status.dart';
import 'package:travel_tips_admin/src/image_picker/repository/image_picker_repository.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc(this.imagePickerRepository)
      : super(const ImagePickerState()) {
    on<GalleryImagePicked>(_onGalleryImagePicked);
  }

  final ImagePickerRepository imagePickerRepository;

  Future<void> _onGalleryImagePicked(
    GalleryImagePicked event,
    Emitter<ImagePickerState> emit,
  ) async {
    try {
      emit(state.copyWith(storagePhotoStatus: Status.loading()));

      final pickedImage = await imagePickerRepository.getPhotoFromGallery();
      emit(
        state.copyWith(
          storagePhotoStatus: Status.success(),
          pickedImage: pickedImage,
        ),
      );
    } on Failure catch (f) {
      emit(state.copyWith(storagePhotoStatus: Status.failure(f)));
    }
  }
}
