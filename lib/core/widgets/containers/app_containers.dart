import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Custom Card Container for Simbayanan
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.elevation,
    this.border,
    this.shadow,
    this.onTap,
    this.onLongPress,
    this.width,
    this.height,
    this.constraints,
    this.alignment,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? color;
  final double? elevation;
  final BoxBorder? border;
  final List<BoxShadow>? shadow;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? Theme.of(context).colorScheme.surface;
    final cardBorderRadius = borderRadius ?? 12.0;
    final cardBorder = border;
    final cardShadow = shadow;

    Widget content = Container(
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin,
      width: width,
      height: height,
      constraints: constraints,
      alignment: alignment,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        border: cardBorder,
        boxShadow: cardShadow,
      ),
      child: child,
    );

    if (onTap != null || onLongPress != null) {
      content = InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        child: content,
      );
    }

    return content;
  }
}

/// Custom Container with Gradient
class AppGradientContainer extends StatelessWidget {
  const AppGradientContainer({
    super.key,
    required this.child,
    this.gradient,
    this.padding,
    this.margin,
    this.borderRadius,
    this.border,
    this.shadow,
    this.onTap,
    this.onLongPress,
    this.width,
    this.height,
    this.constraints,
    this.alignment,
  });

  final Widget child;
  final Gradient? gradient;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? shadow;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    final defaultGradient = gradient ?? AppColors.gradientPrimary;
    final cardBorderRadius = borderRadius ?? 12.0;

    Widget content = Container(
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin,
      width: width,
      height: height,
      constraints: constraints,
      alignment: alignment,
      decoration: BoxDecoration(
        gradient: defaultGradient,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        border: border,
        boxShadow: shadow,
      ),
      child: child,
    );

    if (onTap != null || onLongPress != null) {
      content = InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        child: content,
      );
    }

    return content;
  }
}

/// Custom Container with Shadow
class AppShadowContainer extends StatelessWidget {
  const AppShadowContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.shadowIntensity = ShadowIntensity.medium,
    this.onTap,
    this.onLongPress,
    this.width,
    this.height,
    this.constraints,
    this.alignment,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? color;
  final ShadowIntensity shadowIntensity;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? Theme.of(context).colorScheme.surface;
    final cardBorderRadius = borderRadius ?? 12.0;
    final cardShadow = _getShadow();

    Widget content = Container(
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin,
      width: width,
      height: height,
      constraints: constraints,
      alignment: alignment,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        boxShadow: cardShadow,
      ),
      child: child,
    );

    if (onTap != null || onLongPress != null) {
      content = InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        child: content,
      );
    }

    return content;
  }

  List<BoxShadow> _getShadow() {
    switch (shadowIntensity) {
      case ShadowIntensity.none:
        return [];
      case ShadowIntensity.light:
        return [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ];
      case ShadowIntensity.medium:
        return [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ];
      case ShadowIntensity.dark:
        return [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ];
    }
  }
}

/// Custom Container with Border
class AppBorderedContainer extends StatelessWidget {
  const AppBorderedContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderStyle = BorderStyle.solid,
    this.onTap,
    this.onLongPress,
    this.width,
    this.height,
    this.constraints,
    this.alignment,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? color;
  final Color? borderColor;
  final double borderWidth;
  final BorderStyle borderStyle;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? Theme.of(context).colorScheme.surface;
    final cardBorderColor =
        borderColor ?? Theme.of(context).colorScheme.outline;
    final cardBorderRadius = borderRadius ?? 12.0;

    Widget content = Container(
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin,
      width: width,
      height: height,
      constraints: constraints,
      alignment: alignment,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        border: Border.all(
          color: cardBorderColor,
          width: borderWidth,
          style: borderStyle,
        ),
      ),
      child: child,
    );

    if (onTap != null || onLongPress != null) {
      content = InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        child: content,
      );
    }

    return content;
  }
}

/// Custom Container with Dashed Border
class AppDashedContainer extends StatelessWidget {
  const AppDashedContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.borderColor,
    this.dashWidth = 8.0,
    this.dashSpace = 4.0,
    this.borderWidth = 1.0,
    this.onTap,
    this.onLongPress,
    this.width,
    this.height,
    this.constraints,
    this.alignment,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? color;
  final Color? borderColor;
  final double dashWidth;
  final double dashSpace;
  final double borderWidth;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? Theme.of(context).colorScheme.surface;
    final cardBorderColor =
        borderColor ?? Theme.of(context).colorScheme.outline;
    final cardBorderRadius = borderRadius ?? 12.0;

    Widget content = Container(
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin,
      width: width,
      height: height,
      constraints: constraints,
      alignment: alignment,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        border: Border.all(
          color: cardBorderColor,
          width: borderWidth,
          style: BorderStyle.solid,
        ),
      ),
      child: child,
    );

    content = CustomPaint(
      painter: DashedBorderPainter(
        color: cardBorderColor,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        strokeWidth: borderWidth,
        borderRadius: cardBorderRadius,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cardBorderRadius),
        child: content,
      ),
    );

    if (onTap != null || onLongPress != null) {
      content = InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        child: content,
      );
    }

    return content;
  }
}

/// Custom Circular Container
class AppCircularContainer extends StatelessWidget {
  const AppCircularContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.radius,
    this.diameter,
    this.color,
    this.gradient,
    this.border,
    this.shadow,
    this.onTap,
    this.onLongPress,
    this.alignment,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? radius;
  final double? diameter;
  final Color? color;
  final Gradient? gradient;
  final BoxBorder? border;
  final List<BoxShadow>? shadow;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    final finalColor = color ?? Theme.of(context).colorScheme.surface;

    Widget content = Container(
      padding: padding,
      margin: margin,
      width: diameter,
      height: diameter,
      alignment: alignment,
      decoration: BoxDecoration(
        color: gradient == null ? finalColor : null,
        gradient: gradient,
        shape: BoxShape.circle,
        border: border,
        boxShadow: shadow,
      ),
      child: child,
    );

    if (onTap != null || onLongPress != null) {
      content = InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        customBorder: CircleBorder(),
        child: content,
      );
    }

    return content;
  }
}

// ==================== HELPER CLASSES ====================

enum ShadowIntensity { none, light, medium, dark }

class DashedBorderPainter extends CustomPainter {
  DashedBorderPainter({
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
    required this.strokeWidth,
    required this.borderRadius,
  });

  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius),
        ),
      );

    final dashPath = _createDashedPath(path, dashWidth, dashSpace);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path source, double dashWidth, double dashSpace) {
    final Path dest = Path();
    for (final ui.PathMetric metric in source.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;
      while (distance < metric.length) {
        final double len = draw ? dashWidth : dashSpace;
        if (draw) {
          dest.addPath(
            metric.extractPath(distance, distance + len),
            Offset.zero,
          );
        }
        distance += len;
        draw = !draw;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.borderRadius != borderRadius;
  }
}
