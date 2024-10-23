import 'dart:convert';
import 'dart:io';

import 'package:fam_coding_supply/logic/app_logger.dart';
import 'package:image_picker/image_picker.dart';

class AppImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<String?> getImageAsBase64() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 10,
      );
      File fileFormat = File(image!.path);

      // Calculate the size in MB
      int sizeInBytes = await fileFormat.length();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      AppLogger.debugLog("Image Size MB: $sizeInMb");
      AppLogger.debugLog("Image Size KB: ${sizeInMb*1000}");

      String base64Image = base64Encode(fileFormat.readAsBytesSync());
      return base64Image;
    } catch (e) {
      return null;
    }
  }
}
