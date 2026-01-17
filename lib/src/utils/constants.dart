import 'package:flutter/material.dart';

import 'responsive_helper.dart';

/// App-wide constants
/// This file contains all constant values used throughout the app
/// including colors, strings, spacing, and configuration values

// ============================================================================
// COLORS
// ============================================================================

class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary Brand & Action Color
  static const Color primary = Color(0xFFFF6B35);

  // Secondary & Interactive Elements
  static const Color secondary = Color(0xFFFFB370);

  // Soft Accents & Background Highlights
  static const Color accent = Color(0xFFFFD8A6);

  // Neutral Background & Surface Color
  static const Color background = Color(0xFFFDF6F0);

  // Success & Feedback Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF42A5F5);

  // Text Colors
  static const Color textPrimary = Color(0xFF2D2D2D);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Colors.white;

  // Surface & Border Colors
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);

  // Shadow & Overlay
  static const Color shadow = Color(0x1A000000);
  static const Color overlay = Color(0x80000000);
}

// ============================================================================
// SPACING & SIZING
// ============================================================================

class AppSpacing {
  AppSpacing._();

  // Padding & Margin
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // Border Radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusRound = 999.0;

  // Icon Sizes
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;
}

// ============================================================================
// TYPOGRAPHY
// ============================================================================

class AppTextStyles {
  AppTextStyles._();

  // Headings
  static TextStyle get h1 => TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
      height: 1.2);
  static TextStyle get h2 => TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
      height: 1.3);
  static TextStyle get h3 => TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      height: 1.3);
  static TextStyle get h4 => TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      height: 1.4);

  // Body Text
  static TextStyle get bodyLarge => TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
      height: 1.5);
  static TextStyle get bodyMedium => TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
      height: 1.5);
  static TextStyle get bodySmall => TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.textSecondary,
      height: 1.5);

  // Labels & Buttons
  static TextStyle get labelLarge => TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      height: 1.2);
  static TextStyle get labelMedium => TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      height: 1.2);
  static TextStyle get labelSmall => TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.textSecondary,
      height: 1.2);
  static TextStyle get button => TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.textOnPrimary,
      height: 1.2);
}

// ============================================================================
// APP STRINGS
// ============================================================================

class AppStrings {
  AppStrings._();

  // App Info
  static const String appName = 'Restaurant Management';
  static const String appVersion = '1.0.0';

  // Common
  static const String loading = 'Loading...';
  static const String error = 'Something went wrong';
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String search = 'Search';
  static const String filter = 'Filter';
  static const String sort = 'Sort';

  // Navigation
  static const String home = 'Home';
  static const String menu = 'Menu';
  static const String cart = 'Cart';
  static const String orders = 'Orders';
  static const String profile = 'Profile';

  // Auth
  static const String login = 'Login';
  static const String logout = 'Logout';
  static const String register = 'Register';
  static const String forgotPassword = 'Forgot Password?';
  static const String email = 'Email';
  static const String password = 'Password';

  // Restaurant Browse
  static const String restaurants = 'Restaurants';
  static const String searchRestaurants = 'Search restaurants, cuisines...';
  static const String popularNearYou = 'Popular Near You';
  static const String viewMenu = 'View Menu';
  static const String freeDelivery = 'Free delivery';

  // Menu
  static const String categories = 'Categories';
  static const String addToCart = 'Add to Cart';
  static const String customizeYourOrder = 'Customize your order';

  // Cart
  static const String yourCart = 'Your Cart';
  static const String subtotal = 'Subtotal';
  static const String deliveryFee = 'Delivery Fee';
  static const String total = 'Total';
  static const String checkout = 'Checkout';
  static const String emptyCart = 'Your cart is empty';

  // Orders
  static const String myOrders = 'My Orders';
  static const String orderHistory = 'Order History';
  static const String trackOrder = 'Track Order';
  static const String orderPlaced = 'Order Placed';
  static const String preparing = 'Preparing';
  static const String ready = 'Ready';
  static const String delivered = 'Delivered';
}

// ============================================================================
// APP CONFIGURATION
// ============================================================================

class AppConfig {
  AppConfig._();

  // API Configuration (mock for now)
  static const String apiBaseUrl = 'https://api.example.com';
  static const int apiTimeout = 30000; // milliseconds

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache Duration
  static const Duration shortCacheDuration = Duration(minutes: 5);
  static const Duration mediumCacheDuration = Duration(minutes: 30);
  static const Duration longCacheDuration = Duration(hours: 24);

  // Animation Duration
  static const Duration shortAnimation = Duration(milliseconds: 150);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Debounce Duration (for search, etc.)
  static const Duration debounceDuration = Duration(milliseconds: 500);
}

// ============================================================================
// ASSET PATHS
// ============================================================================

class AppAssets {
  AppAssets._();

  // Icons (example paths - adjust based on your actual assets)
  static const String iconPath = 'assets/icons';

  // Images
  static const String imagePath = 'assets/images';
  static const String logoPath = '$imagePath/logo.png';
  static const String placeholderImage = '$imagePath/placeholder.png';

  // Animations (if using Lottie or similar)
  static const String animationPath = 'assets/animations';
  static const String loadingAnimation = '$animationPath/loading.json';
}

// ============================================================================
// ENUMS
// ============================================================================

/// Order status enum
enum OrderStatus {
  pending,
  preparing,
  ready,
  delivered,
  cancelled,
}

/// Order type enum
enum OrderType {
  dineIn,
  takeaway,
  delivery,
}

/// Payment method enum
enum PaymentMethod {
  cash,
  card,
  digitalWallet,
}

// Extension methods for enums
extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.ready:
        return 'Ready';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.pending:
        return AppColors.warning;
      case OrderStatus.preparing:
        return AppColors.info;
      case OrderStatus.ready:
        return AppColors.success;
      case OrderStatus.delivered:
        return AppColors.success;
      case OrderStatus.cancelled:
        return AppColors.error;
    }
  }
}

extension OrderTypeExtension on OrderType {
  String get displayName {
    switch (this) {
      case OrderType.dineIn:
        return 'Dine In';
      case OrderType.takeaway:
        return 'Takeaway';
      case OrderType.delivery:
        return 'Delivery';
    }
  }
}
