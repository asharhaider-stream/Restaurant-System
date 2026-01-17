import 'package:flutter/material.dart';
import 'package:restaurant_management_system/src/utils/extensions.dart';

import '../utils/constants.dart';

/// Price Tag Widget
/// Displays formatted price with currency symbol
class PriceTag extends StatelessWidget {
  final double price;
  final double? originalPrice; // For showing discounts
  final bool showCurrency;
  final TextStyle? textStyle;
  final Color? color;

  const PriceTag({
    super.key,
    required this.price,
    this.originalPrice,
    this.showCurrency = true,
    this.textStyle,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount = originalPrice != null && originalPrice! > price;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        // Current Price
        Text(
          price.toCurrency(symbol: showCurrency ? '\$' : ''),
          style: textStyle ??
              AppTextStyles.h4.copyWith(
                color: color ?? AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
        ),

        // Original Price (crossed out)
        if (hasDiscount) ...[
          const SizedBox(width: AppSpacing.sm),
          Text(
            originalPrice!.toCurrency(symbol: showCurrency ? '\$' : ''),
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textLight,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
    );
  }
}

/// Large Price Display (for checkout, order summary)
class LargePriceTag extends StatelessWidget {
  final double price;
  final String label;
  final bool isBold;

  const LargePriceTag({
    super.key,
    required this.price,
    this.label = 'Total',
    this.isBold = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.h4.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          price.toCurrency(symbol: '\$'),
          style: AppTextStyles.h3.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
