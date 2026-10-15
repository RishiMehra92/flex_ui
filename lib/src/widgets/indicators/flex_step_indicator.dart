import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// A multi-step flow progress indicator.
class FlexStepIndicator extends StatelessWidget {
  const FlexStepIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.activeColor,
    this.inactiveColor,
    this.completedColor,
    this.stepSize = 28.0,
    this.lineWidth = 2.0,
  });

  final int totalSteps;
  final int currentStep;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? completedColor;
  final double stepSize;
  final double lineWidth;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final active = activeColor ?? colors.primary;
    final inactive = inactiveColor ?? colors.surfaceVariant;
    final completed = completedColor ?? colors.success;

    return Row(
      children: List.generate(totalSteps * 2 - 1, (index) {
        if (index.isOdd) {
          final stepIndex = index ~/ 2;
          final isLineCompleted = stepIndex < currentStep;
          return Expanded(
            child: Container(
              height: lineWidth,
              color: isLineCompleted ? completed : inactive,
            ),
          );
        }

        final stepIndex = index ~/ 2;
        final isCompleted = stepIndex < currentStep;
        final isActive = stepIndex == currentStep;

        Color circleColor;
        Widget content;

        if (isCompleted) {
          circleColor = completed;
          content = const Icon(Icons.check, size: 16, color: Colors.white);
        } else if (isActive) {
          circleColor = active;
          content = Text(
            '${stepIndex + 1}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          );
        } else {
          circleColor = inactive;
          content = Text(
            '${stepIndex + 1}',
            style: TextStyle(
              color: colors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          );
        }

        return Container(
          width: stepSize,
          height: stepSize,
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
          ),
          child: Center(child: content),
        );
      }),
    );
  }
}
