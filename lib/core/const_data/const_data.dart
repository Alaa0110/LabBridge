// lib/const_data/const_data.dart
import 'package:get/get.dart';

class ConstData {
  static var isLoading = false.obs;
  static String token = "";
  static String map_key = "";
  static String companyCode = "";


  /*static Future<void> UpdateToken(String newToken) async {
    token = newToken;
    isLogin.value = true;
  }

  static Future<void> startTokenupdater() async {
    Timer.periodic(Duration(seconds: 20), (timer) {
      if (isLogin.value) {
        // تأكد من أنك تستخدم دالة لتحديث الـ Token هنا إذا كان لديك API يتيح لك ذلك
      }
    });
  }*/
}
