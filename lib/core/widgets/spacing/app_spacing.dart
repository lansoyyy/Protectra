import 'package:flutter/material.dart';

/// Custom Spacing Widgets for Simbayanan
/// Provides consistent spacing throughout the application

/// Horizontal Space
class AppHSpace extends StatelessWidget {
  const AppHSpace(this.value, {super.key});

  final double value;

  const AppHSpace.xxs({super.key}) : value = 4;
  const AppHSpace.xs({super.key}) : value = 8;
  const AppHSpace.sm({super.key}) : value = 12;
  const AppHSpace.md({super.key}) : value = 16;
  const AppHSpace.lg({super.key}) : value = 24;
  const AppHSpace.xl({super.key}) : value = 32;
  const AppHSpace.xxl({super.key}) : value = 48;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: value);
  }
}

/// Vertical Space
class AppVSpace extends StatelessWidget {
  const AppVSpace(this.value, {super.key});

  final double value;

  const AppVSpace.xxs({super.key}) : value = 4;
  const AppVSpace.xs({super.key}) : value = 8;
  const AppVSpace.sm({super.key}) : value = 12;
  const AppVSpace.md({super.key}) : value = 16;
  const AppVSpace.lg({super.key}) : value = 24;
  const AppVSpace.xl({super.key}) : value = 32;
  const AppVSpace.xxl({super.key}) : value = 48;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: value);
  }
}

/// Sliver Vertical Space
class AppSliverVSpace extends StatelessWidget {
  const AppSliverVSpace(this.value, {super.key});

  final double value;

  const AppSliverVSpace.xxs({super.key}) : value = 4;
  const AppSliverVSpace.xs({super.key}) : value = 8;
  const AppSliverVSpace.sm({super.key}) : value = 12;
  const AppSliverVSpace.md({super.key}) : value = 16;
  const AppSliverVSpace.lg({super.key}) : value = 24;
  const AppSliverVSpace.xl({super.key}) : value = 32;
  const AppSliverVSpace.xxl({super.key}) : value = 48;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: SizedBox(height: value));
  }
}

/// Sliver Horizontal Space
class AppSliverHSpace extends StatelessWidget {
  const AppSliverHSpace(this.value, {super.key});

  final double value;

  const AppSliverHSpace.xxs({super.key}) : value = 4;
  const AppSliverHSpace.xs({super.key}) : value = 8;
  const AppSliverHSpace.sm({super.key}) : value = 12;
  const AppSliverHSpace.md({super.key}) : value = 16;
  const AppSliverHSpace.lg({super.key}) : value = 24;
  const AppSliverHSpace.xl({super.key}) : value = 32;
  const AppSliverHSpace.xxl({super.key}) : value = 48;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: SizedBox(width: value));
  }
}

/// Expanded Spacer
class AppSpacer extends StatelessWidget {
  const AppSpacer({super.key, this.flex = 1});

  final int flex;

  @override
  Widget build(BuildContext context) {
    return Spacer(flex: flex);
  }
}

/// Horizontal Divider with spacing
class AppHDivider extends StatelessWidget {
  const AppHDivider({
    super.key,
    this.height = 1,
    this.thickness = 1,
    this.color,
    this.indent = 0,
    this.endIndent = 0,
  });

  final double height;
  final double thickness;
  final Color? color;
  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height / 2),
      child: Divider(
        thickness: thickness,
        color: color ?? Theme.of(context).dividerColor,
        indent: indent,
        endIndent: endIndent,
      ),
    );
  }
}

/// Vertical Divider with spacing
class AppVDivider extends StatelessWidget {
  const AppVDivider({
    super.key,
    this.width = 1,
    this.thickness = 1,
    this.color,
    this.indent = 0,
    this.endIndent = 0,
  });

  final double width;
  final double thickness;
  final Color? color;
  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 2),
      child: VerticalDivider(
        thickness: thickness,
        color: color ?? Theme.of(context).dividerColor,
        indent: indent,
        endIndent: endIndent,
      ),
    );
  }
}

/// Gap widget for spacing in flex/row/column
class AppGap extends StatelessWidget {
  const AppGap(this.value, {super.key});

  final double value;

  const AppGap.xxs({super.key}) : value = 4;
  const AppGap.xs({super.key}) : value = 8;
  const AppGap.sm({super.key}) : value = 12;
  const AppGap.md({super.key}) : value = 16;
  const AppGap.lg({super.key}) : value = 24;
  const AppGap.xl({super.key}) : value = 32;
  const AppGap.xxl({super.key}) : value = 48;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: value, height: value);
  }
}

/// Responsive Gap
class AppResponsiveGap extends StatelessWidget {
  const AppResponsiveGap({
    super.key,
    this.mobile = 16,
    this.tablet,
    this.desktop,
  });

  final double mobile;
  final double? tablet;
  final double? desktop;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    double gap = mobile;

    if (screenWidth > 600 && tablet != null) {
      gap = tablet!;
    } else if (screenWidth > 1024 && desktop != null) {
      gap = desktop!;
    }

    return AppGap(gap);
  }
}

/// Padding Box
class AppPadding extends StatelessWidget {
  const AppPadding({
    super.key,
    required this.child,
    this.all,
    this.horizontal,
    this.vertical,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  final Widget child;
  final double? all;
  final double? horizontal;
  final double? vertical;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: _getPadding(), child: child);
  }

  EdgeInsets _getPadding() {
    if (all != null) {
      return EdgeInsets.all(all!);
    }
    return EdgeInsets.only(
      top: top ?? vertical ?? 0,
      bottom: bottom ?? vertical ?? 0,
      left: left ?? horizontal ?? 0,
      right: right ?? horizontal ?? 0,
    );
  }
}

/// Margin Box
class AppMargin extends StatelessWidget {
  const AppMargin({
    super.key,
    required this.child,
    this.all,
    this.horizontal,
    this.vertical,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  final Widget child;
  final double? all;
  final double? horizontal;
  final double? vertical;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Container(margin: _getMargin(), child: child);
  }

  EdgeInsets _getMargin() {
    if (all != null) {
      return EdgeInsets.all(all!);
    }
    return EdgeInsets.only(
      top: top ?? vertical ?? 0,
      bottom: bottom ?? vertical ?? 0,
      left: left ?? horizontal ?? 0,
      right: right ?? horizontal ?? 0,
    );
  }
}

/// Safe Area with padding
class AppSafeArea extends StatelessWidget {
  const AppSafeArea({
    super.key,
    required this.child,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
    this.minimum,
  });

  final Widget child;
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;
  final EdgeInsets? minimum;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      minimum: minimum ?? EdgeInsets.zero,
      child: child,
    );
  }
}

/// Sliver Safe Area
class AppSliverSafeArea extends StatelessWidget {
  const AppSliverSafeArea({
    super.key,
    required this.sliver,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
    this.minimum,
  });

  final Widget sliver;
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;
  final EdgeInsets? minimum;

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      minimum: minimum ?? EdgeInsets.zero,
      sliver: sliver,
    );
  }
}
