/// Location model for Protectra - Safety Device Companion
/// Represents a location snapshot from the wearable device
class LocationData {
  final String id;
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final String? address;
  final double? accuracy; // in meters
  final String? eventId; // Associated event ID

  LocationData({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.address,
    this.accuracy,
    this.eventId,
  });

  /// Get coordinates as a string
  String get coordinates => '$latitude, $longitude';

  /// Check if location is accurate (accuracy < 50 meters)
  bool get isAccurate => accuracy != null && accuracy! < 50;

  /// Get accuracy label
  String get accuracyLabel {
    if (accuracy == null) return 'Unknown';
    if (accuracy! < 10) return 'High';
    if (accuracy! < 50) return 'Good';
    if (accuracy! < 100) return 'Fair';
    return 'Low';
  }

  /// Copy with method
  LocationData copyWith({
    String? id,
    double? latitude,
    double? longitude,
    DateTime? timestamp,
    String? address,
    double? accuracy,
    String? eventId,
  }) {
    return LocationData(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timestamp: timestamp ?? this.timestamp,
      address: address ?? this.address,
      accuracy: accuracy ?? this.accuracy,
      eventId: eventId ?? this.eventId,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
      'address': address,
      'accuracy': accuracy,
      'eventId': eventId,
    };
  }

  /// Create from JSON
  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      id: json['id'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      timestamp: DateTime.parse(json['timestamp'] as String),
      address: json['address'] as String?,
      accuracy: json['accuracy'] as double?,
      eventId: json['eventId'] as String?,
    );
  }

  /// Create a mock location for demo purposes
  factory LocationData.mock({
    String? id,
    double? latitude,
    double? longitude,
    DateTime? timestamp,
  }) {
    return LocationData(
      id: id ?? 'loc_${DateTime.now().millisecondsSinceEpoch}',
      latitude: latitude ?? 14.5995,
      longitude: longitude ?? 120.9842,
      timestamp: timestamp ?? DateTime.now(),
      address: 'Manila, Philippines',
      accuracy: 15.0,
    );
  }
}
