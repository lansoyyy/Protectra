import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/models/alert.dart';
import '../../../../core/widgets/search/search_bar_widget.dart';

/// Alerts screen for Protectra app
/// Displays all received safety alerts
class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  AlertFilter _selectedFilter = AlertFilter.all;
  late List<Alert> _alerts;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _initializeMockData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshAlerts() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Re-initialize mock data (in real app, fetch from API)
    _initializeMockData();

    setState(() {
      _isRefreshing = false;
    });
  }

  void _initializeMockData() {
    _alerts = [
      Alert(
        id: 'alert_1',
        dangerLevel: 3,
        description: 'High-risk movement detected',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        deviceId: 'device_001',
        isManualTrigger: false,
      ),
      Alert(
        id: 'alert_2',
        dangerLevel: 2,
        description: 'Unusual activity detected',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        deviceId: 'device_001',
        isManualTrigger: false,
      ),
      Alert(
        id: 'alert_3',
        dangerLevel: 1,
        description: 'Manual SOS triggered',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        deviceId: 'device_001',
        isManualTrigger: true,
      ),
      Alert(
        id: 'alert_4',
        dangerLevel: 2,
        description: 'Fall detected',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        deviceId: 'device_001',
        isManualTrigger: false,
      ),
      Alert(
        id: 'alert_5',
        dangerLevel: 1,
        description: 'Prolonged inactivity',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        deviceId: 'device_001',
        isManualTrigger: false,
      ),
    ];
  }

  List<Alert> get _filteredAlerts {
    List<Alert> filtered;

    switch (_selectedFilter) {
      case AlertFilter.all:
        filtered = _alerts;
      case AlertFilter.low:
        filtered = _alerts.where((a) => a.dangerLevel == 1).toList();
      case AlertFilter.medium:
        filtered = _alerts.where((a) => a.dangerLevel == 2).toList();
      case AlertFilter.high:
        filtered = _alerts.where((a) => a.dangerLevel == 3).toList();
      case AlertFilter.unread:
        filtered = _alerts.where((a) => !a.isRead).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((alert) {
        final query = _searchQuery.toLowerCase();
        return alert.description.toLowerCase().contains(query) ||
            alert.dangerLevelLabel.toLowerCase().contains(query) ||
            (alert.deviceId?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alerts'), elevation: 0),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshAlerts,
              color: AppColors.primary,
              backgroundColor: AppColors.surface,
              child: _filteredAlerts.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredAlerts.length,
                      itemBuilder: (context, index) {
                        return _buildAlertCard(_filteredAlerts[index]);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AppSearchBar(
        hintText: 'Search alerts...',
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        onClear: () {
          setState(() {
            _searchQuery = '';
          });
        },
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: AlertFilter.values.map((filter) {
            final isSelected = _selectedFilter == filter;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(filter.label),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedFilter = filter;
                  });
                },
                backgroundColor: AppColors.backgroundSecondary,
                selectedColor: AppColors.primarySurface,
                checkmarkColor: AppColors.primary,
                labelStyle: AppTextStyles.labelMedium.copyWith(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected ? AppColors.primary : AppColors.border,
                    width: 1,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final showSearchMessage = _searchQuery.isNotEmpty;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            showSearchMessage
                ? Icons.search_off_rounded
                : Icons.notifications_none_rounded,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            showSearchMessage ? 'No results found' : 'No alerts found',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            showSearchMessage
                ? 'Try different keywords or clear search'
                : 'Try selecting a different filter',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertCard(Alert alert) {
    final dangerColor = Color(
      int.parse(alert.dangerLevelColor.replaceFirst('#', '0xFF')),
    );
    return GestureDetector(
      onTap: () => _showAlertDetails(alert),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: alert.isRead
              ? AppColors.backgroundSecondary
              : AppColors.primarySurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: alert.isRead
                ? AppColors.border
                : dangerColor.withValues(alpha: 0.5),
            width: alert.isRead ? 1 : 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: dangerColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(_getAlertIcon(alert), color: dangerColor, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: dangerColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          alert.dangerLevelLabel,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (alert.isManualTrigger) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.touch_app_rounded,
                                size: 12,
                                color: AppColors.accent,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Manual',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.accent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    alert.description,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: alert.isRead
                          ? FontWeight.normal
                          : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTimestamp(alert.timestamp),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            if (!alert.isRead)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: dangerColor,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getAlertIcon(Alert alert) {
    if (alert.isManualTrigger) {
      return Icons.touch_app_rounded;
    }
    switch (alert.dangerLevel) {
      case 1:
        return Icons.info_rounded;
      case 2:
        return Icons.warning_rounded;
      case 3:
        return Icons.error_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  String _formatTimestamp(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d, yyyy').format(dateTime);
    }
  }

  void _showAlertDetails(Alert alert) {
    setState(() {
      final index = _alerts.indexWhere((a) => a.id == alert.id);
      if (index != -1) {
        _alerts[index] = alert.copyWith(isRead: true);
      }
    });

    final dangerColor = Color(
      int.parse(alert.dangerLevelColor.replaceFirst('#', '0xFF')),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: dangerColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getAlertIcon(alert),
                            color: dangerColor,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                alert.dangerLevelLabel,
                                style: AppTextStyles.titleMedium.copyWith(
                                  color: dangerColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                _formatTimestamp(alert.timestamp),
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Description',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(alert.description, style: AppTextStyles.bodyLarge),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            icon: Icons.location_on_rounded,
                            label: 'View Location',
                            onTap: () {
                              Navigator.pop(context);
                              // Navigate to location screen
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildActionButton(
                            icon: Icons.call_rounded,
                            label: 'Call Contact',
                            onTap: () {
                              Navigator.pop(context);
                              // Call emergency contact
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primarySurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum AlertFilter { all, low, medium, high, unread }

extension AlertFilterExtension on AlertFilter {
  String get label {
    switch (this) {
      case AlertFilter.all:
        return 'All';
      case AlertFilter.low:
        return 'Low';
      case AlertFilter.medium:
        return 'Medium';
      case AlertFilter.high:
        return 'High';
      case AlertFilter.unread:
        return 'Unread';
    }
  }
}
