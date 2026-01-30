import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/models/location.dart';

/// Enhanced Map Widget for Protectra app
/// Displays location markers with danger level indicators
class LocationMapWidget extends StatelessWidget {
  final List<LocationData> locations;
  final LocationData? selectedLocation;
  final Function(LocationData) onLocationSelected;
  final VoidCallback? onRefresh;

  const LocationMapWidget({
    super.key,
    required this.locations,
    this.selectedLocation,
    required this.onLocationSelected,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
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
          ...locations.asMap().entries.map((entry) {
            final index = entry.key;
            final location = entry.value;
            final isSelected = selectedLocation?.id == location.id;
            final isFirst = index == 0;

            return Positioned(
              left: _getMapX(location.longitude) - 12,
              top: _getMapY(location.latitude) - 12,
              child: GestureDetector(
                onTap: () => onLocationSelected(location),
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
                  if (locations.isNotEmpty) {
                    onLocationSelected(locations.first);
                  }
                },
              ),
            ),
          ),
          // Refresh button
          if (onRefresh != null)
            Positioned(
              right: 16,
              bottom: 72,
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
                  icon: const Icon(Icons.refresh_rounded),
                  onPressed: onRefresh,
                ),
              ),
            ),
        ],
      ),
    );
  }

  double _getMapX(double longitude) {
    // Simple mapping for demo - in real app, use proper map projection
    final minLng = 120.9700;
    final maxLng = 120.9950;
    final normalized = (longitude - minLng) / (maxLng - minLng);
    return 40 + normalized * (MediaQueryData().size.width - 80);
  }

  double _getMapY(double latitude) {
    // Simple mapping for demo - in real app, use proper map projection
    final minLat = 14.5900;
    final maxLat = 14.6150;
    final normalized = (latitude - minLat) / (maxLat - minLat);
    return 40 + normalized * 220;
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
