import 'package:flutter/material.dart';

class MediaQueryUtil {
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    screenWidth = mediaQuery.width;
    screenHeight = mediaQuery.height;
  }
}
