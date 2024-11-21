import 'dart:convert';
import 'dart:io';

import 'package:fam_coding_supply/logic/app_logger.dart';
import 'package:image_picker/image_picker.dart';

class AppImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> getImage({
    ImageSource imageSource = ImageSource.gallery,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: imageSource,
        preferredCameraDevice: preferredCameraDevice,
        imageQuality: 10,
      );
      File fileFormat = File(image!.path);

      await calculateSize(fileFormat);

      return image;
    } catch (e) {
      AppLoggerCS.debugLog("[AppImagePickerService][getImage] $e");
      return null;
    }
  }

  Future<String?> getImageAsBase64({
    ImageSource imageSource = ImageSource.gallery,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: imageSource,
        preferredCameraDevice: preferredCameraDevice,
        imageQuality: 10,
      );
      File fileFormat = File(image!.path);

      await calculateSize(fileFormat);

      String base64Image = base64Encode(fileFormat.readAsBytesSync());
      return base64Image;
    } catch (e) {
      AppLoggerCS.debugLog("[AppImagePickerService][getImageAsBase64] $e");
      return null;
    }
  }

  Future<File?> getImageAsFile({
    ImageSource imageSource = ImageSource.gallery,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: imageSource,
        preferredCameraDevice: preferredCameraDevice,
        imageQuality: 10,
        maxHeight: 400,
        maxWidth: 400,
      );
      File fileFormat = File(image!.path);

      await calculateSize(fileFormat);

      return fileFormat;
    } catch (e) {
      AppLoggerCS.debugLog("[AppImagePickerService][getImageAsFile] $e");
      return null;
    }
  }

  Future<void> calculateSize(File fileFormat) async {
    // Calculate the size in MB
    int sizeInBytes = await fileFormat.length();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    AppLoggerCS.debugLog("Image Size MB: $sizeInMb");
    AppLoggerCS.debugLog("Image Size KB: ${sizeInMb * 1000}");
  }
}
