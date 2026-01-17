import 'package:flutter/material.dart';

import '../utils/constants.dart';

/// Rating Widget
/// Displays star rating with score
class RatingWidget extends StatelessWidget {
  final double rating;
  final bool showScore;
  final double iconSize;
  final Color? activeColor;
  final Color? inactiveColor;

  const RatingWidget({
    super.key,
    required this.rating,
    this.showScore = true,
    this.iconSize = 16,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: activeColor ?? AppColors.warning,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            size: iconSize,
            color: Colors.white,
          ),
          if (showScore) ...[
            const SizedBox(width: 4),
            Text(
              rating.toStringAsFixed(1),
              style: AppTextStyles.labelSmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Interactive Rating Input Widget
/// Allows users to select a rating
class RatingInputWidget extends StatefulWidget {
  final double initialRating;
  final ValueChanged<double> onRatingChanged;
  final double iconSize;
  final Color? activeColor;
  final Color? inactiveColor;

  const RatingInputWidget({
    super.key,
    this.initialRating = 0,
    required this.onRatingChanged,
    this.iconSize = 32,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  State<RatingInputWidget> createState() => _RatingInputWidgetState();
}

class _RatingInputWidgetState extends State<RatingInputWidget> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentRating = index + 1.0;
            });
            widget.onRatingChanged(_currentRating);
          },
          child: Icon(
            index < _currentRating.floor()
                ? Icons.star_rounded
                : Icons.star_outline_rounded,
            size: widget.iconSize,
            color: index < _currentRating.floor()
                ? (widget.activeColor ?? AppColors.warning)
                : (widget.inactiveColor ?? AppColors.textLight),
          ),
        );
      }),
    );
  }
}
