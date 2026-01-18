import 'package:flutter/material.dart';
import 'dart:math';

extension ResponsiveSize on num {
  /// Calculates the responsive width based on a design standard (e.g., 375px width)
  double get w {
    final context = _context;
    if (context == null) return this.toDouble();
    double screenWidth = MediaQuery.of(context).size.width;
    // 375 is a standard mobile design width
    return (this * screenWidth) / 375;
  }

  /// Calculates the responsive height based on a design standard (e.g., 812px height)
  double get h {
    final context = _context;
    if (context == null) return this.toDouble();
    double screenHeight = MediaQuery.of(context).size.height;
    // 812 is a standard mobile design height
    return (this * screenHeight) / 812;
  }

  /// Scales font size while respecting the user's system text zoom settings
  double get sp {
    final context = _context;
    if (context == null) return this.toDouble();
    // Use min to prevent text from exploding too large on high zoom
    return this * min(MediaQuery.textScalerOf(context).scale(1), 1.2);
  }

  // Helper to get context for calculations
  static BuildContext? _context;
  static void init(BuildContext context) => _context = context;
}
