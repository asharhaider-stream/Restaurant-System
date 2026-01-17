import 'package:flutter/material.dart';

import '../utils/constants.dart';

/// Badge Widget
/// Used for displaying tags like "HOT", "NEW", "LIMITED OFFER"
class BadgeWidget extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final BadgeType type;

  const BadgeWidget({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.type = BadgeType.custom,
  });

  /// Factory for HOT badge
  factory BadgeWidget.hot() {
    return const BadgeWidget(
      text: 'HOT',
      type: BadgeType.hot,
    );
  }

  /// Factory for NEW badge
  factory BadgeWidget.newItem() {
    return const BadgeWidget(
      text: 'NEW',
      type: BadgeType.newItem,
    );
  }

  /// Factory for LIMITED OFFER badge
  factory BadgeWidget.limitedOffer() {
    return const BadgeWidget(
      text: 'LIMITED OFFER',
      type: BadgeType.offer,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getBadgeColors();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        boxShadow: [
          BoxShadow(
            color: colors.backgroundColor.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: AppTextStyles.labelSmall.copyWith(
          color: colors.textColor,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  _BadgeColors _getBadgeColors() {
    switch (type) {
      case BadgeType.hot:
        return _BadgeColors(
          backgroundColor: backgroundColor ?? AppColors.error,
          textColor: textColor ?? Colors.white,
        );
      case BadgeType.newItem:
        return _BadgeColors(
          backgroundColor: backgroundColor ?? AppColors.success,
          textColor: textColor ?? Colors.white,
        );
      case BadgeType.offer:
        return _BadgeColors(
          backgroundColor: backgroundColor ?? AppColors.primary,
          textColor: textColor ?? Colors.white,
        );
      case BadgeType.custom:
        return _BadgeColors(
          backgroundColor: backgroundColor ?? AppColors.textPrimary,
          textColor: textColor ?? Colors.white,
        );
    }
  }
}

enum BadgeType {
  hot,
  newItem,
  offer,
  custom,
}

class _BadgeColors {
  final Color backgroundColor;
  final Color textColor;

  _BadgeColors({
    required this.backgroundColor,
    required this.textColor,
  });
}
