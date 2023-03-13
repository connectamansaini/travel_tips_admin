part of 'image_picker_bloc.dart';

class ImagePickerState {
  const ImagePickerState({
    this.storagePhotoStatus = const StatusInitial(),
    this.pickedImage,
  });
  final Status storagePhotoStatus;
  final File? pickedImage;

  ImagePickerState copyWith({
    Status? storagePhotoStatus,
    File? pickedImage,
  }) {
    return ImagePickerState(
      storagePhotoStatus: storagePhotoStatus ?? this.storagePhotoStatus,
      pickedImage: pickedImage ?? this.pickedImage,
    );
  }
}
