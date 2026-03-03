import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/models/rtdb_models.dart';
import '../../../../core/services/rtdb_service.dart';

/// Location screen – shows live GPS data from the IoT device.
class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GPS Location'), elevation: 0),
      body: StreamBuilder<GpsData>(
        stream: RtdbService.instance.gpsStream,
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

          final gps = snapshot.data ?? GpsData.empty();
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _GpsStatusCard(gps: gps),
              const SizedBox(height: 16),
              _CoordinatesCard(gps: gps),
              const SizedBox(height: 16),
              _RawDataCard(raw: gps.raw),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GPS status header card
// ─────────────────────────────────────────────────────────────────────────────

class _GpsStatusCard extends StatelessWidget {
  const _GpsStatusCard({required this.gps});
  final GpsData gps;

  @override
  Widget build(BuildContext context) {
    final hasFix = gps.valid && gps.raw.hasFix;
    final color = hasFix ? AppColors.success : AppColors.error;
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              hasFix ? Icons.gps_fixed_rounded : Icons.gps_off_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasFix ? 'GPS Fix Active' : 'No GPS Fix',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hasFix
                      ? 'Location data is valid'
                      : 'Waiting for satellite signal...',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              gps.raw.status.isEmpty ? '—' : gps.raw.status,
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Coordinates card
// ─────────────────────────────────────────────────────────────────────────────

class _CoordinatesCard extends StatelessWidget {
  const _CoordinatesCard({required this.gps});
  final GpsData gps;

  @override
  Widget build(BuildContext context) {
    final lat = gps.latitude;
    final lng = gps.longitude;
    final speed = gps.speedKnots;
    final hasCoords = lat != null && lng != null;

    return _Card(
      title: 'Coordinates',
      icon: Icons.location_on_rounded,
      iconColor: AppColors.primary,
      child: Column(
        children: [
          if (!hasCoords)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'No coordinates available yet',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            )
          else ...[
            _Row(
              icon: Icons.north_rounded,
              label: 'Latitude',
              value: lat.toStringAsFixed(6),
            ),
            const SizedBox(height: 10),
            _Row(
              icon: Icons.east_rounded,
              label: 'Longitude',
              value: lng.toStringAsFixed(6),
            ),
          ],
          const SizedBox(height: 10),
          _Row(
            icon: Icons.speed_rounded,
            label: 'Speed',
            value: speed == null ? '—' : '${speed.toStringAsFixed(2)} knots',
          ),
          const SizedBox(height: 10),
          _Row(
            icon: Icons.explore_rounded,
            label: 'Course',
            value: gps.raw.courseDeg.isEmpty ? '—' : '${gps.raw.courseDeg}°',
          ),
          const SizedBox(height: 10),
          _Row(
            icon: Icons.access_time_rounded,
            label: 'Last Update',
            value: gps.timestamp.isEmpty ? '—' : _formatTs(gps.timestamp),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Raw NMEA data card
// ─────────────────────────────────────────────────────────────────────────────

class _RawDataCard extends StatelessWidget {
  const _RawDataCard({required this.raw});
  final GpsRawData raw;

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Raw GPS Data',
      icon: Icons.data_object_rounded,
      iconColor: AppColors.secondary,
      child: Column(
        children: [
          _Row(
            icon: Icons.calendar_today_rounded,
            label: 'Date',
            value: raw.date.isEmpty ? '—' : raw.date,
          ),
          const SizedBox(height: 10),
          _Row(
            icon: Icons.access_time_rounded,
            label: 'UTC Time',
            value: raw.utcTime.isEmpty ? '—' : raw.utcTime,
          ),
          const SizedBox(height: 10),
          _Row(
            icon: Icons.location_searching_rounded,
            label: 'Raw Latitude',
            value: raw.latitude.isEmpty ? '—' : raw.latitude,
          ),
          const SizedBox(height: 10),
          _Row(
            icon: Icons.location_searching_rounded,
            label: 'Raw Longitude',
            value: raw.longitude.isEmpty ? '—' : raw.longitude,
          ),
          const SizedBox(height: 10),
          _Row(
            icon: Icons.speed_rounded,
            label: 'Speed (raw)',
            value: raw.speedKnots.isEmpty ? '—' : '${raw.speedKnots} knots',
          ),
          const SizedBox(height: 10),
          _Row(
            icon: Icons.navigation_rounded,
            label: 'Status',
            value: raw.status.isEmpty
                ? '—'
                : raw.hasFix
                ? '${raw.status} (Active)'
                : '${raw.status} (Void)',
            valueColor: raw.hasFix ? AppColors.success : AppColors.error,
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
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget child;

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
                Text(title, style: AppTextStyles.titleSmall),
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
