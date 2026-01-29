import 'alert.dart';
import 'location.dart';

/// Event model for Protectra - Safety Device Companion
/// Represents a safety event in the timeline
class SafetyEvent {
  final String id;
  final EventType type;
  final DateTime timestamp;
  final int? dangerLevel;
  final String? description;
  final LocationData? location;
  final List<Evidence>? evidence;
  final String deviceId;

  SafetyEvent({
    required this.id,
    required this.type,
    required this.timestamp,
    this.dangerLevel,
    this.description,
    this.location,
    this.evidence,
    required this.deviceId,
  });

  /// Get event type label
  String get typeLabel {
    switch (type) {
      case EventType.dangerDetected:
        return 'Danger Detected';
      case EventType.alertSent:
        return 'Alert Sent';
      case EventType.audioRecorded:
        return 'Audio Recorded';
      case EventType.videoRecorded:
        return 'Video Recorded';
      case EventType.locationUpdated:
        return 'Location Updated';
      case EventType.deviceConnected:
        return 'Device Connected';
      case EventType.deviceDisconnected:
        return 'Device Disconnected';
    }
  }

  /// Get event type icon
  String get typeIcon {
    switch (type) {
      case EventType.dangerDetected:
        return 'warning';
      case EventType.alertSent:
        return 'notifications_active';
      case EventType.audioRecorded:
        return 'mic';
      case EventType.videoRecorded:
        return 'videocam';
      case EventType.locationUpdated:
        return 'location_on';
      case EventType.deviceConnected:
        return 'bluetooth_connected';
      case EventType.deviceDisconnected:
        return 'bluetooth_disabled';
    }
  }

  /// Check if event has evidence
  bool get hasEvidence => evidence != null && evidence!.isNotEmpty;

  /// Copy with method
  SafetyEvent copyWith({
    String? id,
    EventType? type,
    DateTime? timestamp,
    int? dangerLevel,
    String? description,
    LocationData? location,
    List<Evidence>? evidence,
    String? deviceId,
  }) {
    return SafetyEvent(
      id: id ?? this.id,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      dangerLevel: dangerLevel ?? this.dangerLevel,
      description: description ?? this.description,
      location: location ?? this.location,
      evidence: evidence ?? this.evidence,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'timestamp': timestamp.toIso8601String(),
      'dangerLevel': dangerLevel,
      'description': description,
      'location': location?.toJson(),
      'evidence': evidence?.map((e) => e.toJson()).toList(),
      'deviceId': deviceId,
    };
  }

  /// Create from JSON
  factory SafetyEvent.fromJson(Map<String, dynamic> json) {
    return SafetyEvent(
      id: json['id'] as String,
      type: EventType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => EventType.dangerDetected,
      ),
      timestamp: DateTime.parse(json['timestamp'] as String),
      dangerLevel: json['dangerLevel'] as int?,
      description: json['description'] as String?,
      location: json['location'] != null
          ? LocationData.fromJson(json['location'] as Map<String, dynamic>)
          : null,
      evidence: json['evidence'] != null
          ? (json['evidence'] as List)
                .map((e) => Evidence.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
      deviceId: json['deviceId'] as String,
    );
  }
}

/// Event types enum
enum EventType {
  dangerDetected,
  alertSent,
  audioRecorded,
  videoRecorded,
  locationUpdated,
  deviceConnected,
  deviceDisconnected,
}

/// Evidence model for audio/video clips
class Evidence {
  final String id;
  final EvidenceType type;
  final String filePath;
  final Duration duration;
  final DateTime timestamp;
  final int fileSizeBytes;

  Evidence({
    required this.id,
    required this.type,
    required this.filePath,
    required this.duration,
    required this.timestamp,
    required this.fileSizeBytes,
  });

  /// Get file size in human-readable format
  String get fileSize {
    if (fileSizeBytes < 1024) {
      return '$fileSizeBytes B';
    } else if (fileSizeBytes < 1024 * 1024) {
      return '${(fileSizeBytes / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(fileSizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }

  /// Get duration in human-readable format
  String get durationString {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    }
    return '${seconds}s';
  }

  /// Copy with method
  Evidence copyWith({
    String? id,
    EvidenceType? type,
    String? filePath,
    Duration? duration,
    DateTime? timestamp,
    int? fileSizeBytes,
  }) {
    return Evidence(
      id: id ?? this.id,
      type: type ?? this.type,
      filePath: filePath ?? this.filePath,
      duration: duration ?? this.duration,
      timestamp: timestamp ?? this.timestamp,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'filePath': filePath,
      'duration': duration.inSeconds,
      'timestamp': timestamp.toIso8601String(),
      'fileSizeBytes': fileSizeBytes,
    };
  }

  /// Create from JSON
  factory Evidence.fromJson(Map<String, dynamic> json) {
    return Evidence(
      id: json['id'] as String,
      type: EvidenceType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => EvidenceType.audio,
      ),
      filePath: json['filePath'] as String,
      duration: Duration(seconds: json['duration'] as int),
      timestamp: DateTime.parse(json['timestamp'] as String),
      fileSizeBytes: json['fileSizeBytes'] as int,
    );
  }
}

/// Evidence types enum
enum EvidenceType { audio, video }
