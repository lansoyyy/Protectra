import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Device Pairing Screen for Protectra app
/// Allows users to pair their wearable device via QR code or manual entry
class PairingScreen extends StatefulWidget {
  const PairingScreen({super.key});

  @override
  State<PairingScreen> createState() => _PairingScreenState();
}

class _PairingScreenState extends State<PairingScreen> {
  PairingMethod _selectedMethod = PairingMethod.qrCode;
  final TextEditingController _deviceIdController = TextEditingController();
  bool _isScanning = false;
  bool _isPairing = false;

  @override
  void dispose() {
    _deviceIdController.dispose();
    super.dispose();
  }

  void _selectMethod(PairingMethod method) {
    setState(() {
      _selectedMethod = method;
    });
  }

  void _startScanning() {
    setState(() {
      _isScanning = true;
    });
    // Simulate scanning
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
          _deviceIdController.text = 'PROTECTRA-DEVICE-001';
        });
        _showPairingSuccess();
      }
    });
  }

  void _manualPair() {
    if (_deviceIdController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a device ID')));
      return;
    }
    _pairDevice();
  }

  void _pairDevice() {
    setState(() {
      _isPairing = true;
    });
    // Simulate pairing
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isPairing = false;
        });
        _showPairingSuccess();
      }
    });
  }

  void _showPairingSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _PairingSuccessDialog(
        deviceId: _deviceIdController.text,
        onContinue: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed('/main');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pair Device'), elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Text(
                'Connect Your Device',
                style: AppTextStyles.headlineSmall.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pair your Protectra wearable device to start receiving safety alerts.',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // Method selection
              _buildMethodSelector(),
              const SizedBox(height: 32),

              // Content based on selected method
              Expanded(
                child: _selectedMethod == PairingMethod.qrCode
                    ? _buildQRCodeContent()
                    : _buildManualEntryContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMethodSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: PairingMethod.values.map((method) {
          final isSelected = _selectedMethod == method;
          return Expanded(
            child: GestureDetector(
              onTap: () => _selectMethod(method),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  children: [
                    Icon(
                      method.icon,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textTertiary,
                      size: 28,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      method.label,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQRCodeContent() {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border, width: 2),
            ),
            child: _isScanning ? _buildScanningView() : _buildQRPlaceholder(),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _isScanning ? null : _startScanning,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: _isScanning
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(AppColors.textInverse),
                    ),
                  )
                : Text('Scan QR Code', style: AppTextStyles.buttonTextLarge),
          ),
        ),
      ],
    );
  }

  Widget _buildQRPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.qr_code_scanner_rounded,
          size: 80,
          color: AppColors.textTertiary,
        ),
        const SizedBox(height: 16),
        Text(
          'Point camera at QR code',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Found on your Protectra device',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildScanningView() {
    return Stack(
      children: [
        // Scanning animation
        Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                // Corner markers
                Positioned(
                  top: -1,
                  left: -1,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColors.primary, width: 4),
                        left: BorderSide(color: AppColors.primary, width: 4),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -1,
                  right: -1,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColors.primary, width: 4),
                        right: BorderSide(color: AppColors.primary, width: 4),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -1,
                  left: -1,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.primary, width: 4),
                        left: BorderSide(color: AppColors.primary, width: 4),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -1,
                  right: -1,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.primary, width: 4),
                        right: BorderSide(color: AppColors.primary, width: 4),
                      ),
                    ),
                  ),
                ),
                // Scanning line
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeInOut,
                  top: 0,
                  child: Container(
                    width: 200,
                    height: 2,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Scanning text
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              'Scanning...',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildManualEntryContent() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Device ID',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _deviceIdController,
                decoration: InputDecoration(
                  hintText: 'Enter your device ID',
                  prefixIcon: const Icon(Icons.watch_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [UpperCaseTextFormatter()],
              ),
              const SizedBox(height: 16),
              Text(
                'Find your device ID on the back of your Protectra device or in the device settings.',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _isPairing ? null : _manualPair,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: _isPairing
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(AppColors.textInverse),
                    ),
                  )
                : Text('Pair Device', style: AppTextStyles.buttonTextLarge),
          ),
        ),
      ],
    );
  }
}

class _PairingSuccessDialog extends StatelessWidget {
  final String deviceId;
  final VoidCallback onContinue;

  const _PairingSuccessDialog({
    required this.deviceId,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: AppColors.secondary,
              size: 48,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Device Paired!',
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            deviceId,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your Protectra device is now connected and ready to use.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

enum PairingMethod { qrCode, manual }

extension PairingMethodExtension on PairingMethod {
  String get label {
    switch (this) {
      case PairingMethod.qrCode:
        return 'QR Code';
      case PairingMethod.manual:
        return 'Manual Entry';
    }
  }

  IconData get icon {
    switch (this) {
      case PairingMethod.qrCode:
        return Icons.qr_code_scanner_rounded;
      case PairingMethod.manual:
        return Icons.edit_rounded;
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
