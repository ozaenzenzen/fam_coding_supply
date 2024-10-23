import 'dart:convert';
import 'package:flutter/foundation.dart';

class AppBase64ConverterHelper {
  // Function to decode Base64 string and return Uint8List on a background isolate
  Future<Uint8List> decodeBase64(String base64String) async {
    return await compute(_base64Decode, base64String);
  }

  // Helper function for decoding base64 to Uint8List
  Uint8List _base64Decode(String base64String) {
    return base64Decode(base64String);
  }

  // Function to encode a Uint8List to Base64 string on a background isolate
  Future<String> encodeBase64(Uint8List data) async {
    return await compute(_base64Encode, data);
  }

  // Helper function for encoding Uint8List to Base64 string
  String _base64Encode(Uint8List data) {
    return base64Encode(data);
  }
}
