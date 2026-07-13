import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../features/portfolio/presentation/controllers/theme_controller.dart';

class AppColors {
  static bool get isDark {
    try {
      if (Get.isRegistered<ThemeController>()) {
        final themeCtrl = Get.find<ThemeController>();
        if (themeCtrl.themeMode == ThemeMode.system) {
          return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
        }
        return themeCtrl.themeMode == ThemeMode.dark;
      }
    } catch (_) {}
    return true; // Default to dark mode
  }

  // Dark Backgrounds
  static Color get backgroundStart => isDark ? const Color(0xFF0D0B08) : const Color(0xFFFFFDF9);
  static Color get backgroundEnd => isDark ? const Color(0xFF050505) : const Color(0xFFF5F2EB);
  static Color get surfaceColor => isDark ? const Color(0xFF171412) : const Color(0xFFFFFFFF);

  // Neon accents (Orange & shades of orange)
  static Color get primary => const Color(0xFFFF6B00);
  static Color get secondary => isDark ? const Color(0xFFFF9E40) : const Color(0xFFE65100);
  static Color get accentGlow => isDark ? const Color(0xFFFFD180) : const Color(0xFFFFB74D);

  // Text colors
  static Color get textPrimary => isDark ? const Color(0xFFFFFBF7) : const Color(0xFF1A1612);
  static Color get textSecondary => isDark ? const Color(0xFFAFA090) : const Color(0xFF6E6050);

  // Utility colors
  static Color get glassBorder => isDark ? const Color(0x28FF6B00) : const Color(0xFFE2E2E2);
  static Color get glassBackground => isDark ? const Color(0x0CFFFFFF) : const Color(0xFFFFFFFF);

  // Dark/Light toggle
  static Color get cardBg => isDark ? const Color(0xFF1F1A15) : const Color(0xFFFFFDF9);
  static const Color activeGreen = Color(0xFF10B981);
}
