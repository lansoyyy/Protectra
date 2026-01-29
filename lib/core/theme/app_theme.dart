import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// App Theme Configuration for Protectra
/// Provides light and dark theme configurations
class AppTheme {
  AppTheme._();

  // ==================== LIGHT THEME ====================

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: AppTextStyles.fontFamilyRegular,
      textTheme: _lightTextTheme,
      appBarTheme: _lightAppBarTheme,
      cardTheme: _lightCardThemeData,
      elevatedButtonTheme: _lightElevatedButtonTheme,
      outlinedButtonTheme: _lightOutlinedButtonTheme,
      textButtonTheme: _lightTextButtonTheme,
      inputDecorationTheme: _lightInputDecorationTheme,
      floatingActionButtonTheme: _lightFloatingActionButtonTheme,
      chipTheme: _lightChipTheme,
      bottomNavigationBarTheme: _lightBottomNavigationBarTheme,
      navigationBarTheme: _lightNavigationBarTheme,
      dividerTheme: _lightDividerTheme,
      dialogTheme: _lightDialogThemeData,
      bottomSheetTheme: _lightBottomSheetTheme,
      snackBarTheme: _lightSnackBarTheme,
      tabBarTheme: _lightTabBarThemeData,
      iconTheme: _lightIconTheme,
      primaryIconTheme: _lightIconTheme,
      listTileTheme: _lightListTileTheme,
      switchTheme: _lightSwitchTheme,
      checkboxTheme: _lightCheckboxTheme,
      radioTheme: _lightRadioTheme,
      sliderTheme: _lightSliderTheme,
      progressIndicatorTheme: _lightProgressIndicatorTheme,
    );
  }

  // ==================== DARK THEME ====================

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: _darkColorScheme,
      scaffoldBackgroundColor: AppColors.neutral900,
      fontFamily: AppTextStyles.fontFamilyRegular,
      textTheme: _darkTextTheme,
      appBarTheme: _darkAppBarTheme,
      cardTheme: _darkCardThemeData,
      elevatedButtonTheme: _darkElevatedButtonTheme,
      outlinedButtonTheme: _darkOutlinedButtonTheme,
      textButtonTheme: _darkTextButtonTheme,
      inputDecorationTheme: _darkInputDecorationTheme,
      floatingActionButtonTheme: _darkFloatingActionButtonTheme,
      chipTheme: _darkChipTheme,
      bottomNavigationBarTheme: _darkBottomNavigationBarTheme,
      navigationBarTheme: _darkNavigationBarTheme,
      dividerTheme: _darkDividerTheme,
      dialogTheme: _darkDialogThemeData,
      bottomSheetTheme: _darkBottomSheetTheme,
      snackBarTheme: _darkSnackBarTheme,
      tabBarTheme: _darkTabBarThemeData,
      iconTheme: _darkIconTheme,
      primaryIconTheme: _darkIconTheme,
      listTileTheme: _darkListTileTheme,
      switchTheme: _darkSwitchTheme,
      checkboxTheme: _darkCheckboxTheme,
      radioTheme: _darkRadioTheme,
      sliderTheme: _darkSliderTheme,
      progressIndicatorTheme: _darkProgressIndicatorTheme,
    );
  }

  // ==================== COLOR SCHEMES ====================

  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.textInverse,
    primaryContainer: AppColors.primarySurface,
    onPrimaryContainer: AppColors.primaryDark,
    secondary: AppColors.secondary,
    onSecondary: AppColors.textInverse,
    secondaryContainer: AppColors.secondarySurface,
    onSecondaryContainer: AppColors.secondaryDark,
    tertiary: AppColors.accent,
    onTertiary: AppColors.textInverse,
    tertiaryContainer: AppColors.accentSurface,
    onTertiaryContainer: AppColors.accentDark,
    error: AppColors.error,
    onError: AppColors.textInverse,
    errorContainer: AppColors.errorLight,
    onErrorContainer: AppColors.errorDark,
    outline: AppColors.border,
    outlineVariant: AppColors.borderLight,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    surfaceContainerHighest: AppColors.neutral100,
    onSurfaceVariant: AppColors.textSecondary,
    inverseSurface: AppColors.neutral800,
    onInverseSurface: AppColors.textInverse,
    inversePrimary: AppColors.primaryLight,
    shadow: AppColors.shadow,
    scrim: AppColors.overlay,
    surfaceTint: AppColors.primary,
  );

  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryLight,
    onPrimary: AppColors.textInverse,
    primaryContainer: AppColors.primaryDark,
    onPrimaryContainer: AppColors.primaryLight,
    secondary: AppColors.secondaryLight,
    onSecondary: AppColors.textInverse,
    secondaryContainer: AppColors.secondaryDark,
    onSecondaryContainer: AppColors.secondaryLight,
    tertiary: AppColors.accentLight,
    onTertiary: AppColors.textInverse,
    tertiaryContainer: AppColors.accentDark,
    onTertiaryContainer: AppColors.accentLight,
    error: AppColors.errorLight,
    onError: AppColors.textInverse,
    errorContainer: AppColors.errorDark,
    onErrorContainer: AppColors.errorLight,
    outline: AppColors.neutral600,
    outlineVariant: AppColors.neutral700,
    surface: AppColors.neutral800,
    onSurface: AppColors.textInverse,
    surfaceContainerHighest: AppColors.neutral700,
    onSurfaceVariant: AppColors.neutral400,
    inverseSurface: AppColors.neutral100,
    onInverseSurface: AppColors.textPrimary,
    inversePrimary: AppColors.primaryDark,
    shadow: AppColors.shadowDark,
    scrim: AppColors.overlay,
    surfaceTint: AppColors.primaryLight,
  );

  // ==================== TEXT THEMES ====================

  static TextTheme get _lightTextTheme {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    );
  }

  static TextTheme get _darkTextTheme {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(
        color: AppColors.textInverse,
      ),
      displayMedium: AppTextStyles.displayMedium.copyWith(
        color: AppColors.textInverse,
      ),
      displaySmall: AppTextStyles.displaySmall.copyWith(
        color: AppColors.textInverse,
      ),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(
        color: AppColors.textInverse,
      ),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(
        color: AppColors.textInverse,
      ),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(
        color: AppColors.textInverse,
      ),
      titleLarge: AppTextStyles.titleLarge.copyWith(
        color: AppColors.textInverse,
      ),
      titleMedium: AppTextStyles.titleMedium.copyWith(
        color: AppColors.textInverse,
      ),
      titleSmall: AppTextStyles.titleSmall.copyWith(
        color: AppColors.textInverse,
      ),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.neutral200),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.neutral300,
      ),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.neutral400),
      labelLarge: AppTextStyles.labelLarge.copyWith(
        color: AppColors.neutral200,
      ),
      labelMedium: AppTextStyles.labelMedium.copyWith(
        color: AppColors.neutral300,
      ),
      labelSmall: AppTextStyles.labelSmall.copyWith(
        color: AppColors.neutral400,
      ),
    );
  }

  // ==================== APP BAR THEME ====================

  static AppBarTheme get _lightAppBarTheme {
    return const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: false,
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
      actionsIconTheme: IconThemeData(color: AppColors.textSecondary),
      titleTextStyle: AppTextStyles.titleMedium,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  static AppBarTheme get _darkAppBarTheme {
    return const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: false,
      backgroundColor: AppColors.neutral800,
      foregroundColor: AppColors.textInverse,
      iconTheme: IconThemeData(color: AppColors.textInverse),
      actionsIconTheme: IconThemeData(color: AppColors.neutral400),
      titleTextStyle: AppTextStyles.titleMedium,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  // ==================== CARD THEME ====================

  static CardThemeData get _lightCardThemeData {
    return CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border, width: 1),
      ),
      color: AppColors.surface,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
    );
  }

  static CardThemeData get _darkCardThemeData {
    return CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.neutral700, width: 1),
      ),
      color: AppColors.neutral800,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
    );
  }

  // ==================== BUTTON THEMES ====================

  static ElevatedButtonThemeData get _lightElevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: AppTextStyles.buttonTextMedium,
        minimumSize: const Size(88, 44),
      ),
    );
  }

  static ElevatedButtonThemeData get _darkElevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: AppTextStyles.buttonTextMedium,
        minimumSize: const Size(88, 44),
      ),
    );
  }

  static OutlinedButtonThemeData get _lightOutlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        side: const BorderSide(color: AppColors.border, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: AppTextStyles.buttonTextMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        minimumSize: const Size(88, 44),
      ),
    );
  }

  static OutlinedButtonThemeData get _darkOutlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        side: const BorderSide(color: AppColors.neutral600, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: AppTextStyles.buttonTextMedium.copyWith(
          color: AppColors.textInverse,
        ),
        minimumSize: const Size(88, 44),
      ),
    );
  }

  static TextButtonThemeData get _lightTextButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: AppTextStyles.buttonTextMedium.copyWith(
          color: AppColors.primary,
        ),
        minimumSize: const Size(64, 36),
      ),
    );
  }

  static TextButtonThemeData get _darkTextButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: AppTextStyles.buttonTextMedium.copyWith(
          color: AppColors.primaryLight,
        ),
        minimumSize: const Size(64, 36),
      ),
    );
  }

  // ==================== INPUT DECORATION THEME ====================

  static InputDecorationTheme get _lightInputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundSecondary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.border, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.border, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderLight, width: 1),
      ),
      labelStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textSecondary,
      ),
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textTertiary,
      ),
      errorStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
      helperStyle: AppTextStyles.bodySmall.copyWith(
        color: AppColors.textTertiary,
      ),
      floatingLabelStyle: AppTextStyles.labelMedium.copyWith(
        color: AppColors.primary,
      ),
    );
  }

  static InputDecorationTheme get _darkInputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.neutral700,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.neutral600, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.neutral600, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.errorLight, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.errorLight, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.neutral700, width: 1),
      ),
      labelStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.neutral400,
      ),
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.neutral500),
      errorStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.errorLight),
      helperStyle: AppTextStyles.bodySmall.copyWith(
        color: AppColors.neutral500,
      ),
      floatingLabelStyle: AppTextStyles.labelMedium.copyWith(
        color: AppColors.primaryLight,
      ),
    );
  }

  // ==================== FLOATING ACTION BUTTON THEME ====================

  static FloatingActionButtonThemeData get _lightFloatingActionButtonTheme {
    return const FloatingActionButtonThemeData(
      elevation: 4,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textInverse,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      iconSize: 24,
    );
  }

  static FloatingActionButtonThemeData get _darkFloatingActionButtonTheme {
    return const FloatingActionButtonThemeData(
      elevation: 4,
      backgroundColor: AppColors.primaryLight,
      foregroundColor: AppColors.textInverse,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      iconSize: 24,
    );
  }

  // ==================== CHIP THEME ====================

  static ChipThemeData get _lightChipTheme {
    return ChipThemeData(
      backgroundColor: AppColors.backgroundSecondary,
      deleteIconColor: AppColors.textSecondary,
      disabledColor: AppColors.neutral200,
      selectedColor: AppColors.primarySurface,
      secondarySelectedColor: AppColors.primarySurface,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: AppTextStyles.labelMedium,
      secondaryLabelStyle: AppTextStyles.labelMedium,
      brightness: Brightness.light,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.border, width: 1),
      ),
    );
  }

  static ChipThemeData get _darkChipTheme {
    return ChipThemeData(
      backgroundColor: AppColors.neutral700,
      deleteIconColor: AppColors.neutral400,
      disabledColor: AppColors.neutral600,
      selectedColor: AppColors.primaryDark,
      secondarySelectedColor: AppColors.primaryDark,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: AppTextStyles.labelMedium.copyWith(
        color: AppColors.neutral200,
      ),
      secondaryLabelStyle: AppTextStyles.labelMedium.copyWith(
        color: AppColors.neutral200,
      ),
      brightness: Brightness.dark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.neutral600, width: 1),
      ),
    );
  }

  // ==================== BOTTOM NAVIGATION BAR THEME ====================

  static BottomNavigationBarThemeData get _lightBottomNavigationBarTheme {
    return const BottomNavigationBarThemeData(
      elevation: 8,
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textTertiary,
      selectedLabelStyle: AppTextStyles.labelSmall,
      unselectedLabelStyle: AppTextStyles.labelSmall,
      type: BottomNavigationBarType.fixed,
    );
  }

  static BottomNavigationBarThemeData get _darkBottomNavigationBarTheme {
    return const BottomNavigationBarThemeData(
      elevation: 8,
      backgroundColor: AppColors.neutral800,
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: AppColors.neutral500,
      selectedLabelStyle: AppTextStyles.labelSmall,
      unselectedLabelStyle: AppTextStyles.labelSmall,
      type: BottomNavigationBarType.fixed,
    );
  }

  // ==================== NAVIGATION BAR THEME ====================

  static NavigationBarThemeData get _lightNavigationBarTheme {
    return NavigationBarThemeData(
      elevation: 0,
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.primarySurface,
      labelTextStyle: WidgetStatePropertyAll(AppTextStyles.labelSmall),
      iconTheme: WidgetStatePropertyAll(
        IconThemeData(color: AppColors.textTertiary),
      ),
    );
  }

  static NavigationBarThemeData get _darkNavigationBarTheme {
    return NavigationBarThemeData(
      elevation: 0,
      backgroundColor: AppColors.neutral800,
      indicatorColor: AppColors.primaryDark,
      labelTextStyle: WidgetStatePropertyAll(
        AppTextStyles.labelSmall.copyWith(color: AppColors.neutral200),
      ),
      iconTheme: WidgetStatePropertyAll(
        IconThemeData(color: AppColors.neutral500),
      ),
    );
  }

  // ==================== DIVIDER THEME ====================

  static DividerThemeData get _lightDividerTheme {
    return const DividerThemeData(
      color: AppColors.border,
      thickness: 1,
      space: 1,
    );
  }

  static DividerThemeData get _darkDividerTheme {
    return const DividerThemeData(
      color: AppColors.neutral700,
      thickness: 1,
      space: 1,
    );
  }

  // ==================== DIALOG THEME ====================

  static DialogThemeData get _lightDialogThemeData {
    return DialogThemeData(
      elevation: 8,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: AppTextStyles.titleLarge,
      contentTextStyle: AppTextStyles.bodyMedium,
    );
  }

  static DialogThemeData get _darkDialogThemeData {
    return DialogThemeData(
      elevation: 8,
      backgroundColor: AppColors.neutral800,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: AppTextStyles.titleLarge.copyWith(
        color: AppColors.textInverse,
      ),
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.neutral200,
      ),
    );
  }

  // ==================== BOTTOM SHEET THEME ====================

  static BottomSheetThemeData get _lightBottomSheetTheme {
    return BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      modalBackgroundColor: AppColors.surface,
      modalElevation: 8,
    );
  }

  static BottomSheetThemeData get _darkBottomSheetTheme {
    return BottomSheetThemeData(
      backgroundColor: AppColors.neutral800,
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      modalBackgroundColor: AppColors.neutral800,
      modalElevation: 8,
    );
  }

  // ==================== SNACK BAR THEME ====================

  static SnackBarThemeData get _lightSnackBarTheme {
    return SnackBarThemeData(
      backgroundColor: AppColors.neutral800,
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textInverse,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    );
  }

  static SnackBarThemeData get _darkSnackBarTheme {
    return SnackBarThemeData(
      backgroundColor: AppColors.neutral700,
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textInverse,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    );
  }

  // ==================== TAB BAR THEME ====================

  static TabBarThemeData get _lightTabBarThemeData {
    return const TabBarThemeData(
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.textTertiary,
      labelStyle: AppTextStyles.labelMedium,
      unselectedLabelStyle: AppTextStyles.labelMedium,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
    );
  }

  static TabBarThemeData get _darkTabBarThemeData {
    return const TabBarThemeData(
      labelColor: AppColors.primaryLight,
      unselectedLabelColor: AppColors.neutral500,
      labelStyle: AppTextStyles.labelMedium,
      unselectedLabelStyle: AppTextStyles.labelMedium,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.primaryLight, width: 2),
      ),
    );
  }

  // ==================== ICON THEME ====================

  static const IconThemeData _lightIconTheme = IconThemeData(
    color: AppColors.textSecondary,
    size: 24,
  );

  static const IconThemeData _darkIconTheme = IconThemeData(
    color: AppColors.neutral400,
    size: 24,
  );

  // ==================== LIST TILE THEME ====================

  static ListTileThemeData get _lightListTileTheme {
    return const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      titleTextStyle: AppTextStyles.bodyMedium,
      subtitleTextStyle: AppTextStyles.bodySmall,
      iconColor: AppColors.textSecondary,
    );
  }

  static ListTileThemeData get _darkListTileTheme {
    return ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      titleTextStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.neutral200,
      ),
      subtitleTextStyle: AppTextStyles.bodySmall.copyWith(
        color: AppColors.neutral400,
      ),
      iconColor: AppColors.neutral400,
    );
  }

  // ==================== SWITCH THEME ====================

  static SwitchThemeData get _lightSwitchTheme {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.neutral400;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryLight;
        }
        return AppColors.neutral300;
      }),
    );
  }

  static SwitchThemeData get _darkSwitchTheme {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryLight;
        }
        return AppColors.neutral600;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryDark;
        }
        return AppColors.neutral700;
      }),
    );
  }

  // ==================== CHECKBOX THEME ====================

  static CheckboxThemeData get _lightCheckboxTheme {
    return CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(AppColors.textInverse),
      side: const BorderSide(color: AppColors.border, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }

  static CheckboxThemeData get _darkCheckboxTheme {
    return CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryLight;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(AppColors.textInverse),
      side: const BorderSide(color: AppColors.neutral600, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }

  // ==================== RADIO THEME ====================

  static RadioThemeData get _lightRadioTheme {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return Colors.transparent;
      }),
    );
  }

  static RadioThemeData get _darkRadioTheme {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryLight;
        }
        return Colors.transparent;
      }),
    );
  }

  // ==================== SLIDER THEME ====================

  static SliderThemeData get _lightSliderTheme {
    return SliderThemeData(
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.neutral200,
      thumbColor: AppColors.primary,
      overlayColor: AppColors.primaryLight.withValues(alpha: 0.12),
      valueIndicatorColor: AppColors.primary,
      valueIndicatorTextStyle: AppTextStyles.labelMedium.copyWith(
        color: AppColors.textInverse,
      ),
      trackHeight: 4,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
    );
  }

  static SliderThemeData get _darkSliderTheme {
    return SliderThemeData(
      activeTrackColor: AppColors.primaryLight,
      inactiveTrackColor: AppColors.neutral600,
      thumbColor: AppColors.primaryLight,
      overlayColor: AppColors.primaryLight.withValues(alpha: 0.12),
      valueIndicatorColor: AppColors.primaryLight,
      valueIndicatorTextStyle: AppTextStyles.labelMedium.copyWith(
        color: AppColors.textInverse,
      ),
      trackHeight: 4,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
    );
  }

  // ==================== PROGRESS INDICATOR THEME ====================

  static ProgressIndicatorThemeData get _lightProgressIndicatorTheme {
    return const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.neutral200,
      circularTrackColor: AppColors.neutral200,
    );
  }

  static ProgressIndicatorThemeData get _darkProgressIndicatorTheme {
    return const ProgressIndicatorThemeData(
      color: AppColors.primaryLight,
      linearTrackColor: AppColors.neutral600,
      circularTrackColor: AppColors.neutral600,
    );
  }
}
