import 'package:flutter/material.dart';

/// Useful extensions to make development easier and code cleaner

// ============================================================================
// CONTEXT EXTENSIONS
// ============================================================================

extension BuildContextExtensions on BuildContext {
  /// Get the current theme
  ThemeData get theme => Theme.of(this);

  /// Get the current text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get the current color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Get media query data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get screen size
  Size get screenSize => mediaQuery.size;

  /// Get screen width
  double get screenWidth => screenSize.width;

  /// Get screen height
  double get screenHeight => screenSize.height;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => mediaQuery.viewInsets.bottom > 0;

  /// Get safe area padding
  EdgeInsets get safeAreaPadding => mediaQuery.padding;

  /// Show a snackbar
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// Show an error snackbar
  void showErrorSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: theme.colorScheme.error,
    );
  }

  /// Show a success snackbar
  void showSuccessSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.green,
    );
  }

  /// Hide keyboard
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}

// ============================================================================
// STRING EXTENSIONS
// ============================================================================

extension StringExtensions on String {
  /// Capitalize first letter
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize first letter of each word
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Check if string is a valid email
  bool get isValidEmail {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this);
  }

  /// Check if string is a valid phone number (basic check)
  bool get isValidPhone {
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]+$');
    return phoneRegex.hasMatch(this) && length >= 10;
  }

  /// Check if string is empty or only contains whitespace
  bool get isBlank {
    return trim().isEmpty;
  }

  /// Check if string is not empty and not only whitespace
  bool get isNotBlank {
    return !isBlank;
  }

  /// Truncate string to specified length and add ellipsis
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }
}

// ============================================================================
// NUMBER EXTENSIONS
// ============================================================================

extension IntExtensions on int {
  /// Convert to currency format (e.g., 1000 -> "$1,000")
  String toCurrency({String symbol = '\$'}) {
    return '$symbol${toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}';
  }

  /// Convert to compact format (e.g., 1000 -> "1K")
  String toCompact() {
    if (this < 1000) return toString();
    if (this < 1000000) return '${(this / 1000).toStringAsFixed(1)}K';
    if (this < 1000000000) return '${(this / 1000000).toStringAsFixed(1)}M';
    return '${(this / 1000000000).toStringAsFixed(1)}B';
  }
}

extension DoubleExtensions on double {
  /// Convert to currency format (e.g., 1000.50 -> "$1,000.50")
  String toCurrency({String symbol = '\$', int decimalPlaces = 2}) {
    return '$symbol${toStringAsFixed(decimalPlaces).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}';
  }

  /// Round to specified decimal places
  double roundToDecimal(int places) {
    final mod = 10.0 * places;
    return (this * mod).round() / mod;
  }
}

// ============================================================================
// DATETIME EXTENSIONS
// ============================================================================

extension DateTimeExtensions on DateTime {
  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Format as "MMM dd, yyyy" (e.g., "Jan 15, 2024")
  String get formatted {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[month - 1]} $day, $year';
  }

  /// Format as "hh:mm AM/PM" (e.g., "02:30 PM")
  String get timeFormatted {
    final h = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final m = minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $period';
  }

  /// Get relative time string (e.g., "2 hours ago")
  String get relativeTime {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}w ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}mo ago';
    } else {
      return '${(difference.inDays / 365).floor()}y ago';
    }
  }
}

// ============================================================================
// LIST EXTENSIONS
// ============================================================================

extension ListExtensions<T> on List<T> {
  /// Get element at index or null if out of bounds
  T? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Check if list is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Check if list is not null and not empty
  bool get isNotNullOrEmpty => isNotEmpty;
}

// ============================================================================
// WIDGET EXTENSIONS
// ============================================================================

extension WidgetExtensions on Widget {
  /// Add padding to widget
  Widget paddingAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  /// Add symmetric padding to widget
  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: this,
    );
  }

  /// Add only padding to widget
  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  /// Center widget
  Widget get center => Center(child: this);

  /// Align widget
  Widget align(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  /// Expand widget
  Widget get expand => Expanded(child: this);

  /// Make widget flexible
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) {
    return Flexible(
      flex: flex,
      fit: fit,
      child: this,
    );
  }

  /// Add tap gesture to widget
  Widget onTap(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }

  /// Add InkWell effect to widget
  Widget inkWell(VoidCallback onTap, {BorderRadius? borderRadius}) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: this,
    );
  }

  /// Add hero animation
  Widget hero(String tag) {
    return Hero(
      tag: tag,
      child: this,
    );
  }

  /// Make widget visible or invisible
  Widget visible(bool visible, {Widget? replacement}) {
    return visible ? this : (replacement ?? const SizedBox.shrink());
  }
}
