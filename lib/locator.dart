import 'package:get/get.dart';
import 'package:tap_bonds/core/services/api_service.dart';

class Locator {
  static void init() {
    Get.put(ApiService(), permanent: true);
  }
}
