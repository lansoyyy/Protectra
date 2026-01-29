import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../theme/app_colors.dart';

/// Custom Loading Indicator for Simbayanan
class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.size = LoaderSize.medium, this.color});

  final LoaderSize size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final loaderColor = color ?? Theme.of(context).colorScheme.primary;
    final loaderSize = _getSize();

    return SizedBox(
      width: loaderSize,
      height: loaderSize,
      child: CircularProgressIndicator(
        strokeWidth: _getStrokeWidth(),
        valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
      ),
    );
  }

  double _getSize() {
    switch (size) {
      case LoaderSize.small:
        return 24;
      case LoaderSize.medium:
        return 40;
      case LoaderSize.large:
        return 56;
    }
  }

  double _getStrokeWidth() {
    switch (size) {
      case LoaderSize.small:
        return 2;
      case LoaderSize.medium:
        return 3;
      case LoaderSize.large:
        return 4;
    }
  }
}

/// Full Screen Loader
class AppFullScreenLoader extends StatelessWidget {
  const AppFullScreenLoader({super.key, this.message, this.color});

  final String? message;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final loaderColor = color ?? Theme.of(context).colorScheme.primary;

    return Container(
      color: AppColors.overlay,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppLoader(size: LoaderSize.large, color: loaderColor),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.textInverse),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Button Loader
class AppButtonLoader extends StatelessWidget {
  const AppButtonLoader({super.key, this.color, this.size = LoaderSize.small});

  final Color? color;
  final LoaderSize size;

  @override
  Widget build(BuildContext context) {
    final loaderColor = color ?? Colors.white;
    final loaderSize = _getSize();

    return SizedBox(
      width: loaderSize,
      height: loaderSize,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
      ),
    );
  }

  double _getSize() {
    switch (size) {
      case LoaderSize.small:
        return 18;
      case LoaderSize.medium:
        return 24;
      case LoaderSize.large:
        return 32;
    }
  }
}

/// Spinkit Loaders
class AppSpinkitLoader extends StatelessWidget {
  const AppSpinkitLoader({
    super.key,
    this.type = SpinkitType.circle,
    this.size = LoaderSize.medium,
    this.color,
  });

  final SpinkitType type;
  final LoaderSize size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final loaderColor = color ?? Theme.of(context).colorScheme.primary;
    final loaderSize = _getSize();

    return SizedBox(
      width: loaderSize,
      height: loaderSize,
      child: _buildLoader(loaderColor),
    );
  }

  Widget _buildLoader(Color color) {
    switch (type) {
      case SpinkitType.circle:
        return SpinKitCircle(color: color, size: _getSize());
      case SpinkitType.fadingCircle:
        return SpinKitFadingCircle(color: color, size: _getSize());
      case SpinkitType.doubleBounce:
        return SpinKitDoubleBounce(color: color, size: _getSize());
      case SpinkitType.wave:
        return SpinKitWave(color: color, size: _getSize());
      case SpinkitType.wanderingCubes:
        return SpinKitWanderingCubes(color: color, size: _getSize());
      case SpinkitType.pulse:
        return SpinKitPulse(color: color, size: _getSize());
      case SpinkitType.chasingDots:
        return SpinKitChasingDots(color: color, size: _getSize());
      case SpinkitType.threeBounce:
        return SpinKitThreeBounce(color: color, size: _getSize());
      case SpinkitType.circleFade:
        return SpinKitFadingFour(color: color, size: _getSize());
      case SpinkitType.pouringHourGlass:
        return SpinKitPouringHourGlass(color: color, size: _getSize());
      case SpinkitType.foldingCube:
        return SpinKitFoldingCube(color: color, size: _getSize());
    }
  }

  double _getSize() {
    switch (size) {
      case LoaderSize.small:
        return 30;
      case LoaderSize.medium:
        return 50;
      case LoaderSize.large:
        return 70;
    }
  }
}

/// Shimmer Loader
class AppShimmerLoader extends StatelessWidget {
  const AppShimmerLoader({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
  });

  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [
            baseColor ?? AppColors.neutral200,
            highlightColor ?? AppColors.neutral100,
            baseColor ?? AppColors.neutral200,
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}

/// Shimmer Container
class AppShimmerContainer extends StatelessWidget {
  const AppShimmerContainer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
  });

  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return AppShimmerLoader(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: baseColor ?? AppColors.neutral200,
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
      ),
    );
  }
}

/// Skeleton Loader
class AppSkeletonLoader extends StatelessWidget {
  const AppSkeletonLoader({
    super.key,
    this.type = SkeletonType.rectangle,
    this.width,
    this.height,
    this.borderRadius,
  });

  final SkeletonType type;
  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case SkeletonType.circle:
        return _buildCircle();
      case SkeletonType.rectangle:
        return _buildRectangle();
      case SkeletonType.line:
        return _buildLine();
    }
  }

  Widget _buildCircle() {
    return Container(
      width: width ?? 40,
      height: height ?? 40,
      decoration: BoxDecoration(
        color: AppColors.neutral200,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildRectangle() {
    return Container(
      width: width,
      height: height ?? 100,
      decoration: BoxDecoration(
        color: AppColors.neutral200,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
      ),
    );
  }

  Widget _buildLine() {
    return Container(
      width: width,
      height: height ?? 16,
      decoration: BoxDecoration(
        color: AppColors.neutral200,
        borderRadius: BorderRadius.circular(borderRadius ?? 4),
      ),
    );
  }
}

/// Skeleton List
class AppSkeletonList extends StatelessWidget {
  const AppSkeletonList({super.key, this.itemCount = 5, this.itemBuilder});

  final int itemCount;
  final Widget Function(int index)? itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (itemBuilder != null) {
          return itemBuilder!(index);
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              AppSkeletonLoader(
                type: SkeletonType.circle,
                width: 48,
                height: 48,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSkeletonLoader(
                      type: SkeletonType.line,
                      width: double.infinity,
                      height: 16,
                    ),
                    const SizedBox(height: 8),
                    AppSkeletonLoader(
                      type: SkeletonType.line,
                      width: 200,
                      height: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ==================== ENUMS ====================

enum LoaderSize { small, medium, large }

enum SpinkitType {
  circle,
  fadingCircle,
  doubleBounce,
  wave,
  wanderingCubes,
  pulse,
  chasingDots,
  threeBounce,
  circleFade,
  pouringHourGlass,
  foldingCube,
}

enum SkeletonType { circle, rectangle, line }
