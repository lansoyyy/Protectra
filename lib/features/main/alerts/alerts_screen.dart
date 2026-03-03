import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/models/rtdb_models.dart';
import '../../../../core/services/rtdb_service.dart';

/// Alerts screen – shows live danger, alert, and audio data from the device.
class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alerts & Danger'), elevation: 0),
      body: StreamBuilder<DeviceSnapshot>(
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
                  'Error: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
            );
          }

          final data = snapshot.data ?? DeviceSnapshot.empty();
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _DangerLevelCard(imu: data.imu),
              const SizedBox(height: 16),
              _AlertDetailCard(alerts: data.alerts),
              const SizedBox(height: 16),
              _AudioAlertCard(audio: data.audio),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Danger level card (IMU)
// ─────────────────────────────────────────────────────────────────────────────

class _DangerLevelCard extends StatelessWidget {
  const _DangerLevelCard({required this.imu});
  final ImuData imu;

  @override
  Widget build(BuildContext context) {
    final dl = imu.dangerLevel;
    final color = _dangerColor(dl);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.7), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                dl == 0 ? Icons.shield_rounded : Icons.warning_amber_rounded,
                color: Colors.white,
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Danger Level',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      imu.dangerLabel,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$dl / 3',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _DangerBar(level: dl),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.access_time_rounded,
                color: Colors.white70,
                size: 14,
              ),
              const SizedBox(width: 6),
              Text(
                imu.timestamp.isEmpty ? 'Never' : _formatTs(imu.timestamp),
                style: AppTextStyles.labelSmall.copyWith(color: Colors.white70),
              ),
            ],
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

class _DangerBar extends StatelessWidget {
  const _DangerBar({required this.level});
  final int level;

  @override
  Widget build(BuildContext context) {
    const max = 3;
    return Row(
      children: List.generate(max, (i) {
        final filled = level > i;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < max - 1 ? 6 : 0),
            height: 8,
            decoration: BoxDecoration(
              color: filled ? Colors.white : Colors.white30,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Alert detail card
// ─────────────────────────────────────────────────────────────────────────────

class _AlertDetailCard extends StatelessWidget {
  const _AlertDetailCard({required this.alerts});
  final AlertData alerts;

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Alert Status',
      icon: Icons.notifications_active_rounded,
      iconColor: AppColors.dangerLevel3,
      child: Column(
        children: [
          _Row(
            icon: Icons.sms_rounded,
            label: 'SMS Sent',
            value: alerts.smsSent ? 'Yes' : 'No',
            valueColor: alerts.smsSent ? AppColors.warning : AppColors.success,
          ),
          const SizedBox(height: 10),
          _Row(
            icon: Icons.gps_fixed_rounded,
            label: 'GPS Valid (at alert)',
            value: alerts.gps.valid ? 'Valid' : 'Invalid / No Fix',
            valueColor: alerts.gps.valid ? AppColors.success : AppColors.error,
          ),
          const SizedBox(height: 10),
          _Row(
            icon: Icons.access_time_rounded,
            label: 'Alert Timestamp',
            value: alerts.timestamp.isEmpty ? '—' : _formatTs(alerts.timestamp),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Audio alert card
// ─────────────────────────────────────────────────────────────────────────────

class _AudioAlertCard extends StatelessWidget {
  const _AudioAlertCard({required this.audio});
  final AudioData audio;

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Audio Trigger',
      icon: Icons.mic_rounded,
      iconColor: AppColors.accent,
      headerTrailing: audio.voiceTriggered
          ? _Badge(label: 'Triggered', color: AppColors.warning)
          : _Badge(label: 'Idle', color: AppColors.textTertiary),
      child: Column(
        children: [
          _Row(
            icon: Icons.record_voice_over_rounded,
            label: 'Voice Triggered',
            value: audio.voiceTriggered ? 'Yes' : 'No',
            valueColor: audio.voiceTriggered
                ? AppColors.warning
                : AppColors.success,
          ),
          const SizedBox(height: 10),
          _Row(
            icon: Icons.text_fields_rounded,
            label: 'Detected Keyword',
            value: audio.keyword.isEmpty ? '(none)' : audio.keyword,
          ),
          const SizedBox(height: 10),
          _Row(
            icon: Icons.access_time_rounded,
            label: 'Last Update',
            value: audio.timestamp.isEmpty ? '—' : _formatTs(audio.timestamp),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared micro-widgets
// ─────────────────────────────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  const _Card({
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

class _Row extends StatelessWidget {
  const _Row({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
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

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});
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

/// Format "2026-03-02_23-33-28" → "Mar 2, 11:33 PM"
String _formatTs(String ts) {
  try {
    final parts = ts.split('_');
    if (parts.length == 2) {
      final dt = DateTime.tryParse(
        '${parts[0]} ${parts[1].replaceAll('-', ':')}',
      );
      if (dt != null) return DateFormat('MMM d, h:mm a').format(dt);
    }
  } catch (_) {}
  return ts;
}
