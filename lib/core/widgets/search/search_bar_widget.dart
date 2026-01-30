import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class AppSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onClear;
  final bool showClearButton;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;
  final double? borderRadius;
  final bool autofocus;
  final Function(String)? onSubmitted;

  const AppSearchBar({
    super.key,
    this.hintText = 'Search...',
    this.controller,
    this.onChanged,
    this.onClear,
    this.showClearButton = true,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.backgroundColor,
    this.textColor,
    this.hintColor,
    this.borderRadius,
    this.autofocus = false,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveController = controller ?? TextEditingController();
    final hasText = effectiveController.text.isNotEmpty;

    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
      ),
      child: TextField(
        controller: effectiveController,
        autofocus: autofocus,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: AppTextStyles.bodyMedium.copyWith(
          color: textColor ?? AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: hintColor ?? AppColors.textSecondary,
          ),
          prefixIcon:
              prefixIcon ??
              Icon(Icons.search_outlined, color: AppColors.textSecondary),
          suffixIcon: showClearButton && hasText
              ? IconButton(
                  icon: Icon(Icons.clear, color: AppColors.textSecondary),
                  onPressed: () {
                    effectiveController.clear();
                    onClear?.call();
                    onChanged?.call('');
                  },
                )
              : suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          filled: true,
          fillColor: AppColors.background,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}

/// Search bar with filter chips for category filtering
class AppSearchBarWithFilters extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onClear;
  final List<String> filterOptions;
  final String? selectedFilter;
  final Function(String?)? onFilterChanged;
  final bool showClearButton;
  final EdgeInsetsGeometry? padding;
  final bool autofocus;

  const AppSearchBarWithFilters({
    super.key,
    this.hintText = 'Search...',
    this.controller,
    this.onChanged,
    this.onClear,
    required this.filterOptions,
    this.selectedFilter,
    this.onFilterChanged,
    this.showClearButton = true,
    this.padding,
    this.autofocus = false,
  });

  @override
  State<AppSearchBarWithFilters> createState() =>
      _AppSearchBarWithFiltersState();
}

class _AppSearchBarWithFiltersState extends State<AppSearchBarWithFilters> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSearchBar(
          hintText: widget.hintText,
          controller: widget.controller,
          onChanged: widget.onChanged,
          onClear: widget.onClear,
          showClearButton: widget.showClearButton,
          padding: widget.padding,
          autofocus: widget.autofocus,
        ),
        if (widget.filterOptions.isNotEmpty) ...[
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.filterOptions.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // "All" filter
                  return _buildFilterChip(
                    label: 'All',
                    isSelected: widget.selectedFilter == null,
                    onTap: () => widget.onFilterChanged?.call(null),
                  );
                }
                return _buildFilterChip(
                  label: widget.filterOptions[index - 1],
                  isSelected:
                      widget.selectedFilter == widget.filterOptions[index - 1],
                  onTap: () => widget.onFilterChanged?.call(
                    widget.filterOptions[index - 1],
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.primary.withOpacity(0.2),
        checkmarkColor: AppColors.primary,
        labelStyle: AppTextStyles.bodySmall.copyWith(
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
        backgroundColor: AppColors.surface,
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

/// Floating search bar for overlay search
class FloatingSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onClear;
  final VoidCallback? onClose;
  final bool showClearButton;
  final bool autofocus;

  const FloatingSearchBar({
    super.key,
    this.hintText = 'Search...',
    this.controller,
    this.onChanged,
    this.onClear,
    this.onClose,
    this.showClearButton = true,
    this.autofocus = true,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveController = controller ?? TextEditingController();
    final hasText = effectiveController.text.isNotEmpty;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search_outlined, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: effectiveController,
              autofocus: autofocus,
              onChanged: onChanged,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          if (showClearButton && hasText)
            IconButton(
              icon: Icon(Icons.clear, color: AppColors.textSecondary),
              onPressed: () {
                effectiveController.clear();
                onClear?.call();
                onChanged?.call('');
              },
            ),
          if (onClose != null)
            IconButton(
              icon: Icon(Icons.close, color: AppColors.textSecondary),
              onPressed: onClose,
            ),
        ],
      ),
    );
  }
}
