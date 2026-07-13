import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final rxThemeMode = ThemeMode.dark.obs;

  ThemeMode get themeMode => rxThemeMode.value;

  void setThemeMode(ThemeMode mode) {
    rxThemeMode.value = mode;
    Get.changeThemeMode(mode);
  }
}
