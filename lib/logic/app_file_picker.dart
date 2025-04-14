import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fam_coding_supply/logic/app_logger.dart';

class AppFilePickerServiceCS {
  Future<File?> pickFiles({
    bool allowMultiples = false,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
        await calculateSize(file);
        return file;
      } else {
        return null;
      }
    } catch (e) {
      AppLoggerCS.debugLog("[AppImagePickerServiceCS][pickFiles] $e");
      return null;
    }
  }

  Future<void> calculateSize(File fileFormat) async {
    // Calculate the size in MB
    int sizeInBytes = await fileFormat.length();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    AppLoggerCS.debugLog("File Size MB: $sizeInMb");
    AppLoggerCS.debugLog("File Size KB: ${sizeInMb * 1000}");
  }
}
