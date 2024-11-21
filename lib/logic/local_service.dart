import 'package:get_storage/get_storage.dart';

class LocalServiceCS {
  LocalServiceCS._();

  static final LocalServiceCS instance = LocalServiceCS._();

  final box = GetStorage();
}