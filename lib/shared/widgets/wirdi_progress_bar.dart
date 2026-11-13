import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Clean linear progress bar adhering to Calm Green visual design.
class WirdiLinearProgress extends StatelessWidget {
  const WirdiLinearProgress({
    super.key,
    required this.progress, // 0.0 to 1.0
    this.height = 8.0,
    this.accentColor,
    this.backgroundColor,
  });

  final double progress;
  final double height;
  final Color? accentColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final clamped = progress.clamp(0.0, 1.0);

    final trackBg = backgroundColor ??
        (isDark ? AppColors.darkBorder : AppColors.softGreenContainer);
    final indicatorColor = accentColor ??
        (isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: trackBg,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: FractionallySizedBox(
        alignment: AlignmentDirectional.centerStart,
        widthFactor: clamped,
        child: Container(
          decoration: BoxDecoration(
            color: indicatorColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
        ),
      ),
    );
  }
}

/// Minimal circular progress indicator with center content.
class WirdiCircularProgress extends StatelessWidget {
  const WirdiCircularProgress({
    super.key,
    required this.progress,
    this.size = 64.0,
    this.strokeWidth = 6.0,
    this.centerText,
    this.subText,
  });

  final double progress;
  final double size;
  final double strokeWidth;
  final String? centerText;
  final String? subText;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final clamped = progress.clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: clamped,
            strokeWidth: strokeWidth,
            strokeCap: StrokeCap.round,
            backgroundColor: isDark ? AppColors.darkBorder : AppColors.softGreenContainer,
            valueColor: AlwaysStoppedAnimation<Color>(
              isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary,
            ),
          ),
          if (centerText != null)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  centerText!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                if (subText != null)
                  Text(
                    subText!,
                    style: TextStyle(
                      fontSize: 10,
                      color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
