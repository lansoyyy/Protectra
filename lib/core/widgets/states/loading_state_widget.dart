import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// Loading State Widget for Protectra app
/// Displays a consistent loading state across the app
class LoadingStateWidget extends StatelessWidget {
  final String? message;
  final LoadingType type;

  const LoadingStateWidget({
    super.key,
    this.message,
    this.type = LoadingType.default_,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLoadingIndicator(),
            const SizedBox(height: 16),
            if (message != null)
              Text(
                message!,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    switch (type) {
      case LoadingType.default_:
        return _buildDefaultLoader();
      case LoadingType.pulse:
        return _buildPulseLoader();
      case LoadingType.dots:
        return _buildDotsLoader();
      case LoadingType.shimmer:
        return _buildShimmerLoader();
    }
  }

  Widget _buildDefaultLoader() {
    return SizedBox(
      width: 48,
      height: 48,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: const AlwaysStoppedAnimation(AppColors.primary),
      ),
    );
  }

  Widget _buildPulseLoader() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.5, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.security_rounded,
              color: AppColors.primary,
              size: 24,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDotsLoader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.3, end: 1.0),
          duration: Duration(milliseconds: 600 + (index * 200)),
          builder: (context, value, child) {
            return Container(
              width: 12,
              height: 12,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: value),
                shape: BoxShape.circle,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildShimmerLoader() {
    return Container(
      width: 200,
      height: 12,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
      child: ClipRRect(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: -1.0, end: 1.0),
          duration: const Duration(milliseconds: 1500),
          builder: (context, value, child) {
            return FractionalTranslation(
              translation: Offset(value * 100, 0),
              child: Container(
                width: 100,
                height: 12,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.backgroundSecondary,
                      AppColors.primary.withValues(alpha: 0.5),
                      AppColors.backgroundSecondary,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

enum LoadingType { default_, pulse, dots, shimmer }
