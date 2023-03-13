import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:travel_tips_admin/src/core/domain/enums.dart';
import 'package:travel_tips_admin/src/permission/repository/permission_repository.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc(this.permissionRepository) : super(PermissionState()) {
    on<GalleryPermissionRequested>(_onGalleryPermissionRequested);
  }
  final PermissionRepository permissionRepository;

  Future<void> _onGalleryPermissionRequested(
    GalleryPermissionRequested event,
    Emitter<PermissionState> emit,
  ) async {
    final isGranted = await permissionRepository.isGalleryPermissionGranted();

    if (isGranted) {
      emit(
        state.copyWith(
          galleryPermissionStatus: GalleryPermissionStatus.granted,
        ),
      );
    } else {
      final currentStatus =
          await permissionRepository.requestGalleryPermission();
      emit(state.copyWith(galleryPermissionStatus: currentStatus));
    }
  }
}
