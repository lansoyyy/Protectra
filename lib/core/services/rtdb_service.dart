import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/rtdb_models.dart';

/// Provides real-time streams from the IoT device's Firebase Realtime Database.
///
/// The database URL matches the named app `'rpi-prototype'` initialised in
/// [main.dart].
class RtdbService {
  RtdbService._();

  static final RtdbService instance = RtdbService._();

  late final FirebaseDatabase _db = FirebaseDatabase.instanceFor(
    app: Firebase.app('rpi-prototype'),
    databaseURL:
        'https://rpi-prototype-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  // ──────────────────────────────────────────────────────────────────────────
  // Full device snapshot (root listener)
  // ──────────────────────────────────────────────────────────────────────────

  /// Stream of the complete device snapshot from the root of the database.
  Stream<DeviceSnapshot> get deviceStream {
    return _db.ref('/').onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return DeviceSnapshot.empty();
      return DeviceSnapshot.fromMap(data as Map<dynamic, dynamic>);
    });
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Individual node streams (convenience helpers)
  // ──────────────────────────────────────────────────────────────────────────

  Stream<SystemData> get systemStream {
    return _db.ref('system').onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return SystemData.empty();
      return SystemData.fromMap(data as Map<dynamic, dynamic>);
    });
  }

  Stream<ImuData> get imuStream {
    return _db.ref('imu').onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return ImuData.empty();
      return ImuData.fromMap(data as Map<dynamic, dynamic>);
    });
  }

  Stream<GpsData> get gpsStream {
    return _db.ref('gps').onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return GpsData.empty();
      return GpsData.fromMap(data as Map<dynamic, dynamic>);
    });
  }

  Stream<AlertData> get alertStream {
    return _db.ref('alerts').onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return AlertData.empty();
      return AlertData.fromMap(data as Map<dynamic, dynamic>);
    });
  }

  Stream<AudioData> get audioStream {
    return _db.ref('audio').onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return AudioData.empty();
      return AudioData.fromMap(data as Map<dynamic, dynamic>);
    });
  }

  Stream<ActuatorData> get actuatorStream {
    return _db.ref('actuators').onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return ActuatorData.empty();
      return ActuatorData.fromMap(data as Map<dynamic, dynamic>);
    });
  }
}
