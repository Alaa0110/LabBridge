import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<MyServices> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }


}
initialService() async {
  await Get.putAsync(() => MyServices().initialize());
}
