part of 'permission_bloc.dart';

class PermissionState {
  PermissionState({
    this.galleryPermissionStatus = GalleryPermissionStatus.initial,
  });

  final GalleryPermissionStatus galleryPermissionStatus;

  PermissionState copyWith({
    GalleryPermissionStatus? galleryPermissionStatus,
  }) {
    return PermissionState(
      galleryPermissionStatus:
          galleryPermissionStatus ?? this.galleryPermissionStatus,
    );
  }
}
