import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Privacy Policy Screen for Protectra app
/// Displays the app's privacy policy
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy'), elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSection(
            'Data Collection',
            'Protectra collects the following data types:\n\n'
                '• Device location data (GPS coordinates)\n'
                '• Alert notifications and timestamps\n'
                '• Audio and video evidence clips\n'
                '• Device status information (battery, connectivity)\n'
                '• User profile and trusted contact information',
          ),
          _buildSection(
            'Data Usage',
            'Your data is used to:\n\n'
                '• Send you safety alerts and notifications\n'
                '• Display location history on the map\n'
                '• Provide evidence for review\n'
                '• Connect you with emergency contacts\n'
                '• Monitor device status',
          ),
          _buildSection(
            'Data Storage',
            'All data is stored securely on our servers. '
                'Evidence clips are retained for 30 days before being automatically deleted. '
                'You can request deletion of your data at any time.',
          ),
          _buildSection(
            'Data Sharing',
            'Protectra does NOT:\n\n'
                '• Sell your personal data\n'
                '• Share data with third parties for marketing\n'
                '• Access your camera or microphone without consent\n\n'
                'Protectra DOES share data with:\n'
                '• Your trusted contacts during alerts\n'
                '• Emergency services when you initiate a call',
          ),
          _buildSection(
            'Your Rights',
            'You have the right to:\n\n'
                '• Access your personal data\n'
                '• Request deletion of your data\n'
                '• Opt out of data collection\n'
                '• Export your data',
          ),
          _buildSection(
            'Contact Us',
            'For privacy concerns, contact us at:\n\n'
                '📧 privacy@protectra.app\n'
                '🌐 www.protectra.app/privacy',
          ),
          const SizedBox(height: 20),
          Text(
            'Last updated: January 2025',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
