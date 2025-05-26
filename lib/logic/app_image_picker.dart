import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fam_coding_supply/logic/app_logger.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class AppImagePickerServiceCS {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> getImage({
    ImageSource imageSource = ImageSource.gallery,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    int imageQuality = 10,
    void Function(double sizeFileValue)? onSizeFile,
    void Function(String fileNameValue)? onFileName,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: imageSource,
        preferredCameraDevice: preferredCameraDevice,
        imageQuality: imageQuality,
      );
      File fileFormat = File(image!.path);

      String fileName = getFileName(fileFormat);
      onFileName?.call(fileName);

      double sizeFile = await calculateSizeWithValue(fileFormat);
      onSizeFile?.call(sizeFile);

      return image;
    } catch (e) {
      AppLoggerCS.debugLog("[AppImagePickerServiceCS][getImage] $e");
      return null;
    }
  }

  Future<String?> getImageAsBase64({
    ImageSource imageSource = ImageSource.gallery,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    int imageQuality = 10,
    void Function(double sizeFileValue)? onSizeFile,
    void Function(String fileNameValue)? onFileName,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: imageSource,
        preferredCameraDevice: preferredCameraDevice,
        imageQuality: imageQuality,
      );
      File fileFormat = File(image!.path);

      String fileName = getFileName(fileFormat);
      onFileName?.call(fileName);

      double sizeFile = await calculateSizeWithValue(fileFormat);
      onSizeFile?.call(sizeFile);

      String base64Image = base64Encode(fileFormat.readAsBytesSync());
      return base64Image;
    } catch (e) {
      AppLoggerCS.debugLog("[AppImagePickerServiceCS][getImageAsBase64] $e");
      return null;
    }
  }

  Future<File?> getImageAsFile({
    ImageSource imageSource = ImageSource.gallery,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    int imageQuality = 10,
    double? maxHeight,
    double? maxWidth,
    void Function(double sizeFileValue)? onSizeFile,
    void Function(String fileNameValue)? onFileName,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: imageSource,
        preferredCameraDevice: preferredCameraDevice,
        imageQuality: imageQuality,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
      );
      File fileFormat = File(image!.path);
      
      String fileName = getFileName(fileFormat);
      onFileName?.call(fileName);

      double sizeFile = await calculateSizeWithValue(fileFormat);
      onSizeFile?.call(sizeFile);

      return fileFormat;
    } catch (e) {
      AppLoggerCS.debugLog("[AppImagePickerServiceCS][getImageAsFile] $e");
      return null;
    }
  }

  Future<MultipartFile?> getImageAsMultipartFile({
    ImageSource imageSource = ImageSource.gallery,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    int imageQuality = 10,
    void Function(double sizeFileValue)? onSizeFile,
    void Function(String fileNameValue)? onFileName,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: imageSource,
        preferredCameraDevice: preferredCameraDevice,
        imageQuality: imageQuality,
        maxHeight: 400,
        maxWidth: 400,
      );
      File fileFormat = File(image!.path);

      String fileName = getFileName(fileFormat);
      onFileName?.call(fileName);

      double sizeFile = await calculateSizeWithValue(fileFormat);
      onSizeFile?.call(sizeFile);

      List<String> listSplitString = fileFormat.path.toString().split('/');

      MultipartFile multipartFile = await MultipartFile.fromFile(
        fileFormat.path,
        filename: listSplitString.last,
        contentType: MediaType('image', 'jpeg'),
      );

      return multipartFile;
    } catch (e) {
      return null;
    }
  }

  String getFileName(File fileFormat) {
    String fileName = fileFormat.path.split('/').last;
    AppLoggerCS.debugLog("[getFileName]: $fileName");
    return fileName;
  }

    String getExtensionFile(File fileFormat) {
    String fileName = (fileFormat.path.split('/').last).split('.').last;
    AppLoggerCS.debugLog("[getExtensionFile]: $fileName");
    return fileName;
  }

  String getExtensionFileFromPath(String filePath) {
    String fileName = (filePath.split('/').last).split('.').last;
    AppLoggerCS.debugLog("[getExtensionFileFromPath]: $fileName");
    return fileName;
  }

  bool isImageFile(String path) {
    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp', '.heic', '.heif', '.tiff', '.tif', '.svg', '.webpg'];

    final lowerPath = path.toLowerCase();
    bool result = imageExtensions.any((ext) => lowerPath.endsWith(ext));
    // AppLoggerCS.debugLog("result: $result");
    return result;
  }

  Future<void> calculateSize(File fileFormat) async {
    // Calculate the size in MB
    int sizeInBytes = await fileFormat.length();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    AppLoggerCS.debugLog("Image Size MB: $sizeInMb");
    AppLoggerCS.debugLog("Image Size KB: ${sizeInMb * 1000}");
  }

  Future<double> calculateSizeWithValue(File fileFormat) async {
    // Calculate the size in MB
    int sizeInBytes = await fileFormat.length();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    AppLoggerCS.debugLog("Image Size MB: $sizeInMb");
    AppLoggerCS.debugLog("Image Size KB: ${sizeInMb * 1000}");
    return sizeInMb;
  }
}
