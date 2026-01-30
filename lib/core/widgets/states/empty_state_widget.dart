import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// Empty State Widget for Protectra app
/// Displays a consistent empty state across the app
class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final EmptyStateType type;

  const EmptyStateWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.actionLabel,
    this.onAction,
    this.type = EmptyStateType.default_,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: _getBackgroundColor(),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: _getIconColor()),
            ),
            const SizedBox(height: 24),
            // Title
            Text(
              title,
              style: AppTextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            // Subtitle
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            // Action button
            if (onAction != null && actionLabel != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.refresh_rounded),
                    const SizedBox(width: 8),
                    Text(actionLabel!),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (type) {
      case EmptyStateType.alerts:
        return AppColors.dangerLevel3.withValues(alpha: 0.1);
      case EmptyStateType.timeline:
        return AppColors.primary.withValues(alpha: 0.1);
      case EmptyStateType.location:
        return AppColors.secondary.withValues(alpha: 0.1);
      case EmptyStateType.notifications:
        return AppColors.accent.withValues(alpha: 0.1);
      default:
        return AppColors.backgroundSecondary;
    }
  }

  Color _getIconColor() {
    switch (type) {
      case EmptyStateType.alerts:
        return AppColors.dangerLevel3;
      case EmptyStateType.timeline:
        return AppColors.primary;
      case EmptyStateType.location:
        return AppColors.secondary;
      case EmptyStateType.notifications:
        return AppColors.accent;
      default:
        return AppColors.textTertiary;
    }
  }
}

enum EmptyStateType { default_, alerts, timeline, location, notifications }
