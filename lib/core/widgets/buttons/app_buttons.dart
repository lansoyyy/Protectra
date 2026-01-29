import 'package:flutter/material.dart';
import '../../theme/app_text_styles.dart';

/// Custom Primary Button for SiProtectrambayanan
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.isLoading = false,
    this.isEnabled = true,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.borderRadius,
    this.elevation,
  });

  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final IconData? icon;
  final IconPosition iconPosition;
  final bool isLoading;
  final bool isEnabled;
  final ButtonVariant variant;
  final ButtonSize size;
  final double? borderRadius;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle();
    final padding = _getPadding();
    final borderRadiusValue = borderRadius ?? _getBorderRadius();

    Widget buttonChild = _buildButtonContent();

    if (isLoading) {
      buttonChild = SizedBox(
        height: _getIconSize(),
        width: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(_getTextColor(context)),
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height ?? _getHeight(),
      child: _buildButton(
        context,
        buttonStyle,
        padding,
        borderRadiusValue,
        buttonChild,
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    ButtonStyle buttonStyle,
    EdgeInsetsGeometry padding,
    double borderRadiusValue,
    Widget child,
  ) {
    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton(
          style: buttonStyle,
          onPressed: isEnabled && !isLoading ? onPressed : null,
          child: child,
        );
      case ButtonVariant.secondary:
        return ElevatedButton(
          style: buttonStyle,
          onPressed: isEnabled && !isLoading ? onPressed : null,
          child: child,
        );
      case ButtonVariant.outlined:
        return OutlinedButton(
          style: buttonStyle,
          onPressed: isEnabled && !isLoading ? onPressed : null,
          child: child,
        );
      case ButtonVariant.text:
        return TextButton(
          style: buttonStyle,
          onPressed: isEnabled && !isLoading ? onPressed : null,
          child: child,
        );
    }
  }

  ButtonStyle _getButtonStyle() {
    final borderRadiusValue = borderRadius ?? _getBorderRadius();
    final elevationValue = elevation ?? _getElevation();

    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: Theme.of(Get.context).colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: elevationValue,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          textStyle: _getTextStyle(),
        );
      case ButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: Theme.of(Get.context).colorScheme.secondary,
          foregroundColor: Colors.white,
          elevation: elevationValue,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          textStyle: _getTextStyle(),
        );
      case ButtonVariant.outlined:
        return OutlinedButton.styleFrom(
          foregroundColor: Theme.of(Get.context).colorScheme.primary,
          side: BorderSide(
            color: Theme.of(Get.context).colorScheme.outline,
            width: 1,
          ),
          elevation: 0,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          textStyle: _getTextStyle(),
        );
      case ButtonVariant.text:
        return TextButton.styleFrom(
          foregroundColor: Theme.of(Get.context).colorScheme.primary,
          elevation: 0,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          textStyle: _getTextStyle(),
        );
    }
  }

  Widget _buildButtonContent() {
    if (icon == null) {
      return Text(text);
    }

    final iconWidget = Icon(icon, size: _getIconSize());
    final textWidget = Text(text);

    switch (iconPosition) {
      case IconPosition.left:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [iconWidget, const SizedBox(width: 8), textWidget],
        );
      case IconPosition.right:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [textWidget, const SizedBox(width: 8), iconWidget],
        );
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  double _getHeight() {
    switch (size) {
      case ButtonSize.small:
        return 36;
      case ButtonSize.medium:
        return 44;
      case ButtonSize.large:
        return 52;
    }
  }

  double _getBorderRadius() {
    return 8.0;
  }

  double _getElevation() {
    return 0;
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return 18;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case ButtonSize.small:
        return AppTextStyles.buttonTextSmall;
      case ButtonSize.medium:
        return AppTextStyles.buttonTextMedium;
      case ButtonSize.large:
        return AppTextStyles.buttonTextLarge;
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.secondary:
        return Colors.white;
      case ButtonVariant.outlined:
      case ButtonVariant.text:
        return Theme.of(context).colorScheme.primary;
    }
  }
}

/// Icon Button
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.size = ButtonSize.medium,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.isEnabled = true,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final ButtonSize size;
  final ButtonVariant variant;
  final bool isLoading;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final iconSize = _getIconSize();
    final buttonSize = _getButtonSize();

    Widget child = Icon(icon, size: iconSize);

    if (isLoading) {
      child = SizedBox(
        width: iconSize,
        height: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(_getIconColor(context)),
        ),
      );
    }

    Widget button;
    switch (variant) {
      case ButtonVariant.primary:
        button = IconButton(
          icon: child,
          onPressed: isEnabled && !isLoading ? onPressed : null,
          tooltip: tooltip,
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            fixedSize: Size(buttonSize, buttonSize),
          ),
        );
      case ButtonVariant.secondary:
        button = IconButton(
          icon: child,
          onPressed: isEnabled && !isLoading ? onPressed : null,
          tooltip: tooltip,
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Colors.white,
            fixedSize: Size(buttonSize, buttonSize),
          ),
        );
      case ButtonVariant.outlined:
        button = IconButton(
          icon: child,
          onPressed: isEnabled && !isLoading ? onPressed : null,
          tooltip: tooltip,
          style: IconButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 1,
            ),
            fixedSize: Size(buttonSize, buttonSize),
          ),
        );
      case ButtonVariant.text:
        button = IconButton(
          icon: child,
          onPressed: isEnabled && !isLoading ? onPressed : null,
          tooltip: tooltip,
          style: IconButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
            fixedSize: Size(buttonSize, buttonSize),
          ),
        );
    }

    return button;
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return 18;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }

  double _getButtonSize() {
    switch (size) {
      case ButtonSize.small:
        return 36;
      case ButtonSize.medium:
        return 44;
      case ButtonSize.large:
        return 52;
    }
  }

  Color _getIconColor(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.secondary:
        return Colors.white;
      case ButtonVariant.outlined:
      case ButtonVariant.text:
        return Theme.of(context).colorScheme.primary;
    }
  }
}

/// Floating Action Button
class AppFab extends StatelessWidget {
  const AppFab({
    super.key,
    required this.onPressed,
    this.icon,
    this.label,
    this.heroTag,
    this.extended = false,
    this.isLoading = false,
    this.isEnabled = true,
  });

  final VoidCallback? onPressed;
  final IconData? icon;
  final String? label;
  final Object? heroTag;
  final bool extended;
  final bool isLoading;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    if (extended && label != null) {
      return FloatingActionButton.extended(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        icon: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : icon != null
            ? Icon(icon)
            : null,
        label: isLoading ? const SizedBox() : Text(label!),
        heroTag: heroTag,
      );
    }

    return FloatingActionButton(
      onPressed: isEnabled && !isLoading ? onPressed : null,
      heroTag: heroTag,
      child: isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : icon != null
          ? Icon(icon)
          : null,
    );
  }
}

// ==================== ENUMS ====================

enum ButtonVariant { primary, secondary, outlined, text }

enum ButtonSize { small, medium, large }

enum IconPosition { left, right }

// ==================== HELPER ====================

class Get {
  static BuildContext? _context;

  static void setContext(BuildContext context) {
    _context = context;
  }

  static BuildContext get context {
    if (_context == null) {
      throw Exception(
        'Get.context not initialized. Call Get.setContext() first.',
      );
    }
    return _context!;
  }
}
