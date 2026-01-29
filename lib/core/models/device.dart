import 'location.dart';

/// Device model for Protectra - Safety Device Companion
/// Represents the wearable safety device
class Device {
  final String id;
  final String name;
  final DeviceStatus status;
  final int batteryLevel; // 0-100
  final DateTime lastHeartbeat;
  final DateTime? lastConnected;
  final String? firmwareVersion;
  final String? hardwareVersion;
  final LocationData? lastKnownLocation;

  Device({
    required this.id,
    required this.name,
    required this.status,
    required this.batteryLevel,
    required this.lastHeartbeat,
    this.lastConnected,
    this.firmwareVersion,
    this.hardwareVersion,
    this.lastKnownLocation,
  });

  /// Check if device is connected
  bool get isConnected => status == DeviceStatus.connected;

  /// Check if battery is low (less than 20%)
  bool get isBatteryLow => batteryLevel < 20;

  /// Check if battery is critical (less than 10%)
  bool get isBatteryCritical => batteryLevel < 10;

  /// Get battery status label
  String get batteryStatus {
    if (isBatteryCritical) return 'Critical';
    if (isBatteryLow) return 'Low';
    if (batteryLevel < 50) return 'Medium';
    return 'Good';
  }

  /// Get battery color (as hex string)
  String get batteryColor {
    if (isBatteryCritical) return '#EF4444'; // Red
    if (isBatteryLow) return '#F97316'; // Orange
    if (batteryLevel < 50) return '#FBBF24'; // Amber
    return '#10B981'; // Green
  }

  /// Get time since last heartbeat
  Duration get timeSinceHeartbeat {
    return DateTime.now().difference(lastHeartbeat);
  }

  /// Check if heartbeat is stale (more than 5 minutes)
  bool get isHeartbeatStale => timeSinceHeartbeat.inMinutes > 5;

  /// Get status label
  String get statusLabel {
    switch (status) {
      case DeviceStatus.connected:
        return 'Connected';
      case DeviceStatus.disconnected:
        return 'Disconnected';
      case DeviceStatus.connecting:
        return 'Connecting...';
      case DeviceStatus.error:
        return 'Error';
    }
  }

  /// Copy with method
  Device copyWith({
    String? id,
    String? name,
    DeviceStatus? status,
    int? batteryLevel,
    DateTime? lastHeartbeat,
    DateTime? lastConnected,
    String? firmwareVersion,
    String? hardwareVersion,
    LocationData? lastKnownLocation,
  }) {
    return Device(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      lastHeartbeat: lastHeartbeat ?? this.lastHeartbeat,
      lastConnected: lastConnected ?? this.lastConnected,
      firmwareVersion: firmwareVersion ?? this.firmwareVersion,
      hardwareVersion: hardwareVersion ?? this.hardwareVersion,
      lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status.name,
      'batteryLevel': batteryLevel,
      'lastHeartbeat': lastHeartbeat.toIso8601String(),
      'lastConnected': lastConnected?.toIso8601String(),
      'firmwareVersion': firmwareVersion,
      'hardwareVersion': hardwareVersion,
      'lastKnownLocation': lastKnownLocation?.toJson(),
    };
  }

  /// Create from JSON
  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'] as String,
      name: json['name'] as String,
      status: DeviceStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => DeviceStatus.disconnected,
      ),
      batteryLevel: json['batteryLevel'] as int,
      lastHeartbeat: DateTime.parse(json['lastHeartbeat'] as String),
      lastConnected: json['lastConnected'] != null
          ? DateTime.parse(json['lastConnected'] as String)
          : null,
      firmwareVersion: json['firmwareVersion'] as String?,
      hardwareVersion: json['hardwareVersion'] as String?,
      lastKnownLocation: json['lastKnownLocation'] != null
          ? LocationData.fromJson(
              json['lastKnownLocation'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  /// Create a mock device for demo purposes
  factory Device.mock({
    String? id,
    String? name,
    DeviceStatus? status,
    int? batteryLevel,
  }) {
    return Device(
      id: id ?? 'device_001',
      name: name ?? 'Protectra Device',
      status: status ?? DeviceStatus.connected,
      batteryLevel: batteryLevel ?? 75,
      lastHeartbeat: DateTime.now().subtract(const Duration(minutes: 2)),
      lastConnected: DateTime.now().subtract(const Duration(hours: 1)),
      firmwareVersion: '1.0.0',
      hardwareVersion: '1.0',
      lastKnownLocation: LocationData.mock(),
    );
  }
}

/// Device status enum
enum DeviceStatus { connected, disconnected, connecting, error }
