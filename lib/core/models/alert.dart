/// Alert model for Protectra - Safety Device Companion
/// Represents a safety alert received from the wearable device
class Alert {
  final String id;
  final int dangerLevel; // 1 = Low, 2 = Medium, 3 = High
  final String description;
  final DateTime timestamp;
  final String? deviceId;
  final bool isRead;
  final bool isManualTrigger;

  Alert({
    required this.id,
    required this.dangerLevel,
    required this.description,
    required this.timestamp,
    this.deviceId,
    this.isRead = false,
    this.isManualTrigger = false,
  });

  /// Get danger level label
  String get dangerLevelLabel {
    switch (dangerLevel) {
      case 1:
        return 'Low Risk';
      case 2:
        return 'Medium Risk';
      case 3:
        return 'High Risk';
      default:
        return 'Unknown';
    }
  }

  /// Get danger level color (as hex string for UI)
  String get dangerLevelColor {
    switch (dangerLevel) {
      case 1:
        return '#FBBF24'; // Amber
      case 2:
        return '#F97316'; // Orange
      case 3:
        return '#EF4444'; // Red
      default:
        return '#6B7280'; // Gray
    }
  }

  /// Check if alert is recent (within 24 hours)
  bool get isRecent {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    return difference.inHours < 24;
  }

  /// Copy with method for immutability
  Alert copyWith({
    String? id,
    int? dangerLevel,
    String? description,
    DateTime? timestamp,
    String? deviceId,
    bool? isRead,
    bool? isManualTrigger,
  }) {
    return Alert(
      id: id ?? this.id,
      dangerLevel: dangerLevel ?? this.dangerLevel,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      deviceId: deviceId ?? this.deviceId,
      isRead: isRead ?? this.isRead,
      isManualTrigger: isManualTrigger ?? this.isManualTrigger,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dangerLevel': dangerLevel,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'deviceId': deviceId,
      'isRead': isRead,
      'isManualTrigger': isManualTrigger,
    };
  }

  /// Create from JSON
  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      id: json['id'] as String,
      dangerLevel: json['dangerLevel'] as int,
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      deviceId: json['deviceId'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      isManualTrigger: json['isManualTrigger'] as bool? ?? false,
    );
  }
}
