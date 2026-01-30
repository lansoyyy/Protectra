import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/models/event.dart';

/// Evidence Player Screen for Protectra app
/// Plays audio and video evidence clips
class EvidencePlayerScreen extends StatefulWidget {
  final Evidence evidence;

  const EvidencePlayerScreen({super.key, required this.evidence});

  @override
  State<EvidencePlayerScreen> createState() => _EvidencePlayerScreenState();
}

class _EvidencePlayerScreenState extends State<EvidencePlayerScreen> {
  bool _isPlaying = false;
  double _playbackPosition = 0.0;
  double _playbackSpeed = 1.0;
  bool _isMuted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.evidence.type == EvidenceType.video
              ? 'Video Evidence'
              : 'Audio Evidence',
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: () {
              // Share evidence
            },
          ),
          IconButton(
            icon: const Icon(Icons.download_rounded),
            onPressed: () {
              // Download evidence
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Player content
          Expanded(child: _buildPlayerContent()),
          // Player controls
          _buildPlayerControls(),
        ],
      ),
    );
  }

  Widget _buildPlayerContent() {
    if (widget.evidence.type == EvidenceType.video) {
      return _buildVideoPlayer();
    } else {
      return _buildAudioPlayer();
    }
  }

  Widget _buildVideoPlayer() {
    return Container(
      width: double.infinity,
      color: AppColors.neutral900,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                size: 48,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Video Player',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textInverse,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Connect to actual video file',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.neutral400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAudioPlayer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Audio waveform visualization
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  30,
                  (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 300 + (index * 10)),
                    width: 4,
                    height: _isPlaying
                        ? 20 + (index % 5) * 15.0
                        : 10 + (index % 3) * 10.0,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: AppColors.textInverse.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Play button
            GestureDetector(
              onTap: () {
                setState(() {
                  _isPlaying = !_isPlaying;
                });
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.textInverse,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowDark,
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  size: 40,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.evidence.durationString,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textInverse,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerControls() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Progress bar
          Column(
            children: [
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 8,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 16,
                  ),
                ),
                child: Slider(
                  value: _playbackPosition,
                  max: widget.evidence.duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _playbackPosition = value;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDuration(_playbackPosition.toInt()),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                  Text(
                    widget.evidence.durationString,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Control buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildControlButton(
                icon: Icons.replay_10_rounded,
                label: '-10s',
                onTap: () {
                  setState(() {
                    _playbackPosition = (_playbackPosition - 10).clamp(
                      0,
                      widget.evidence.duration.inSeconds.toDouble(),
                    );
                  });
                },
              ),
              _buildControlButton(
                icon: Icons.fast_rewind_rounded,
                label: 'Rewind',
                onTap: () {
                  setState(() {
                    _playbackPosition = (_playbackPosition - 5).clamp(
                      0,
                      widget.evidence.duration.inSeconds.toDouble(),
                    );
                  });
                },
              ),
              _buildControlButton(
                icon: Icons.fast_forward_rounded,
                label: 'Forward',
                onTap: () {
                  setState(() {
                    _playbackPosition = (_playbackPosition + 5).clamp(
                      0,
                      widget.evidence.duration.inSeconds.toDouble(),
                    );
                  });
                },
              ),
              _buildControlButton(
                icon: Icons.forward_10_rounded,
                label: '+10s',
                onTap: () {
                  setState(() {
                    _playbackPosition = (_playbackPosition + 10).clamp(
                      0,
                      widget.evidence.duration.inSeconds.toDouble(),
                    );
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Speed and mute controls
          Row(
            children: [
              Expanded(child: _buildSpeedControl()),
              const SizedBox(width: 16),
              Expanded(child: _buildMuteControl()),
            ],
          ),
          const SizedBox(height: 16),
          // Evidence info
          _buildEvidenceInfo(),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        IconButton(icon: Icon(icon), onPressed: onTap, iconSize: 28),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildSpeedControl() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Speed',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Row(
            children: [0.5, 0.75, 1.0, 1.25, 1.5, 2.0].map((speed) {
              final isSelected = _playbackSpeed == speed;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _playbackSpeed = speed;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${speed}x',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: isSelected
                          ? AppColors.textInverse
                          : AppColors.textSecondary,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMuteControl() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Audio',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isMuted = !_isMuted;
              });
            },
            child: Icon(
              _isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
              color: _isMuted ? AppColors.textTertiary : AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvidenceInfo() {
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
            'Evidence Details',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoRow('Duration', widget.evidence.durationString),
          _buildInfoRow('File Size', widget.evidence.fileSize),
          _buildInfoRow(
            'Type',
            widget.evidence.type == EvidenceType.video ? 'Video' : 'Audio',
          ),
          _buildInfoRow('Recorded', _formatDate(widget.evidence.timestamp)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes}:${secs.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
