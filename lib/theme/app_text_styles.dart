import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskflow/theme/app_colors.dart';

/// Typographie TaskFlow — polices et tailles cohérentes.
abstract final class AppTextStyles {
  static TextStyle get _base => GoogleFonts.inter(color: AppColors.textPrimary);

  static TextStyle get displayLarge =>
      _base.copyWith(fontSize: 28, fontWeight: FontWeight.w700, height: 1.2);

  static TextStyle get headlineMedium =>
      _base.copyWith(fontSize: 20, fontWeight: FontWeight.w600, height: 1.3);

  static TextStyle get titleMedium =>
      _base.copyWith(fontSize: 16, fontWeight: FontWeight.w600, height: 1.4);

  static TextStyle get bodyLarge =>
      _base.copyWith(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5);

  static TextStyle get bodyMedium => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.textSecondary,
      );

  static TextStyle get labelLarge =>
      _base.copyWith(fontSize: 14, fontWeight: FontWeight.w600, height: 1.2);

  static TextStyle get button =>
      _base.copyWith(fontSize: 16, fontWeight: FontWeight.w600, height: 1.2);
}
