import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/models/rtdb_models.dart';
import '../../../../core/services/rtdb_service.dart';

/// Status screen – shows live actuator states and last-update timestamps
/// for every RTDB node of the IoT device.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Status', style: AppTextStyles.titleLarge),
        centerTitle: false,
      ),
      body: StreamBuilder<DeviceSnapshot>(
        stream: RtdbService.instance.deviceStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: AppTextStyles.bodyMedium,
              ),
            );
          }
          final data = snapshot.data ?? DeviceSnapshot.empty();
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              _ActuatorsCard(data.actuators),
              const SizedBox(height: 16),
              _UpdatesCard(data),
              const SizedBox(height: 16),
              _InfoCard(),
            ],
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Actuators card
// ---------------------------------------------------------------------------

class _ActuatorsCard extends StatelessWidget {
  final ActuatorData actuators;
  const _ActuatorsCard(this.actuators);

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Actuators', style: AppTextStyles.titleMedium),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ActuatorTile(
                  icon: Icons.volume_up_rounded,
                  label: 'Buzzer',
                  active: actuators.buzzer,
                  activeColor: AppColors.warning,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ActuatorTile(
                  icon: Icons.lightbulb_rounded,
                  label: 'LED',
                  active: actuators.led,
                  activeColor: AppColors.secondary,
                ),
              ),
            ],
          ),
          if (actuators.timestamp.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Updated: ${_formatTs(actuators.timestamp)}',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ActuatorTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final Color activeColor;
  const _ActuatorTile({
    required this.icon,
    required this.label,
    required this.active,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: active
            ? activeColor.withValues(alpha: 0.12)
            : AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: active ? activeColor.withValues(alpha: 0.5) : AppColors.border,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: active ? activeColor : AppColors.textTertiary,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.labelMedium),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: active
                  ? activeColor.withValues(alpha: 0.15)
                  : AppColors.border,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              active ? 'ON' : 'OFF',
              style: AppTextStyles.labelSmall.copyWith(
                color: active ? activeColor : AppColors.textTertiary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Last-update timestamps for all nodes
// ---------------------------------------------------------------------------

class _UpdatesCard extends StatelessWidget {
  final DeviceSnapshot data;
  const _UpdatesCard(this.data);

  @override
  Widget build(BuildContext context) {
    final rows = [
      _TsEntry('System', data.system.timestamp),
      _TsEntry('IMU', data.imu.timestamp),
      _TsEntry('GPS', data.gps.timestamp),
      _TsEntry('Alerts', data.alerts.timestamp),
      _TsEntry('Audio', data.audio.timestamp),
      _TsEntry('Actuators', data.actuators.timestamp),
    ];
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Last Updates', style: AppTextStyles.titleMedium),
          const SizedBox(height: 12),
          ...rows.map((e) => _TsRow(entry: e)),
        ],
      ),
    );
  }
}

class _TsEntry {
  final String label;
  final String timestamp;
  const _TsEntry(this.label, this.timestamp);
}

class _TsRow extends StatelessWidget {
  final _TsEntry entry;
  const _TsRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            entry.label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            entry.timestamp.isEmpty ? '—' : _formatTs(entry.timestamp),
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// App info
// ---------------------------------------------------------------------------

class _InfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Device Info', style: AppTextStyles.titleMedium),
          const SizedBox(height: 12),
          _InfoRow('App', 'Protectra'),
          _InfoRow('Database', 'rpi-prototype (asia-southeast1)'),
          _InfoRow('Platform', 'Firebase RTDB'),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared card wrapper
// ---------------------------------------------------------------------------

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
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
      child: child,
    );
  }
}

// ---------------------------------------------------------------------------
// Helper
// ---------------------------------------------------------------------------

String _formatTs(String ts) {
  if (ts.isEmpty) return '—';
  try {
    final parts = ts.split('_');
    if (parts.length == 2) {
      final date = parts[0];
      final time = parts[1].replaceAll('-', ':');
      return '$date  $time';
    }
  } catch (_) {}
  return ts;
}
