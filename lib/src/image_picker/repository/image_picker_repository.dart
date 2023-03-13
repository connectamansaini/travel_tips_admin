import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:travel_tips_admin/src/core/domain/status.dart';

class ImagePickerRepository {
  Future<File> getPhotoFromGallery() async {
    try {
      final picker = ImagePicker();
      final xFile = await picker.pickImage(source: ImageSource.gallery);
      if (xFile != null) {
        return File(xFile.path);
      }
      throw Failure.common('Failed to pick image.');
    } catch (e) {
      throw Failure.common(e.toString());
    }
  }
}
