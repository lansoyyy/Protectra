import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/models/alert.dart';

/// Notifications Screen for Protectra app
/// Displays push notifications and notification history
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<NotificationItem> _notifications;
  bool _showAll = false;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _initializeMockData();
  }

  Future<void> _refreshNotifications() async {
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
    final now = DateTime.now();
    _notifications = [
      NotificationItem(
        id: 'notif_1',
        title: 'High-risk movement detected',
        body: 'Your device has detected unusual movement patterns.',
        timestamp: now.subtract(const Duration(minutes: 5)),
        dangerLevel: 3,
        isRead: false,
        type: NotificationType.alert,
      ),
      NotificationItem(
        id: 'notif_2',
        title: 'New evidence available',
        body: 'Video recording has been saved for review.',
        timestamp: now.subtract(const Duration(minutes: 5)),
        dangerLevel: null,
        isRead: false,
        type: NotificationType.evidence,
      ),
      NotificationItem(
        id: 'notif_3',
        title: 'Device battery low',
        body: 'Your device battery is at 15%. Please charge soon.',
        timestamp: now.subtract(const Duration(hours: 2)),
        dangerLevel: 1,
        isRead: true,
        type: NotificationType.device,
      ),
      NotificationItem(
        id: 'notif_4',
        title: 'Alert sent to contacts',
        body: 'Emergency alert has been sent to your trusted contacts.',
        timestamp: now.subtract(const Duration(hours: 2)),
        dangerLevel: 3,
        isRead: true,
        type: NotificationType.alert,
      ),
      NotificationItem(
        id: 'notif_5',
        title: 'Location updated',
        body: 'New location snapshot recorded.',
        timestamp: now.subtract(const Duration(days: 1)),
        dangerLevel: null,
        isRead: true,
        type: NotificationType.location,
      ),
      NotificationItem(
        id: 'notif_6',
        title: 'Unusual activity detected',
        body: 'Device detected unusual activity patterns.',
        timestamp: now.subtract(const Duration(days: 2)),
        dangerLevel: 2,
        isRead: true,
        type: NotificationType.alert,
      ),
    ];
  }

  List<NotificationItem> get _filteredNotifications {
    if (_showAll) return _notifications;
    return _notifications.where((n) => !n.isRead).toList();
  }

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: Text(
              'Mark all read',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterToggle(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshNotifications,
              color: AppColors.primary,
              backgroundColor: AppColors.surface,
              child: _filteredNotifications.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredNotifications.length,
                      itemBuilder: (context, index) {
                        return _buildNotificationItem(
                          _filteredNotifications[index],
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildFilterOption(
              label: 'Unread ($_unreadCount)',
              isSelected: !_showAll,
              onTap: () {
                setState(() {
                  _showAll = false;
                });
              },
            ),
          ),
          Expanded(
            child: _buildFilterOption(
              label: 'All (${_notifications.length})',
              isSelected: _showAll,
              onTap: () {
                setState(() {
                  _showAll = true;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surface : Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.labelLarge.copyWith(
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none_rounded,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You\'re all caught up!',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    final dangerColor = notification.dangerLevel != null
        ? AppColors.primary
        : Color(
            int.parse(
              _getDangerColor(
                notification.dangerLevel!,
              ).replaceFirst('#', '0xFF'),
            ),
          );

    return GestureDetector(
      onTap: () => _markAsRead(notification),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notification.isRead
              ? AppColors.backgroundSecondary
              : AppColors.primarySurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: notification.isRead
                ? AppColors.border
                : dangerColor.withValues(alpha: 0.5),
            width: notification.isRead ? 1 : 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: dangerColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(notification.type.icon, color: dangerColor, size: 24),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: notification.isRead
                                ? FontWeight.w400
                                : FontWeight.w600,
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: dangerColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.body,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatTimestamp(notification.timestamp),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _markAsRead(NotificationItem notification) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == notification.id);
      if (index != -1) {
        _notifications[index] = notification.copyWith(isRead: true);
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      _notifications = _notifications
          .map((n) => n.copyWith(isRead: true))
          .toList();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All notifications marked as read')),
    );
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
      return DateFormat('MMM d, h:mm a').format(dateTime);
    }
  }

  String _getDangerColor(int level) {
    switch (level) {
      case 1:
        return '#FBBF24';
      case 2:
        return '#F97316';
      case 3:
        return '#EF4444';
      default:
        return '#6B7280';
    }
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final int? dangerLevel;
  final bool isRead;
  final NotificationType type;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.dangerLevel,
    this.isRead = false,
    required this.type,
  });

  NotificationItem copyWith({bool? isRead}) {
    return NotificationItem(
      id: id,
      title: title,
      body: body,
      timestamp: timestamp,
      dangerLevel: dangerLevel,
      isRead: isRead ?? this.isRead,
      type: type,
    );
  }
}

enum NotificationType { alert, evidence, device, location }

extension NotificationTypeExtension on NotificationType {
  String get label {
    switch (this) {
      case NotificationType.alert:
        return 'Alert';
      case NotificationType.evidence:
        return 'Evidence';
      case NotificationType.device:
        return 'Device';
      case NotificationType.location:
        return 'Location';
    }
  }

  IconData get icon {
    switch (this) {
      case NotificationType.alert:
        return Icons.warning_rounded;
      case NotificationType.evidence:
        return Icons.videocam_rounded;
      case NotificationType.device:
        return Icons.devices_rounded;
      case NotificationType.location:
        return Icons.location_on_rounded;
    }
  }
}
