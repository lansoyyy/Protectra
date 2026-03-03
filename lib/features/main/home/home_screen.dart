import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/models/rtdb_models.dart';
import '../../../../core/services/rtdb_service.dart';

/// Home / Dashboard screen.
/// Shows a live overview of every node in the Firebase Realtime Database.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<DeviceSnapshot>(
          stream: RtdbService.instance.deviceStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Failed to connect to device:\n${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
              );
            }

            final data = snapshot.data ?? DeviceSnapshot.empty();
            return CustomScrollView(
              slivers: [
                _buildHeader(data.system),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _SystemCard(system: data.system),
                      const SizedBox(height: 16),
                      _ImuCard(imu: data.imu),
                      const SizedBox(height: 16),
                      _ActuatorsCard(actuators: data.actuators),
                      const SizedBox(height: 16),
                      _AudioCard(audio: data.audio),
                      const SizedBox(height: 16),
                      _AlertSummaryCard(alerts: data.alerts),
                      const SizedBox(height: 24),
                    ]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  SliverAppBar _buildHeader(SystemData system) {
    final isEmergency = system.emergency;
    return SliverAppBar(
      expandedHeight: 110,
      floating: false,
      pinned: false,
      backgroundColor: isEmergency ? AppColors.error : AppColors.primary,
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
        background: isEmergency
            ? Container(
                color: AppColors.error,
                alignment: Alignment.topRight,
                padding: const EdgeInsets.all(16),
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'EMERGENCY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable section card wrapper
// ─────────────────────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.child,
    this.headerTrailing,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget child;
  final Widget? headerTrailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(title, style: AppTextStyles.titleSmall)),
                if (headerTrailing != null) headerTrailing!,
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(padding: const EdgeInsets.all(16), child: child),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// System card
// ─────────────────────────────────────────────────────────────────────────────

class _SystemCard extends StatelessWidget {
  const _SystemCard({required this.system});
  final SystemData system;

  @override
  Widget build(BuildContext context) {
    final isEmergency = system.emergency;
    return _SectionCard(
      title: 'System',
      icon: Icons.settings_remote_rounded,
      iconColor: isEmergency ? AppColors.error : AppColors.primary,
      headerTrailing: _StatusBadge(
        label: isEmergency ? 'EMERGENCY' : 'Normal',
        color: isEmergency ? AppColors.error : AppColors.success,
      ),
      child: Column(
        children: [
          _InfoRow(
            label: 'State',
            value: system.state.isEmpty ? '—' : system.state,
            icon: Icons.info_outline_rounded,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            label: 'Emergency',
            value: system.emergency ? 'Active' : 'Inactive',
            icon: Icons.warning_amber_rounded,
            valueColor: system.emergency ? AppColors.error : AppColors.success,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            label: 'Last Update',
            value: system.timestamp.isEmpty ? '—' : _formatTs(system.timestamp),
            icon: Icons.access_time_rounded,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// IMU card
// ─────────────────────────────────────────────────────────────────────────────

class _ImuCard extends StatelessWidget {
  const _ImuCard({required this.imu});
  final ImuData imu;

  @override
  Widget build(BuildContext context) {
    final dl = imu.dangerLevel;
    final color = _dangerColor(dl);
    return _SectionCard(
      title: 'Motion Sensor (IMU)',
      icon: Icons.directions_run_rounded,
      iconColor: color,
      headerTrailing: _StatusBadge(label: imu.dangerLabel, color: color),
      child: Column(
        children: [
          _DangerGauge(level: dl),
          const SizedBox(height: 12),
          _InfoRow(
            label: 'Last Update',
            value: imu.timestamp.isEmpty ? '—' : _formatTs(imu.timestamp),
            icon: Icons.access_time_rounded,
          ),
        ],
      ),
    );
  }

  Color _dangerColor(int level) {
    switch (level) {
      case 1:
        return AppColors.dangerLevel1;
      case 2:
        return AppColors.dangerLevel2;
      case 3:
        return AppColors.dangerLevel3;
      default:
        return AppColors.success;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Actuators card
// ─────────────────────────────────────────────────────────────────────────────

class _ActuatorsCard extends StatelessWidget {
  const _ActuatorsCard({required this.actuators});
  final ActuatorData actuators;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Actuators',
      icon: Icons.electrical_services_rounded,
      iconColor: AppColors.secondary,
      child: Row(
        children: [
          Expanded(
            child: _ActuatorTile(
              icon: Icons.campaign_rounded,
              label: 'Buzzer',
              active: actuators.buzzer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ActuatorTile(
              icon: Icons.light_mode_rounded,
              label: 'LED',
              active: actuators.led,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActuatorTile extends StatelessWidget {
  const _ActuatorTile({
    required this.icon,
    required this.label,
    required this.active,
  });

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.warning : AppColors.textTertiary;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 6),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            active ? 'ON' : 'OFF',
            style: AppTextStyles.labelMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Audio card
// ─────────────────────────────────────────────────────────────────────────────

class _AudioCard extends StatelessWidget {
  const _AudioCard({required this.audio});
  final AudioData audio;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Audio',
      icon: Icons.mic_rounded,
      iconColor: AppColors.accent,
      headerTrailing: _StatusBadge(
        label: audio.voiceTriggered ? 'Triggered' : 'Idle',
        color: audio.voiceTriggered
            ? AppColors.warning
            : AppColors.textTertiary,
      ),
      child: Column(
        children: [
          _InfoRow(
            label: 'Voice Triggered',
            value: audio.voiceTriggered ? 'Yes' : 'No',
            icon: Icons.record_voice_over_rounded,
            valueColor: audio.voiceTriggered
                ? AppColors.warning
                : AppColors.success,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            label: 'Keyword',
            value: audio.keyword.isEmpty ? '(none)' : audio.keyword,
            icon: Icons.text_fields_rounded,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            label: 'Last Update',
            value: audio.timestamp.isEmpty ? '—' : _formatTs(audio.timestamp),
            icon: Icons.access_time_rounded,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Alert summary card
// ─────────────────────────────────────────────────────────────────────────────

class _AlertSummaryCard extends StatelessWidget {
  const _AlertSummaryCard({required this.alerts});
  final AlertData alerts;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Alert Summary',
      icon: Icons.notifications_active_rounded,
      iconColor: AppColors.dangerLevel3,
      child: Column(
        children: [
          _InfoRow(
            label: 'SMS Sent',
            value: alerts.smsSent ? 'Yes' : 'No',
            icon: Icons.sms_rounded,
            valueColor: alerts.smsSent ? AppColors.warning : AppColors.success,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            label: 'GPS Valid (at alert)',
            value: alerts.gps.valid ? 'Valid' : 'Invalid',
            icon: Icons.gps_fixed_rounded,
            valueColor: alerts.gps.valid ? AppColors.success : AppColors.error,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            label: 'Alert Timestamp',
            value: alerts.timestamp.isEmpty ? '—' : _formatTs(alerts.timestamp),
            icon: Icons.access_time_rounded,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared small widgets
// ─────────────────────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textTertiary),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _DangerGauge extends StatelessWidget {
  const _DangerGauge({required this.level});
  final int level;

  @override
  Widget build(BuildContext context) {
    const maxLevel = 3;
    final colors = [
      AppColors.dangerLevel1,
      AppColors.dangerLevel2,
      AppColors.dangerLevel3,
    ];
    return Row(
      children: List.generate(maxLevel, (i) {
        final filled = level > i;
        final segColor = colors[i];
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < maxLevel - 1 ? 4 : 0),
            height: 10,
            decoration: BoxDecoration(
              color: filled ? segColor : segColor.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}

/// Format the custom timestamp "2026-03-02_23-33-28" to a readable string.
String _formatTs(String ts) {
  try {
    final parts = ts.split('_');
    if (parts.length == 2) {
      final datePart = parts[0];
      final timePart = parts[1].replaceAll('-', ':');
      final dt = DateTime.tryParse('$datePart $timePart');
      if (dt != null) return DateFormat('MMM d, h:mm a').format(dt);
    }
  } catch (_) {}
  return ts;
}
