import 'package:flutter/material.dart';
import 'app_colors.dart';

/// App Text Styles for Protectra
/// Using Urbanist font family
class AppTextStyles {
  AppTextStyles._();

  // Font Family Names
  static const String fontFamilyRegular = 'Regular';
  static const String fontFamilyMedium = 'Medium';
  static const String fontFamilyBold = 'Bold';

  // ==================== HEADINGS ====================

  // Display - Extra Large
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamilyBold,
    fontSize: 57,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    color: AppColors.textPrimary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamilyBold,
    fontSize: 45,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFamilyBold,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  // Headline - Large
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamilyBold,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamilyBold,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamilyBold,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  // Title - Medium
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamilyBold,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamilyMedium,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamilyMedium,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  // ==================== BODY ====================

  // Body - Regular text
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamilyRegular,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamilyRegular,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamilyRegular,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.textPrimary,
  );

  // ==================== LABEL ====================

  // Label - Small text for buttons, tags, etc.
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamilyMedium,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamilyMedium,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamilyMedium,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  // ==================== SEMANTIC TEXT STYLES ====================

  // Primary Text
  static const TextStyle textPrimary = TextStyle(
    fontFamily: fontFamilyRegular,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  // Secondary Text
  static const TextStyle textSecondary = TextStyle(
    fontFamily: fontFamilyRegular,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // Tertiary Text
  static const TextStyle textTertiary = TextStyle(
    fontFamily: fontFamilyRegular,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
  );

  // Disabled Text
  static const TextStyle textDisabled = TextStyle(
    fontFamily: fontFamilyRegular,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textDisabled,
  );

  // ==================== BUTTON TEXT STYLES ====================

  static const TextStyle buttonTextLarge = TextStyle(
    fontFamily: fontFamilyMedium,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.textInverse,
  );

  static const TextStyle buttonTextMedium = TextStyle(
    fontFamily: fontFamilyMedium,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.textInverse,
  );

  static const TextStyle buttonTextSmall = TextStyle(
    fontFamily: fontFamilyMedium,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.textInverse,
  );

  // ==================== LINK TEXT STYLES ====================

  static const TextStyle link = TextStyle(
    fontFamily: fontFamilyMedium,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );

  static const TextStyle linkSmall = TextStyle(
    fontFamily: fontFamilyMedium,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );

  // ==================== CAPTION TEXT STYLES ====================

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamilyRegular,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.textSecondary,
  );

  static const TextStyle captionBold = TextStyle(
    fontFamily: fontFamilyMedium,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.4,
    color: AppColors.textSecondary,
  );

  // ==================== OVERLINE TEXT STYLES ====================

  static const TextStyle overline = TextStyle(
    fontFamily: fontFamilyMedium,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    color: AppColors.textTertiary,
  );

  // ==================== CODE TEXT STYLES ====================

  static const TextStyle code = TextStyle(
    fontFamily: 'Courier',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0,
  );

  // ==================== HELPER METHODS ====================

  /// Get text style with custom color
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Get text style with custom font weight
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  /// Get text style with custom font size
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  /// Get text style with custom letter spacing
  static TextStyle withLetterSpacing(TextStyle style, double spacing) {
    return style.copyWith(letterSpacing: spacing);
  }

  /// Get text style with custom height (line height)
  static TextStyle withHeight(TextStyle style, double height) {
    return style.copyWith(height: height);
  }

  /// Get text style with custom decoration
  static TextStyle withDecoration(TextStyle style, TextDecoration decoration) {
    return style.copyWith(decoration: decoration);
  }

  /// Get text style with multiple customizations
  static TextStyle customize({
    required TextStyle base,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
  }) {
    return base.copyWith(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
    );
  }
}

/// Extension for easy text style access
extension AppTextStyleExtension on BuildContext {
  /// Get the current text theme
  TextTheme get textTheme => Theme.of(this).textTheme;
}
