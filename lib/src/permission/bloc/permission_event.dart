part of 'permission_bloc.dart';

abstract class PermissionEvent {
  const PermissionEvent();
}

class GalleryPermissionRequested extends PermissionEvent {}
