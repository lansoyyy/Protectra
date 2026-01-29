import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Extensions for Simbayanan
/// Provides useful extensions for various Flutter types

// ==================== STRING EXTENSIONS ====================

extension StringExtensions on String {
  /// Check if string is empty or null
  bool get isNullOrEmpty => trim().isEmpty;

  /// Check if string is not empty
  bool get isNotEmpty => trim().isNotEmpty;

  /// Capitalize first letter
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize each word
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Convert to title case
  String get toTitleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Truncate string with ellipsis
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }

  /// Remove all whitespace
  String get removeAllWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Check if string is email
  bool get isEmail {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this);
  }

  /// Check if string is URL
  bool get isUrl {
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    return urlRegex.hasMatch(this);
  }

  /// Check if string is numeric
  bool get isNumeric {
    return num.tryParse(this) != null;
  }

  /// Check if string is a valid phone number
  bool get isPhoneNumber {
    final phoneRegex = RegExp(r'^\+?[\d\s-()]{10,}$');
    return phoneRegex.hasMatch(this);
  }

  /// Convert to color from hex string
  Color? toColor() {
    final hexColor = replaceAll('#', '');
    if (hexColor.length == 6) {
      return Color(int.parse('FF$hexColor', radix: 16));
    } else if (hexColor.length == 8) {
      return Color(int.parse(hexColor, radix: 16));
    }
    return null;
  }
}

// ==================== NUMERIC EXTENSIONS ====================

extension NumExtensions on num {
  /// Convert to duration in milliseconds
  Duration get milliseconds => Duration(milliseconds: toInt());

  /// Convert to duration in seconds
  Duration get seconds => Duration(seconds: toInt());

  /// Convert to duration in minutes
  Duration get minutes => Duration(minutes: toInt());

  /// Convert to duration in hours
  Duration get hours => Duration(hours: toInt());

  /// Convert to duration in days
  Duration get days => Duration(days: toInt());

  /// Convert to size
  Size get size => Size(toDouble(), toDouble());

  /// Convert to offset
  Offset get offset => Offset(toDouble(), toDouble());

  /// Convert to radius
  Radius get radius => Radius.circular(toDouble());

  /// Convert to border radius
  BorderRadius get borderRadius => BorderRadius.circular(toDouble());

  /// Convert to padding
  EdgeInsets get padding => EdgeInsets.all(toDouble());

  /// Convert to symmetric padding (horizontal)
  EdgeInsets get paddingHorizontal =>
      EdgeInsets.symmetric(horizontal: toDouble());

  /// Convert to symmetric padding (vertical)
  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: toDouble());

  /// Convert to only padding (left)
  EdgeInsets get paddingLeft => EdgeInsets.only(left: toDouble());

  /// Convert to only padding (right)
  EdgeInsets get paddingRight => EdgeInsets.only(right: toDouble());

  /// Convert to only padding (top)
  EdgeInsets get paddingTop => EdgeInsets.only(top: toDouble());

  /// Convert to only padding (bottom)
  EdgeInsets get paddingBottom => EdgeInsets.only(bottom: toDouble());

  /// Format as currency
  String toCurrency({String symbol = '\$'}) {
    return '$symbol${toStringAsFixed(2)}';
  }

  /// Format as percentage
  String toPercentage({int decimalPlaces = 1}) {
    return '${(this * 100).toStringAsFixed(decimalPlaces)}%';
  }
}

// ==================== DOUBLE EXTENSIONS ====================

extension DoubleExtensions on double {
  /// Round to specified decimal places
  double roundTo(int decimalPlaces) {
    final factor = math.pow(10, decimalPlaces).toDouble();
    return (this * factor).round() / factor;
  }

  /// Clamp between min and max
  double clampRange(double min, double max) {
    return clamp(min, max).toDouble();
  }

  /// Check if is between min and max (exclusive)
  bool isBetween(double min, double max) {
    return this > min && this < max;
  }

  /// Check if is between min and max (inclusive)
  bool isBetweenInclusive(double min, double max) {
    return this >= min && this <= max;
  }
}

// ==================== INT EXTENSIONS ====================

extension IntExtensions on int {
  /// Check if is even
  bool get isEven => this % 2 == 0;

  /// Check if is odd
  bool get isOdd => this % 2 != 0;

  /// Check if is positive
  bool get isPositive => this > 0;

  /// Check if is negative
  bool get isNegative => this < 0;

  /// Check if is zero
  bool get isZero => this == 0;

  /// Convert to ordinal (1st, 2nd, 3rd, 4th, etc.)
  String get toOrdinal {
    if (this >= 11 && this <= 13) {
      return '${this}th';
    }
    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }

  /// Convert to roman numeral
  String get toRomanNumeral {
    if (this <= 0 || this > 3999) return toString();
    final values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    final symbols = [
      'M',
      'CM',
      'D',
      'CD',
      'C',
      'XC',
      'L',
      'XL',
      'X',
      'IX',
      'V',
      'IV',
      'I',
    ];
    var result = '';
    var num = this;
    for (var i = 0; i < values.length; i++) {
      while (num >= values[i]) {
        result += symbols[i];
        num -= values[i];
      }
    }
    return result;
  }
}

// ==================== COLOR EXTENSIONS ====================

extension ColorExtensions on Color {
  /// Convert to hex string
  String toHex({bool includeAlpha = false}) {
    final alphaValue = (a * 255).round().toRadixString(16).padLeft(2, '0');
    final redValue = (r * 255).round().toRadixString(16).padLeft(2, '0');
    final greenValue = (g * 255).round().toRadixString(16).padLeft(2, '0');
    final blueValue = (b * 255).round().toRadixString(16).padLeft(2, '0');
    if (includeAlpha) {
      return '#$alphaValue$redValue$greenValue$blueValue';
    }
    return '#$redValue$greenValue$blueValue';
  }

  /// Lighten color by percentage
  Color lighten(double percentage) {
    final p = percentage.clampRange(0, 1);
    return Color.fromARGB(
      (a * 255).round(),
      ((r + (1 - r) * p) * 255).round(),
      ((g + (1 - g) * p) * 255).round(),
      ((b + (1 - b) * p) * 255).round(),
    );
  }

  /// Darken color by percentage
  Color darken(double percentage) {
    final p = percentage.clampRange(0, 1);
    return Color.fromARGB(
      (a * 255).round(),
      (r * (1 - p) * 255).round(),
      (g * (1 - p) * 255).round(),
      (b * (1 - p) * 255).round(),
    );
  }

  /// Get complementary color
  Color get complementary {
    return Color.fromARGB(
      (a * 255).round(),
      ((1 - r) * 255).round(),
      ((1 - g) * 255).round(),
      ((1 - b) * 255).round(),
    );
  }

  /// Get with opacity
  Color withOpacity(double opacity) {
    return withValues(alpha: opacity);
  }
}

// ==================== DATETIME EXTENSIONS ====================

extension DateTimeExtensions on DateTime {
  /// Check if is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Get start of day
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  /// Get end of day
  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  /// Get start of week (Monday)
  DateTime get startOfWeek {
    final dayOfWeek = weekday - 1;
    return subtract(Duration(days: dayOfWeek)).startOfDay;
  }

  /// Get end of week (Sunday)
  DateTime get endOfWeek {
    final dayOfWeek = 7 - weekday;
    return add(Duration(days: dayOfWeek)).endOfDay;
  }

  /// Get start of month
  DateTime get startOfMonth {
    return DateTime(year, month, 1);
  }

  /// Get end of month
  DateTime get endOfMonth {
    final nextMonth = month == 12
        ? DateTime(year + 1, 1)
        : DateTime(year, month + 1);
    return nextMonth.subtract(const Duration(days: 1)).endOfDay;
  }

  /// Get start of year
  DateTime get startOfYear {
    return DateTime(year, 1, 1);
  }

  /// Get end of year
  DateTime get endOfYear {
    return DateTime(year, 12, 31, 23, 59, 59, 999);
  }

  /// Check if is same day as another date
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Check if is same month as another date
  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  /// Check if is same year as another date
  bool isSameYear(DateTime other) {
    return year == other.year;
  }

  /// Get difference in days
  int get differenceInDays {
    final now = DateTime.now();
    return difference(now).inDays.abs();
  }

  /// Get difference in hours
  int get differenceInHours {
    final now = DateTime.now();
    return difference(now).inHours.abs();
  }

  /// Get difference in minutes
  int get differenceInMinutes {
    final now = DateTime.now();
    return difference(now).inMinutes.abs();
  }

  /// Format as relative time (e.g., "2 hours ago")
  String toRelativeTime() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }
}

// ==================== DURATION EXTENSIONS ====================

extension DurationExtensions on Duration {
  /// Format as human readable string
  String toHumanReadable() {
    final days = inDays;
    final hours = inHours % 24;
    final minutes = inMinutes % 60;
    final seconds = inSeconds % 60;

    final parts = <String>[];
    if (days > 0) {
      parts.add('$days ${days == 1 ? 'day' : 'days'}');
    }
    if (hours > 0) {
      parts.add('$hours ${hours == 1 ? 'hour' : 'hours'}');
    }
    if (minutes > 0) {
      parts.add('$minutes ${minutes == 1 ? 'minute' : 'minutes'}');
    }
    if (seconds > 0) {
      parts.add('$seconds ${seconds == 1 ? 'second' : 'seconds'}');
    }

    if (parts.isEmpty) return '0 seconds';
    return parts.join(', ');
  }

  /// Format as short string (e.g., "1d 2h 30m")
  String toShortString() {
    final days = inDays;
    final hours = inHours % 24;
    final minutes = inMinutes % 60;
    final seconds = inSeconds % 60;

    final parts = <String>[];
    if (days > 0) parts.add('${days}d');
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0) parts.add('${minutes}m');
    if (seconds > 0) parts.add('${seconds}s');

    if (parts.isEmpty) return '0s';
    return parts.join(' ');
  }
}

// ==================== LIST EXTENSIONS ====================

extension ListExtensions<T> on List<T> {
  /// Check if list is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Check if list is not empty
  bool get isNotEmpty => this.isNotEmpty;

  /// Get first element or null
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null
  T? get lastOrNull => isEmpty ? null : last;

  /// Get element at index or null
  T? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Get distinct elements by key
  List<T> distinctBy(dynamic Function(T) key) {
    final seen = <dynamic>{};
    final result = <T>[];
    for (final element in this) {
      final k = key(element);
      if (!seen.contains(k)) {
        seen.add(k);
        result.add(element);
      }
    }
    return result;
  }

  /// Group elements by key
  Map<K, List<T>> groupBy<K>(K Function(T) key) {
    final map = <K, List<T>>{};
    for (final element in this) {
      final k = key(element);
      map.putIfAbsent(k, () => []).add(element);
    }
    return map;
  }

  /// Split list into chunks
  List<List<T>> chunked(int chunkSize) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += chunkSize) {
      chunks.add(sublist(i, (i + chunkSize).clamp(0, length)));
    }
    return chunks;
  }
}

// ==================== BUILD CONTEXT EXTENSIONS ====================

extension BuildContextExtensions on BuildContext {
  /// Get screen size
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Get screen width
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Get screen height
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Get theme
  ThemeData get theme => Theme.of(this);

  /// Get text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Check if is dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Check if is light mode
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;

  /// Get scaffold messenger
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  /// Get navigator
  NavigatorState get navigator => Navigator.of(this);

  /// Get focus scope
  FocusScopeNode get focusScope => FocusScope.of(this);

  /// Show snackbar
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
  }) {
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// Hide keyboard
  void hideKeyboard() {
    focusScope.unfocus();
  }

  /// Get media query padding
  EdgeInsets get mediaQueryPadding => MediaQuery.paddingOf(this);

  /// Get media query view padding
  EdgeInsets get mediaQueryViewPadding => MediaQuery.viewPaddingOf(this);

  /// Get media query view insets
  EdgeInsets get mediaQueryViewInsets => MediaQuery.viewInsetsOf(this);

  /// Get safe area
  SafeArea get safeArea => SafeArea(child: Container());
}

// ==================== WIDGET EXTENSIONS ====================

extension WidgetExtensions on Widget {
  /// Add padding
  Widget paddingAll(double padding) {
    return Padding(padding: EdgeInsets.all(padding), child: this);
  }

  /// Add symmetric padding
  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  /// Add only padding
  Widget paddingOnly({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: this,
    );
  }

  /// Add margin
  Widget marginAll(double margin) {
    return Container(margin: EdgeInsets.all(margin), child: this);
  }

  /// Add symmetric margin
  Widget marginSymmetric({double horizontal = 0, double vertical = 0}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  /// Add only margin
  Widget marginOnly({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: this,
    );
  }

  /// Add rounded corners
  Widget borderRadius(double radius) {
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);
  }

  /// Add decoration
  Widget decorated({
    Color? color,
    DecorationImage? image,
    BoxBorder? border,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        image: image,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        gradient: gradient,
      ),
      child: this,
    );
  }

  /// Add opacity
  Widget opacity(double opacity) {
    return Opacity(opacity: opacity, child: this);
  }

  /// Add rotation
  Widget rotate(double angle) {
    return Transform.rotate(angle: angle, child: this);
  }

  /// Add scale
  Widget scale(double scale) {
    return Transform.scale(scale: scale, child: this);
  }

  /// Add translate
  Widget translate({double dx = 0, double dy = 0}) {
    return Transform.translate(offset: Offset(dx, dy), child: this);
  }

  /// Add alignment
  Widget align(Alignment alignment) {
    return Align(alignment: alignment, child: this);
  }

  /// Add center
  Widget center() {
    return Center(child: this);
  }

  /// Add expanded
  Widget expanded({int flex = 1}) {
    return Expanded(flex: flex, child: this);
  }

  /// Add flexible
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) {
    return Flexible(flex: flex, fit: fit, child: this);
  }

  /// Add safe area
  Widget safeArea({
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) {
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: this,
    );
  }

  /// Add hero
  Widget hero(Object tag) {
    return Hero(tag: tag, child: this);
  }

  /// Add gesture detector
  Widget onTap(VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: this);
  }

  /// Add on double tap
  Widget onDoubleTap(VoidCallback onDoubleTap) {
    return GestureDetector(onDoubleTap: onDoubleTap, child: this);
  }

  /// Add on long press
  Widget onLongPress(VoidCallback onLongPress) {
    return GestureDetector(onLongPress: onLongPress, child: this);
  }

  /// Add visibility
  Widget visible(bool visible) {
    return Visibility(visible: visible, child: this);
  }

  /// Add constrained
  Widget constrained({
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? 0,
        maxWidth: maxWidth ?? double.infinity,
        minHeight: minHeight ?? 0,
        maxHeight: maxHeight ?? double.infinity,
      ),
      child: this,
    );
  }

  /// Add sized box
  Widget sizedBox({double? width, double? height}) {
    return SizedBox(width: width, height: height, child: this);
  }

  /// Add aspect ratio
  Widget aspectRatio(double aspectRatio) {
    return AspectRatio(aspectRatio: aspectRatio, child: this);
  }

  /// Add card
  Widget card({Color? color, EdgeInsetsGeometry? margin, Clip? clipBehavior}) {
    return Card(
      color: color,
      margin: margin,
      clipBehavior: clipBehavior,
      child: this,
    );
  }
}
