import 'package:assignment_manabie/core/styles/style.dart';
import 'package:flutter/material.dart';

var colorHigh = Colors.redAccent;
var colorMedium = Colors.amber.shade700;
var colorCompleted = Colors.green;
var colorActive = const Color(0xFF00D72F);
var colorGreenLight = const Color(0xFF009E60);
var colorAttendance = const Color(0xFF0CCF4C);

Color mC = Colors.grey.shade100;
Color mCL = Colors.white;
Color mCM = Colors.grey.shade200;
Color mCH = Colors.grey.shade400;
Color mCD = Colors.black.withOpacity(0.075);
Color mCC = Colors.green.withOpacity(0.65);
Color fCD = Colors.grey.shade700;
Color fCL = Colors.grey;

class AppColors {
  final Color primary;
  final Color background;
  final Color accent;
  final Color disabled;
  final Color error;
  final Color divider;
  final Color header;
  final Color button;
  final Color contentText1;
  final Color contentText2;

  const AppColors({
    required this.header,
    required this.primary,
    required this.background,
    required this.accent,
    required this.disabled,
    required this.error,
    required this.divider,
    required this.button,
    required this.contentText1,
    required this.contentText2,
  });

  factory AppColors.light() {
    return AppColors(
      header: colorBlack,
      primary: const Color(0xFF1DA1F2),
      background: mC,
      accent: const Color(0xFF17c063),
      disabled: Colors.black12,
      error: const Color(0xFFFF7466),
      divider: Colors.black26,
      button: const Color(0xFF657786),
      contentText1: colorBlack,
      contentText2: colorPrimaryBlack,
    );
  }

  factory AppColors.dark() {
    return AppColors(
      header: Colors.white,
      primary: const Color(0xFF1DA1F2),
      background: const Color(0xFF14171A),
      accent: const Color(0xFF17c063),
      disabled: Colors.white12,
      error: const Color(0xFFFF5544),
      divider: Colors.white24,
      button: Colors.white,
      contentText1: mCL,
      contentText2: mCL,
    );
  }
}
