import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fam_coding_supply/logic/app_logger.dart';

class AppFilePickerServiceCS {
  Future<File?> pickFiles({
    bool allowMultiples = false,
    int compressionQuality = 0,
    void Function(double sizeFileValue)? onSizeFile,
    void Function(String fileNameValue)? onFileName,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        compressionQuality: compressionQuality,
      );
      if (result != null) {
        File fileFormat = File(result.files.single.path!);
        
        String fileName = getFileName(fileFormat);
        onFileName?.call(fileName);

        double sizeFile = await calculateSizeWithValue(fileFormat);
        onSizeFile?.call(sizeFile);
        return fileFormat;
      } else {
        return null;
      }
    } catch (e) {
      AppLoggerCS.debugLog("[AppFilePickerServiceCS][pickFiles] $e");
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
    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp', '.heic', '.heif', '.tiff', '.tif', '.svg'];

    final lowerPath = path.toLowerCase();
    bool result = imageExtensions.any((ext) => lowerPath.endsWith(ext));
    // AppLoggerCS.debugLog("result: $result");
    return result;
  }

  Future<void> calculateSize(File fileFormat) async {
    // Calculate the size in MB
    int sizeInBytes = await fileFormat.length();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    AppLoggerCS.debugLog("File Size MB: $sizeInMb");
    AppLoggerCS.debugLog("File Size KB: ${sizeInMb * 1000}");
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
