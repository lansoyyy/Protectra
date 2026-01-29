import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/models/location.dart';

/// Location screen for Protectra app
/// Displays device location history and map view
class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late List<LocationData> _locations;
  LocationData? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _initializeMockData();
  }

  void _initializeMockData() {
    final now = DateTime.now();
    _locations = [
      LocationData(
        id: 'loc_1',
        latitude: 14.5995,
        longitude: 120.9842,
        timestamp: now.subtract(const Duration(minutes: 5)),
        address: 'Manila, Philippines',
        accuracy: 15.0,
        eventId: 'event_1',
      ),
      LocationData(
        id: 'loc_2',
        latitude: 14.5980,
        longitude: 120.9860,
        timestamp: now.subtract(const Duration(hours: 2)),
        address: 'Intramuros, Manila',
        accuracy: 12.0,
        eventId: 'event_2',
      ),
      LocationData(
        id: 'loc_3',
        latitude: 14.6050,
        longitude: 120.9800,
        timestamp: now.subtract(const Duration(hours: 5)),
        address: 'Ermita, Manila',
        accuracy: 18.0,
        eventId: 'event_3',
      ),
      LocationData(
        id: 'loc_4',
        latitude: 14.6100,
        longitude: 120.9750,
        timestamp: now.subtract(const Duration(days: 1)),
        address: 'Malate, Manila',
        accuracy: 20.0,
        eventId: 'event_4',
      ),
      LocationData(
        id: 'loc_5',
        latitude: 14.5950,
        longitude: 120.9900,
        timestamp: now.subtract(const Duration(days: 2)),
        address: 'Paco, Manila',
        accuracy: 25.0,
      ),
    ];
    _selectedLocation = _locations.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              // Refresh location
            },
          ),
        ],
      ),
      body: Column(children: [_buildMapPlaceholder(), _buildLocationList()]),
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primarySurface, AppColors.backgroundSecondary],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          // Map grid pattern
          CustomPaint(
            size: const Size(double.infinity, 300),
            painter: MapGridPainter(),
          ),
          // Location markers
          ..._locations.asMap().entries.map((entry) {
            final index = entry.key;
            final location = entry.value;
            final isSelected = _selectedLocation?.id == location.id;
            final isFirst = index == 0;

            return Positioned(
              left: _getMapX(location.longitude) - 12,
              top: _getMapY(location.latitude) - 12,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedLocation = location;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: isSelected ? 48 : 24,
                  height: isSelected ? 48 : 24,
                  decoration: BoxDecoration(
                    color: isFirst ? AppColors.dangerLevel3 : AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.textInverse, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color:
                            (isFirst
                                    ? AppColors.dangerLevel3
                                    : AppColors.primary)
                                .withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: isSelected
                      ? Icon(
                          isFirst
                              ? Icons.warning_rounded
                              : Icons.location_on_rounded,
                          color: AppColors.textInverse,
                          size: 24,
                        )
                      : null,
                ),
              ),
            );
          }),
          // Current location button
          Positioned(
            right: 16,
            bottom: 16,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.my_location_rounded),
                onPressed: () {
                  setState(() {
                    _selectedLocation = _locations.first;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationList() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Location History', style: AppTextStyles.titleMedium),
                  Text(
                    '${_locations.length} locations',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _locations.length,
                itemBuilder: (context, index) {
                  return _buildLocationItem(_locations[index], index == 0);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationItem(LocationData location, bool isLatest) {
    final isSelected = _selectedLocation?.id == location.id;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLocation = location;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
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
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isLatest
                    ? AppColors.dangerLevel3.withValues(alpha: 0.1)
                    : AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isLatest ? Icons.warning_rounded : Icons.location_on_rounded,
                color: isLatest ? AppColors.dangerLevel3 : AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (isLatest) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.dangerLevel3.withValues(
                              alpha: 0.15,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Latest',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.dangerLevel3,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Expanded(
                        child: Text(
                          location.address ?? 'Unknown location',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location.coordinates,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 12,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatTimestamp(location.timestamp),
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.gps_fixed_rounded,
                        size: 12,
                        color: location.isAccurate
                            ? AppColors.secondary
                            : AppColors.warning,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '±${location.accuracy?.toInt() ?? 0}m',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }

  double _getMapX(double longitude) {
    // Simple mapping for demo - in real app, use proper map projection
    final minLng = 120.9700;
    final maxLng = 120.9950;
    final normalized = (longitude - minLng) / (maxLng - minLng);
    return 40 + normalized * (MediaQuery.of(context).size.width - 80);
  }

  double _getMapY(double latitude) {
    // Simple mapping for demo - in real app, use proper map projection
    final minLat = 14.5900;
    final maxLat = 14.6150;
    final normalized = (latitude - minLat) / (maxLat - minLat);
    return 40 + normalized * 220;
  }

  String _formatTimestamp(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return DateFormat('MMM d, h:mm a').format(dateTime);
    }
  }
}

class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.3)
      ..strokeWidth = 1;

    // Draw grid lines
    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }

    // Draw roads (simple lines for demo)
    final roadPaint = Paint()
      ..color = AppColors.neutral300
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // Horizontal roads
    canvas.drawLine(const Offset(0, 100), Offset(size.width, 100), roadPaint);
    canvas.drawLine(const Offset(0, 200), Offset(size.width, 200), roadPaint);

    // Vertical roads
    canvas.drawLine(
      Offset(size.width * 0.3, 0),
      Offset(size.width * 0.3, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, 0),
      Offset(size.width * 0.7, size.height),
      roadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
