import 'package:permission_handler/permission_handler.dart';
import 'package:travel_tips_admin/src/core/domain/enums.dart';

class PermissionRepository {
  Future<bool> isGalleryPermissionGranted() async {
    return Permission.storage.isGranted;
  }

  Future<GalleryPermissionStatus> requestGalleryPermission() async {
    final permission = await Permission.storage.request();
    if (permission.isLimited || permission.isGranted) {
      return GalleryPermissionStatus.granted;
    } else if (permission.isDenied) {
      return GalleryPermissionStatus.denied;
    } else {
      return GalleryPermissionStatus.permanentlyDenied;
    }
  }

  Future<void> openSetting() async {
    await openAppSettings();
  }
}
