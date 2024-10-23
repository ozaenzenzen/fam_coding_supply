import 'package:get_storage/get_storage.dart';

class LocalService {
  LocalService._();

  static final LocalService instance = LocalService._();

  final box = GetStorage();
}