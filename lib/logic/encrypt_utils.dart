import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:hex/hex.dart';
// ignore: depend_on_referenced_packages
import 'package:pointycastle/asymmetric/api.dart';
// ignore: depend_on_referenced_packages
import 'package:pointycastle/digests/sha1.dart';

export 'package:hex/hex.dart';

enum AsymmetricEncode { hex, base64 }

class EncryptUtils {
  /// Encrypt data with pin
  String encrypt({required dynamic data, required String pin}) {
    if (pin.length > 32) {
      pin = pin.substring(0, 32);
    }
    pin = pin.padRight(32, "Y");
    final key = Key(Uint8List.fromList(pin.codeUnits.sublist(0, 32)));
    final iv = IV.fromBase64(base64Encode(pin.codeUnits.sublist(0, 16)));

    final encryptor = Encrypter(AES(key));

    final encrypted = encryptor.encryptBytes(utf8.encode(json.encode(data)), iv: iv);

    return encrypted.base64;
  }

  /// Encrypt with RSA
  String encryptAsymmetric({required String data, required String publicKey, RSAEncoding encoding = RSAEncoding.PKCS1, AsymmetricEncode encode = AsymmetricEncode.hex}) {
    RSAPublicKey rsaPublicKey = RSAKeyParser().parse(publicKey) as RSAPublicKey;
    var defHash = Uint8List(SHA1Digest().digestSize);
    int inputBlockSize = ((rsaPublicKey.modulus!.bitLength + 7) ~/ 8) - 1;
    inputBlockSize = inputBlockSize - 1 - 2 * defHash.length;

    final encryptor = RSA(publicKey: rsaPublicKey, encoding: encoding);

    List<int> newData = [];
    List<int> result = [];
    while (newData.length != data.length) {
      List<int> processingData = data.codeUnits.sublist(newData.length);
      if (processingData.length > inputBlockSize) {
        processingData = processingData.sublist(0, inputBlockSize);
      }

      final encrypted = encryptor.encrypt(Uint8List.fromList(processingData));
      result.addAll(encrypted.bytes);
      newData.addAll(processingData);
    }

    final encrypted = Encrypted(Uint8List.fromList(result));
    if (encode == AsymmetricEncode.hex) {
      return const HexEncoder().convert(encrypted.bytes);
    } else {
      return encrypted.base64;
    }
  }

  /// Encrypt data with random pin
  String encryptRandom({required dynamic data}) {
    final rand = _generateRandomString(8);
    final encrypted = encrypt(data: data, pin: rand);
    data = secureEncode(data: rand, mask: encrypted);
    return data;
  }

  /// Decrypt data with pin
  dynamic decrypt({required String encrypted, required String pin}) {
    if (pin.length > 32) {
      pin = pin.substring(0, 32);
    }
    pin = pin.padRight(32, "Y");
    final key = Key(Uint8List.fromList(pin.codeUnits.sublist(0, 32)));
    final iv = IV.fromBase64(base64Encode(pin.codeUnits.sublist(0, 16)));

    final encryptor = Encrypter(AES(key));

    var decryptBytes = encryptor.decryptBytes(Encrypted.from64(encrypted), iv: iv);
    var decryptUtf8 = utf8.decode(decryptBytes);

    final decrypted = json.decode(decryptUtf8);

    return decrypted;
  }

  /// Decrypt with RSA
  String decryptAsymmetric({required String encrypted, required String privateKey, RSAEncoding encoding = RSAEncoding.PKCS1, AsymmetricEncode encode = AsymmetricEncode.hex}) {
    RSAPrivateKey rsaPrivateKey = RSAKeyParser().parse(privateKey) as RSAPrivateKey;
    int inputBlockSize = ((rsaPrivateKey.modulus!.bitLength + 7) ~/ 8);

    final encryptor = RSA(privateKey: rsaPrivateKey, encoding: encoding);

    var data = Encrypted.from64(
      encode == AsymmetricEncode.base64 ? encrypted : base64Encode(const HexDecoder().convert(encrypted)),
    ).bytes;
    List<int> newData = [];
    List<int> result = [];
    while (newData.length != data.length) {
      List<int> processingData = data.sublist(newData.length);
      if (processingData.length > inputBlockSize) {
        processingData = processingData.sublist(0, inputBlockSize);
      }

      final decrypted = encryptor.decrypt(Encrypted(Uint8List.fromList(processingData)));
      result.addAll(decrypted);
      newData.addAll(processingData);
    }
    final decrypted = utf8.decode(result);
    return decrypted;
  }

  /// Decrypt data that encrypted with encryptRandom function
  dynamic decryptRandom({required String data}) {
    var rand = secureDecode(data);
    data = getOriginalText(data);
    var decrypted = decrypt(encrypted: data, pin: rand);
    return decrypted;
  }

  /// Encode data with steganography
  String encode({required String data, String mask = ""}) {
    var result = mask;
    var stegBinary = _convertToBinary(data);
    if (mask.isEmpty) {
      result = stegBinary;
    }
    var insertionArr = _randInsert(mask.length, data.length);
    var binaryIdx = 0;
    for (var i in insertionArr) {
      var idx = binaryIdx + i;
      if (stegBinary[binaryIdx] == "1") {
        result = _strInsert(result, '\u200d', idx);
      } else {
        result = _strInsert(result, '\u200c', idx);
      }
      binaryIdx++;
    }
    return result;
  }

  /// Encode data with steganography securely.
  String secureEncode({required String data, String mask = ""}) {
    String dict = (mask + data).trim().replaceAll(" ", "");
    String password = "";
    while (password.length < 32) {
      password += dict[Random.secure().nextInt(dict.length)];
    }

    var encrypted = encrypt(data: data, pin: password);

    var encoded = encode(data: encrypted + password, mask: mask);

    return encoded;
  }

  /// Decode data with steganography.
  String decode(String str) {
    var chars = str.split("");
    var bytes = [];
    var buffer = "";
    for (var i = 0; i < chars.length; ++i) {
      if (chars[i] == '\u200d') {
        buffer += '1';
      } else if (chars[i] == '\u200c') {
        buffer += '0';
      }
      // Push to bytes if a byte is complete.
      if (buffer.length == 8) {
        bytes.add(buffer);
        buffer = '';
      }
    }

    for (var j = 0; j < bytes.length; ++j) {
      bytes[j] = int.parse(bytes[j], radix: 2);
    }
    for (var k = 0; k < bytes.length; ++k) {
      bytes[k] = String.fromCharCode(bytes[k]);
    }

    return bytes.join();
  }

  /// Decode data with steganograpy that encoded with secureEncode function.
  String secureDecode(String str) {
    var decoded = decode(str);
    var keyValue = MapEntry(decoded.substring(decoded.length - 32), decoded.substring(0, decoded.length - 32));

    decoded = decrypt(encrypted: keyValue.value, pin: keyValue.key);
    return decoded;
  }

  /// Get masking text of steganography.
  String getOriginalText(String str) {
    return str.replaceAll('\u200d', '').replaceAll('\u200c', '');
  }

  /// Sign data with RSA
  String sign({
    required String data,
    required String privateKey,
    AsymmetricEncode encode = AsymmetricEncode.hex,
  }) {
    RSAPrivateKey rsaPrivateKey = RSAKeyParser().parse(privateKey) as RSAPrivateKey;

    Signer signer = Signer(RSASigner(RSASignDigest.SHA256, privateKey: rsaPrivateKey));
    final signed = signer.sign(data);
    if (encode == AsymmetricEncode.hex) {
      return const HexEncoder().convert(signed.bytes);
    } else {
      return signed.base64;
    }
  }

  /// Verify digned data with RSA
  bool verify({
    required String signed,
    required String data,
    required String publicKey,
    AsymmetricEncode encode = AsymmetricEncode.hex,
  }) {
    RSAPublicKey rsaPublicKey = RSAKeyParser().parse(publicKey) as RSAPublicKey;

    Signer signer = Signer(RSASigner(RSASignDigest.SHA256, publicKey: rsaPublicKey));
    return signer.verify(
      data,
      Encrypted.from64(
        encode == AsymmetricEncode.base64 ? signed : base64Encode(const HexDecoder().convert(signed)),
      ),
    );
  }

  List<int> _randInsert(int textLen, int stegLen) {
    List<int> indices = [];
    var numStegBits = stegLen * 8;
    while (numStegBits > 0) {
      var randIdx = (Random().nextDouble() * textLen).floor();
      indices.add(randIdx);
      --numStegBits;
    }

    indices.sort((x, y) => x - y);
    return indices;
  }

  String _convertToBinary(String str) {
    var chars = str.split("");
    var output = [];
    for (var idx in chars) {
      var binary = idx.codeUnits.map((x) => x.toRadixString(2).padLeft(8, '0')).join();
      output.add(binary);
    }
    return output.join();
  }

  String _strInsert(String orig, String insert, int idx) {
    return [orig.substring(0, idx), insert, orig.substring(idx)].join();
  }

  String _generateRandomString(int len) {
    var r = Random();
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }
}
