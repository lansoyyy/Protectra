/// App Constants for Simbayanan
/// Contains all constant values used throughout the application
class AppConstants {
  AppConstants._();

  // ==================== APP INFO ====================

  static const String appName = 'Simbayanan';
  static const String appDescription = 'Task Management Application';

  // ==================== API ====================

  static const String apiBaseUrl = 'https://api.simbayanan.com';
  static const int apiTimeout = 30000; // 30 seconds
  static const int apiConnectTimeout = 15000; // 15 seconds

  // ==================== STORAGE KEYS ====================

  static const String keyAuthToken = 'auth_token';
  static const String keyUserId = 'user_id';
  static const String keyUserName = 'user_name';
  static const String keyUserEmail = 'user_email';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyOnboardingCompleted = 'onboarding_completed';

  // ==================== PAGINATION ====================

  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // ==================== ANIMATION DURATIONS ====================

  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // ==================== DEBOUNCE ====================

  static const Duration debounceDelay = Duration(milliseconds: 300);
  static const Duration searchDebounceDelay = Duration(milliseconds: 500);

  // ==================== VALIDATION ====================

  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int maxUsernameLength = 50;
  static const int maxTitleLength = 100;
  static const int maxDescriptionLength = 1000;
  static const int maxCommentLength = 500;

  // ==================== DATE FORMATS ====================

  static const String dateFormatDisplay = 'MMM dd, yyyy';
  static const String dateFormatShort = 'MM/dd/yyyy';
  static const String dateFormatFull = 'MMMM dd, yyyy';
  static const String dateFormatMonthYear = 'MMMM yyyy';
  static const String timeFormatDisplay = 'hh:mm a';
  static const String dateTimeFormatDisplay = 'MMM dd, yyyy hh:mm a';
  static const String dateTimeFormatShort = 'MM/dd/yyyy hh:mm a';

  // ==================== REGEX PATTERNS ====================

  static const String emailRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String passwordRegex =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
  static const String usernameRegex = r'^[a-zA-Z0-9_]{3,20}$';
  static const String urlRegex =
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$';

  // ==================== FILE SIZES ====================

  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxVideoSize = 50 * 1024 * 1024; // 50MB

  // ==================== SUPPORTED IMAGE FORMATS ====================

  static const List<String> supportedImageFormats = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
    'bmp',
  ];

  // ==================== SUPPORTED FILE FORMATS ====================

  static const List<String> supportedFileFormats = [
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx',
    'ppt',
    'pptx',
    'txt',
    'csv',
    'json',
    'xml',
    'zip',
    'rar',
  ];

  // ==================== TASK PRIORITIES ====================

  static const List<String> taskPriorities = [
    'low',
    'medium',
    'high',
    'urgent',
  ];

  // ==================== TASK STATUSES ====================

  static const List<String> taskStatuses = [
    'todo',
    'in_progress',
    'review',
    'done',
    'blocked',
  ];

  // ==================== TAG COLORS ====================

  static const List<String> tagColors = [
    '#3B82F6', // Blue
    '#10B981', // Green
    '#F59E0B', // Yellow
    '#EF4444', // Red
    '#8B5CF6', // Purple
    '#EC4899', // Pink
    '#06B6D4', // Cyan
    '#F97316', // Orange
  ];

  // ==================== SORT OPTIONS ====================

  static const List<String> sortOptions = [
    'created_at_desc',
    'created_at_asc',
    'due_date_asc',
    'due_date_desc',
    'priority_desc',
    'priority_asc',
    'title_asc',
    'title_desc',
  ];

  // ==================== NOTIFICATION TYPES ====================

  static const List<String> notificationTypes = [
    'task_assigned',
    'task_completed',
    'task_overdue',
    'comment_added',
    'mention',
    'system',
  ];
}
