/// Firebase Realtime Database models for the Safety Device Companion app.
/// These models map directly to the structure stored in the RTDB.

// ──────────────────────────────────────────────────────────────────────────────
// Root device data snapshot
// ──────────────────────────────────────────────────────────────────────────────

class DeviceSnapshot {
  final ActuatorData actuators;
  final AlertData alerts;
  final AudioData audio;
  final GpsData gps;
  final ImuData imu;
  final SystemData system;

  const DeviceSnapshot({
    required this.actuators,
    required this.alerts,
    required this.audio,
    required this.gps,
    required this.imu,
    required this.system,
  });

  factory DeviceSnapshot.fromMap(Map<dynamic, dynamic> map) {
    return DeviceSnapshot(
      actuators: ActuatorData.fromMap(
        (map['actuators'] as Map<dynamic, dynamic>?) ?? {},
      ),
      alerts: AlertData.fromMap(
        (map['alerts'] as Map<dynamic, dynamic>?) ?? {},
      ),
      audio: AudioData.fromMap((map['audio'] as Map<dynamic, dynamic>?) ?? {}),
      gps: GpsData.fromMap((map['gps'] as Map<dynamic, dynamic>?) ?? {}),
      imu: ImuData.fromMap((map['imu'] as Map<dynamic, dynamic>?) ?? {}),
      system: SystemData.fromMap(
        (map['system'] as Map<dynamic, dynamic>?) ?? {},
      ),
    );
  }

  /// A safe "empty" value used before the first snapshot arrives.
  static DeviceSnapshot empty() => DeviceSnapshot(
    actuators: ActuatorData.empty(),
    alerts: AlertData.empty(),
    audio: AudioData.empty(),
    gps: GpsData.empty(),
    imu: ImuData.empty(),
    system: SystemData.empty(),
  );
}

// ──────────────────────────────────────────────────────────────────────────────
// actuators/
// ──────────────────────────────────────────────────────────────────────────────

class ActuatorData {
  final bool buzzer;
  final bool led;
  final String timestamp;

  const ActuatorData({
    required this.buzzer,
    required this.led,
    required this.timestamp,
  });

  factory ActuatorData.fromMap(Map<dynamic, dynamic> map) {
    return ActuatorData(
      buzzer: (map['buzzer'] as bool?) ?? false,
      led: (map['led'] as bool?) ?? false,
      timestamp: (map['timestamp'] as String?) ?? '',
    );
  }

  factory ActuatorData.empty() =>
      const ActuatorData(buzzer: false, led: false, timestamp: '');
}

// ──────────────────────────────────────────────────────────────────────────────
// alerts/
// ──────────────────────────────────────────────────────────────────────────────

class AlertData {
  final AlertGpsData gps;
  final bool smsSent;
  final String timestamp;

  const AlertData({
    required this.gps,
    required this.smsSent,
    required this.timestamp,
  });

  factory AlertData.fromMap(Map<dynamic, dynamic> map) {
    return AlertData(
      gps: AlertGpsData.fromMap((map['gps'] as Map<dynamic, dynamic>?) ?? {}),
      smsSent: (map['sms_sent'] as bool?) ?? false,
      timestamp: (map['timestamp'] as String?) ?? '',
    );
  }

  factory AlertData.empty() =>
      AlertData(gps: AlertGpsData.empty(), smsSent: false, timestamp: '');
}

class AlertGpsData {
  final bool valid;

  const AlertGpsData({required this.valid});

  factory AlertGpsData.fromMap(Map<dynamic, dynamic> map) {
    return AlertGpsData(valid: (map['valid'] as bool?) ?? false);
  }

  factory AlertGpsData.empty() => const AlertGpsData(valid: false);
}

// ──────────────────────────────────────────────────────────────────────────────
// audio/
// ──────────────────────────────────────────────────────────────────────────────

class AudioData {
  final String keyword;
  final String timestamp;
  final bool voiceTriggered;

  const AudioData({
    required this.keyword,
    required this.timestamp,
    required this.voiceTriggered,
  });

  factory AudioData.fromMap(Map<dynamic, dynamic> map) {
    return AudioData(
      keyword: (map['keyword'] as String?) ?? '',
      timestamp: (map['timestamp'] as String?) ?? '',
      voiceTriggered: (map['voice_triggered'] as bool?) ?? false,
    );
  }

  factory AudioData.empty() =>
      const AudioData(keyword: '', timestamp: '', voiceTriggered: false);
}

// ──────────────────────────────────────────────────────────────────────────────
// gps/
// ──────────────────────────────────────────────────────────────────────────────

class GpsData {
  final GpsRawData raw;
  final String timestamp;
  final bool valid;

  const GpsData({
    required this.raw,
    required this.timestamp,
    required this.valid,
  });

  factory GpsData.fromMap(Map<dynamic, dynamic> map) {
    return GpsData(
      raw: GpsRawData.fromMap((map['raw'] as Map<dynamic, dynamic>?) ?? {}),
      timestamp: (map['timestamp'] as String?) ?? '',
      valid: (map['valid'] as bool?) ?? false,
    );
  }

  factory GpsData.empty() =>
      GpsData(raw: GpsRawData.empty(), timestamp: '', valid: false);

  /// Parsed latitude (null when field is empty or invalid).
  double? get latitude {
    final s = raw.latitude.trim();
    if (s.isEmpty) return null;
    return double.tryParse(s);
  }

  /// Parsed longitude (null when field is empty or invalid).
  double? get longitude {
    final s = raw.longitude.trim();
    if (s.isEmpty) return null;
    return double.tryParse(s);
  }

  /// Parsed speed in knots (null when field is empty or invalid).
  double? get speedKnots {
    final s = raw.speedKnots.trim();
    if (s.isEmpty) return null;
    return double.tryParse(s);
  }
}

class GpsRawData {
  final String courseDeg;
  final String date;
  final String latitude;
  final String longitude;
  final String speedKnots;
  final String status;
  final String utcTime;

  const GpsRawData({
    required this.courseDeg,
    required this.date,
    required this.latitude,
    required this.longitude,
    required this.speedKnots,
    required this.status,
    required this.utcTime,
  });

  factory GpsRawData.fromMap(Map<dynamic, dynamic> map) {
    return GpsRawData(
      courseDeg: (map['course_deg'] as String?) ?? '',
      date: (map['date'] as String?) ?? '',
      latitude: (map['latitude'] as String?) ?? '',
      longitude: (map['longitude'] as String?) ?? '',
      speedKnots: (map['speed_knots'] as String?) ?? '',
      status: (map['status'] as String?) ?? '',
      utcTime: (map['utc_time'] as String?) ?? '',
    );
  }

  factory GpsRawData.empty() => const GpsRawData(
    courseDeg: '',
    date: '',
    latitude: '',
    longitude: '',
    speedKnots: '',
    status: '',
    utcTime: '',
  );

  /// "A" = Active/Fix, "V" = Void/No fix
  bool get hasFix => status.toUpperCase() == 'A';
}

// ──────────────────────────────────────────────────────────────────────────────
// imu/
// ──────────────────────────────────────────────────────────────────────────────

class ImuData {
  final int dangerLevel;
  final String timestamp;

  const ImuData({required this.dangerLevel, required this.timestamp});

  factory ImuData.fromMap(Map<dynamic, dynamic> map) {
    return ImuData(
      dangerLevel: (map['danger_level'] as int?) ?? 0,
      timestamp: (map['timestamp'] as String?) ?? '',
    );
  }

  factory ImuData.empty() => const ImuData(dangerLevel: 0, timestamp: '');

  String get dangerLabel {
    switch (dangerLevel) {
      case 0:
        return 'Safe';
      case 1:
        return 'Low Risk';
      case 2:
        return 'Medium Risk';
      case 3:
        return 'High Risk';
      default:
        return 'Unknown ($dangerLevel)';
    }
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// system/
// ──────────────────────────────────────────────────────────────────────────────

class SystemData {
  final bool emergency;
  final String state;
  final String timestamp;

  const SystemData({
    required this.emergency,
    required this.state,
    required this.timestamp,
  });

  factory SystemData.fromMap(Map<dynamic, dynamic> map) {
    return SystemData(
      emergency: (map['emergency'] as bool?) ?? false,
      state: (map['state'] as String?) ?? '',
      timestamp: (map['timestamp'] as String?) ?? '',
    );
  }

  factory SystemData.empty() =>
      const SystemData(emergency: false, state: '', timestamp: '');
}
