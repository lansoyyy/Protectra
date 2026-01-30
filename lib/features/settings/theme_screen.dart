import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Theme Selection Screen for Protectra app
/// Allows users to select their preferred theme
class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  ThemeMode _selectedTheme = ThemeMode.system;

  final List<ThemeOption> _themes = [
    ThemeOption(
      mode: ThemeMode.system,
      name: 'System',
      description: 'Follow device settings',
      icon: Icons.brightness_auto_rounded,
    ),
    ThemeOption(
      mode: ThemeMode.light,
      name: 'Light',
      description: 'Always use light mode',
      icon: Icons.light_mode_rounded,
    ),
    ThemeOption(
      mode: ThemeMode.dark,
      name: 'Dark',
      description: 'Always use dark mode',
      icon: Icons.dark_mode_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme'), elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme options
          ..._themes.map((theme) {
            final isSelected = _selectedTheme == theme.mode;
            return _buildThemeOption(theme, isSelected);
          }),
          const SizedBox(height: 24),
          // Preview section
          _buildThemePreview(),
        ],
      ),
    );
  }

  Widget _buildThemeOption(ThemeOption theme, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTheme = theme.mode;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Theme changed to ${theme.name}')),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primarySurface
              : AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.backgroundTertiary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                theme.icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    theme.name,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    theme.description,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemePreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preview',
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _selectedTheme == ThemeMode.dark
                ? AppColors.neutral800
                : AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sample Card',
                style: AppTextStyles.titleMedium.copyWith(
                  color: _selectedTheme == ThemeMode.dark
                      ? AppColors.textInverse
                      : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This is how the app will look with the selected theme. All colors and styles will be applied consistently.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: _selectedTheme == ThemeMode.dark
                      ? AppColors.neutral300
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: const Text('Button'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Outlined'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ThemeOption {
  final ThemeMode mode;
  final String name;
  final String description;
  final IconData icon;

  ThemeOption({
    required this.mode,
    required this.name,
    required this.description,
    required this.icon,
  });
}
