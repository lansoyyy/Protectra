import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Permissions Screen for Protectra app
/// Manages app permissions
class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  final Map<PermissionType, bool> _permissions = {
    PermissionType.notifications: true,
    PermissionType.location: true,
    PermissionType.camera: false,
    PermissionType.microphone: false,
    PermissionType.storage: true,
    PermissionType.bluetooth: true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permissions'), elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildInfoCard(),
          const SizedBox(height: 24),
          ...PermissionType.values.map((type) {
            return _buildPermissionItem(type);
          }),
          const SizedBox(height: 24),
          _buildExplanation(),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryLight, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_rounded, color: AppColors.textInverse, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Why Permissions Matter',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textInverse,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Protectra needs certain permissions to function properly. '
            'These permissions help keep you safe and ensure alerts are delivered.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textInverse.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionItem(PermissionType type) {
    final isGranted = _permissions[type] ?? false;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isGranted ? AppColors.secondary : AppColors.border,
          width: isGranted ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _getPermissionColor(type).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getPermissionIcon(type),
              color: isGranted
                  ? _getPermissionColor(type)
                  : AppColors.textTertiary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getPermissionName(type),
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _getPermissionDescription(type),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isGranted,
            onChanged: (value) {
              setState(() {
                _permissions[type] = value;
              });
              if (value) {
                _requestPermission(type);
              }
            },
            activeColor: AppColors.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildExplanation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Permission Details',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 12),
          ...PermissionType.values.map((type) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    _getPermissionIcon(type),
                    size: 16,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getPermissionName(type),
                          style: AppTextStyles.labelMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _getPermissionExplanation(type),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _getPermissionName(PermissionType type) {
    switch (type) {
      case PermissionType.notifications:
        return 'Notifications';
      case PermissionType.location:
        return 'Location';
      case PermissionType.camera:
        return 'Camera';
      case PermissionType.microphone:
        return 'Microphone';
      case PermissionType.storage:
        return 'Storage';
      case PermissionType.bluetooth:
        return 'Bluetooth';
    }
  }

  String _getPermissionDescription(PermissionType type) {
    switch (type) {
      case PermissionType.notifications:
        return 'Receive safety alerts';
      case PermissionType.location:
        return 'Track device location';
      case PermissionType.camera:
        return 'Record video evidence';
      case PermissionType.microphone:
        return 'Record audio evidence';
      case PermissionType.storage:
        return 'Save evidence files';
      case PermissionType.bluetooth:
        return 'Connect to device';
    }
  }

  IconData _getPermissionIcon(PermissionType type) {
    switch (type) {
      case PermissionType.notifications:
        return Icons.notifications_rounded;
      case PermissionType.location:
        return Icons.location_on_rounded;
      case PermissionType.camera:
        return Icons.videocam_rounded;
      case PermissionType.microphone:
        return Icons.mic_rounded;
      case PermissionType.storage:
        return Icons.folder_rounded;
      case PermissionType.bluetooth:
        return Icons.bluetooth_rounded;
    }
  }

  Color _getPermissionColor(PermissionType type) {
    switch (type) {
      case PermissionType.notifications:
        return AppColors.primary;
      case PermissionType.location:
        return AppColors.secondary;
      case PermissionType.camera:
        return AppColors.warning;
      case PermissionType.microphone:
        return AppColors.accent;
      case PermissionType.storage:
        return AppColors.dangerLevel3;
      case PermissionType.bluetooth:
        return AppColors.info;
    }
  }

  String _getPermissionExplanation(PermissionType type) {
    switch (type) {
      case PermissionType.notifications:
        return 'Used to send you push notifications when danger is detected.';
      case PermissionType.location:
        return 'Used to display device location on map and record location history.';
      case PermissionType.camera:
        return 'Used to record video evidence when danger is detected.';
      case PermissionType.microphone:
        return 'Used to record audio evidence when danger is detected.';
      case PermissionType.storage:
        return 'Used to store audio and video evidence on your device.';
      case PermissionType.bluetooth:
        return 'Used to connect and communicate with your Protectra wearable device.';
    }
  }

  void _requestPermission(PermissionType type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_getPermissionName(type)} permission requested'),
      ),
    );
  }
}

enum PermissionType {
  notifications,
  location,
  camera,
  microphone,
  storage,
  bluetooth,
}
