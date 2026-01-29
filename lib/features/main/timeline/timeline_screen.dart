import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/models/event.dart';

/// Timeline screen for Protectra app
/// Displays chronological safety events and evidence
class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  late List<SafetyEvent> _events;
  EventFilter _selectedFilter = EventFilter.all;

  @override
  void initState() {
    super.initState();
    _initializeMockData();
  }

  void _initializeMockData() {
    final now = DateTime.now();
    _events = [
      SafetyEvent(
        id: 'event_1',
        type: EventType.dangerDetected,
        timestamp: now.subtract(const Duration(minutes: 5)),
        dangerLevel: 3,
        description: 'High-risk movement detected',
        deviceId: 'device_001',
        evidence: [
          Evidence(
            id: 'ev_1',
            type: EvidenceType.video,
            filePath: '/path/to/video1.mp4',
            duration: const Duration(seconds: 30),
            timestamp: now.subtract(const Duration(minutes: 5)),
            fileSizeBytes: 5242880,
          ),
        ],
      ),
      SafetyEvent(
        id: 'event_2',
        type: EventType.alertSent,
        timestamp: now.subtract(const Duration(minutes: 5)),
        deviceId: 'device_001',
      ),
      SafetyEvent(
        id: 'event_3',
        type: EventType.videoRecorded,
        timestamp: now.subtract(const Duration(minutes: 5)),
        deviceId: 'device_001',
        evidence: [
          Evidence(
            id: 'ev_2',
            type: EvidenceType.video,
            filePath: '/path/to/video2.mp4',
            duration: const Duration(seconds: 30),
            timestamp: now.subtract(const Duration(minutes: 5)),
            fileSizeBytes: 5242880,
          ),
        ],
      ),
      SafetyEvent(
        id: 'event_4',
        type: EventType.dangerDetected,
        timestamp: now.subtract(const Duration(hours: 2)),
        dangerLevel: 2,
        description: 'Unusual activity detected',
        deviceId: 'device_001',
        evidence: [
          Evidence(
            id: 'ev_3',
            type: EvidenceType.audio,
            filePath: '/path/to/audio1.mp3',
            duration: const Duration(seconds: 15),
            timestamp: now.subtract(const Duration(hours: 2)),
            fileSizeBytes: 1048576,
          ),
        ],
      ),
      SafetyEvent(
        id: 'event_5',
        type: EventType.alertSent,
        timestamp: now.subtract(const Duration(hours: 2)),
        deviceId: 'device_001',
      ),
      SafetyEvent(
        id: 'event_6',
        type: EventType.locationUpdated,
        timestamp: now.subtract(const Duration(hours: 2)),
        deviceId: 'device_001',
      ),
      SafetyEvent(
        id: 'event_7',
        type: EventType.dangerDetected,
        timestamp: now.subtract(const Duration(days: 1)),
        dangerLevel: 1,
        description: 'Manual SOS triggered',
        deviceId: 'device_001',
        evidence: [
          Evidence(
            id: 'ev_4',
            type: EvidenceType.video,
            filePath: '/path/to/video3.mp4',
            duration: const Duration(seconds: 45),
            timestamp: now.subtract(const Duration(days: 1)),
            fileSizeBytes: 7864320,
          ),
          Evidence(
            id: 'ev_5',
            type: EvidenceType.audio,
            filePath: '/path/to/audio2.mp3',
            duration: const Duration(seconds: 20),
            timestamp: now.subtract(const Duration(days: 1)),
            fileSizeBytes: 1572864,
          ),
        ],
      ),
      SafetyEvent(
        id: 'event_8',
        type: EventType.deviceConnected,
        timestamp: now.subtract(const Duration(days: 2)),
        deviceId: 'device_001',
      ),
    ];
  }

  List<SafetyEvent> get _filteredEvents {
    switch (_selectedFilter) {
      case EventFilter.all:
        return _events;
      case EventFilter.danger:
        return _events
            .where((e) => e.type == EventType.dangerDetected)
            .toList();
      case EventFilter.alert:
        return _events.where((e) => e.type == EventType.alertSent).toList();
      case EventFilter.evidence:
        return _events.where((e) => e.hasEvidence).toList();
      case EventFilter.device:
        return _events
            .where(
              (e) =>
                  e.type == EventType.deviceConnected ||
                  e.type == EventType.deviceDisconnected,
            )
            .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timeline'), elevation: 0),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: _filteredEvents.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredEvents.length,
                    itemBuilder: (context, index) {
                      return _buildTimelineItem(_filteredEvents[index], index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: EventFilter.values.map((filter) {
            final isSelected = _selectedFilter == filter;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(filter.label),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedFilter = filter;
                  });
                },
                backgroundColor: AppColors.backgroundSecondary,
                selectedColor: AppColors.primarySurface,
                checkmarkColor: AppColors.primary,
                labelStyle: AppTextStyles.labelMedium.copyWith(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected ? AppColors.primary : AppColors.border,
                    width: 1,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_rounded, size: 64, color: AppColors.textTertiary),
          const SizedBox(height: 16),
          Text(
            'No events found',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try selecting a different filter',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(SafetyEvent event, int index) {
    final isLast = index == _filteredEvents.length - 1;
    final eventColor = _getEventColor(event);
    final showDate =
        index == 0 ||
        _formatDate(event.timestamp) !=
            _formatDate(_filteredEvents[index - 1].timestamp);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDate) ...[
          _buildDateHeader(event.timestamp),
          const SizedBox(height: 8),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTimelineLine(isLast, eventColor),
            const SizedBox(width: 16),
            Expanded(child: _buildEventCard(event, eventColor)),
          ],
        ),
      ],
    );
  }

  Widget _buildDateHeader(DateTime date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _formatDate(date),
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textInverse,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineLine(bool isLast, Color color) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(
            _getEventIcon(
              _filteredEvents[_events.indexOf(
                _filteredEvents.lastWhere(
                  (e) => e.timestamp == _filteredEvents.last.timestamp,
                  orElse: () => _filteredEvents.first,
                ),
              )],
            ),
            color: color,
            size: 20,
          ),
        ),
        if (!isLast) Container(width: 2, height: 80, color: AppColors.border),
      ],
    );
  }

  Widget _buildEventCard(SafetyEvent event, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(_getEventIcon(event), color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.typeLabel,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _formatTime(event.timestamp),
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              if (event.dangerLevel != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getDangerColor(
                      event.dangerLevel!,
                    ).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _getDangerLabel(event.dangerLevel!),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: _getDangerColor(event.dangerLevel!),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          if (event.description != null) ...[
            const SizedBox(height: 12),
            Text(event.description!, style: AppTextStyles.bodyMedium),
          ],
          if (event.hasEvidence) ...[
            const SizedBox(height: 12),
            _buildEvidencePreview(event.evidence!),
          ],
        ],
      ),
    );
  }

  Widget _buildEvidencePreview(List<Evidence> evidence) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Evidence (${evidence.length})',
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: evidence.map((e) {
            return _buildEvidenceChip(e);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildEvidenceChip(Evidence evidence) {
    return GestureDetector(
      onTap: () => _showEvidenceViewer(evidence),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primarySurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              evidence.type == EvidenceType.video
                  ? Icons.videocam_rounded
                  : Icons.mic_rounded,
              color: AppColors.primary,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              evidence.durationString,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getEventColor(SafetyEvent event) {
    switch (event.type) {
      case EventType.dangerDetected:
        return AppColors.dangerLevel3;
      case EventType.alertSent:
        return AppColors.warning;
      case EventType.audioRecorded:
      case EventType.videoRecorded:
        return AppColors.primary;
      case EventType.locationUpdated:
        return AppColors.secondary;
      case EventType.deviceConnected:
        return AppColors.statusConnected;
      case EventType.deviceDisconnected:
        return AppColors.statusDisconnected;
    }
  }

  IconData _getEventIcon(SafetyEvent event) {
    switch (event.type) {
      case EventType.dangerDetected:
        return Icons.warning_rounded;
      case EventType.alertSent:
        return Icons.notifications_active_rounded;
      case EventType.audioRecorded:
        return Icons.mic_rounded;
      case EventType.videoRecorded:
        return Icons.videocam_rounded;
      case EventType.locationUpdated:
        return Icons.location_on_rounded;
      case EventType.deviceConnected:
        return Icons.bluetooth_connected_rounded;
      case EventType.deviceDisconnected:
        return Icons.bluetooth_disabled_rounded;
    }
  }

  Color _getDangerColor(int level) {
    switch (level) {
      case 1:
        return AppColors.dangerLevel1;
      case 2:
        return AppColors.dangerLevel2;
      case 3:
        return AppColors.dangerLevel3;
      default:
        return AppColors.textTertiary;
    }
  }

  String _getDangerLabel(int level) {
    switch (level) {
      case 1:
        return 'Low';
      case 2:
        return 'Medium';
      case 3:
        return 'High';
      default:
        return 'Unknown';
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDate = DateTime(date.year, date.month, date.day);

    if (eventDate == today) {
      return 'Today';
    } else if (eventDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM d, yyyy').format(date);
    }
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }

  void _showEvidenceViewer(Evidence evidence) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      evidence.type == EvidenceType.video
                          ? Icons.videocam_rounded
                          : Icons.mic_rounded,
                      size: 64,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      evidence.type == EvidenceType.video
                          ? 'Video Evidence'
                          : 'Audio Evidence',
                      style: AppTextStyles.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Duration: ${evidence.durationString} • Size: ${evidence.fileSize}',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close_rounded),
                            label: const Text('Close'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Play evidence
                            },
                            icon: const Icon(Icons.play_arrow_rounded),
                            label: const Text('Play'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum EventFilter { all, danger, alert, evidence, device }

extension EventFilterExtension on EventFilter {
  String get label {
    switch (this) {
      case EventFilter.all:
        return 'All';
      case EventFilter.danger:
        return 'Danger';
      case EventFilter.alert:
        return 'Alerts';
      case EventFilter.evidence:
        return 'Evidence';
      case EventFilter.device:
        return 'Device';
    }
  }
}
