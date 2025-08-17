import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageUtil {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImage({
    ImageSource source = ImageSource.gallery,
  }) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  static Future<List<XFile>?> pickImages() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage();

    if (selectedImages.isNotEmpty) {
      return selectedImages;
    }
    return null;
  }
}
