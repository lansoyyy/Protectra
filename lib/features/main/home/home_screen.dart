import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/models/alert.dart';
import '../../../../core/models/device.dart';
import '../../../../core/models/contact.dart';

/// Home/Dashboard screen for Protectra app
/// Shows device status, recent alerts, and quick actions
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock data for demo
  late Device _device;
  late List<Alert> _recentAlerts;
  late List<Contact> _emergencyContacts;

  @override
  void initState() {
    super.initState();
    _initializeMockData();
  }

  void _initializeMockData() {
    _device = Device.mock(batteryLevel: 78, status: DeviceStatus.connected);
    _recentAlerts = [
      Alert(
        id: 'alert_1',
        dangerLevel: 2,
        description: 'High-risk movement detected',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        deviceId: _device.id,
        isManualTrigger: false,
      ),
      Alert(
        id: 'alert_2',
        dangerLevel: 1,
        description: 'Unusual activity detected',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        deviceId: _device.id,
        isManualTrigger: false,
      ),
    ];
    _emergencyContacts = [
      Contact.mock(
        name: 'Maria Santos',
        phoneNumber: '+639123456789',
        type: ContactType.parent,
        isEmergencyContact: true,
      ),
      Contact.mock(
        name: 'Juan Reyes',
        phoneNumber: '+639876543210',
        type: ContactType.friend,
        isEmergencyContact: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildDeviceStatusCard(),
                  const SizedBox(height: 20),
                  _buildEmergencyActions(),
                  const SizedBox(height: 20),
                  _buildRecentAlerts(),
                  const SizedBox(height: 20),
                  _buildQuickStats(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: false,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Protectra',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.textInverse,
              ),
            ),
            Text(
              DateFormat('EEEE, MMM d').format(DateTime.now()),
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textInverse.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceStatusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryLight, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _device.name,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.textInverse,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        _device.isConnected
                            ? Icons.bluetooth_connected
                            : Icons.bluetooth_disabled,
                        color: AppColors.textInverse,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _device.statusLabel,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textInverse,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.textInverse.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.watch,
                  color: AppColors.textInverse,
                  size: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatusItem(
                  icon: Icons.battery_charging_full_rounded,
                  label: 'Battery',
                  value: '${_device.batteryLevel}%',
                  color: _device.isBatteryLow
                      ? AppColors.accent
                      : AppColors.secondary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatusItem(
                  icon: Icons.sync_rounded,
                  label: 'Last Sync',
                  value: '${_device.timeSinceHeartbeat.inMinutes}m ago',
                  color: AppColors.textInverse,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.textInverse.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textInverse.withValues(alpha: 0.8),
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textInverse,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Emergency Actions', style: AppTextStyles.titleMedium),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildEmergencyButton(
                icon: Icons.phone_in_talk_rounded,
                label: 'Call Emergency',
                color: AppColors.dangerLevel3,
                onTap: () {
                  HapticFeedback.heavyImpact();
                  _showEmergencyDialog();
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildEmergencyButton(
                icon: Icons.contact_phone_rounded,
                label: 'Call Contact',
                color: AppColors.primary,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  _showContactDialog();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmergencyButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.textInverse, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textInverse,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentAlerts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Alerts', style: AppTextStyles.titleMedium),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._recentAlerts.map((alert) => _buildAlertCard(alert)),
      ],
    );
  }

  Widget _buildAlertCard(Alert alert) {
    final dangerColor = Color(
      int.parse(alert.dangerLevelColor.replaceFirst('#', '0xFF')),
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: dangerColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: dangerColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.warning_rounded, color: dangerColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.dangerLevelLabel,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(alert.description, style: AppTextStyles.bodyMedium),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatTime(alert.timestamp),
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            icon: Icons.notifications_active_rounded,
            label: 'Alerts',
            value: '${_recentAlerts.length}',
            color: AppColors.dangerLevel3,
          ),
          _buildStatItem(
            icon: Icons.location_on_rounded,
            label: 'Locations',
            value: '12',
            color: AppColors.primary,
          ),
          _buildStatItem(
            icon: Icons.videocam_rounded,
            label: 'Evidence',
            value: '8',
            color: AppColors.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return DateFormat('MMM d').format(dateTime);
    }
  }

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Emergency Call'),
        content: const Text('Do you want to call emergency services?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement emergency call
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.dangerLevel3,
            ),
            child: const Text('Call 911'),
          ),
        ],
      ),
    );
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _emergencyContacts.map((contact) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primarySurface,
                child: Text(
                  contact.initials,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              title: Text(contact.name),
              subtitle: Text(contact.phoneNumber ?? 'No phone number'),
              onTap: () {
                Navigator.pop(context);
                // Implement call contact
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
