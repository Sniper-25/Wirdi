import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum WirdiBadgeType { primary, secondary, subtle, warning, success }

/// Minimal rounded badge pill for statuses, tags, and counts.
class WirdiBadge extends StatelessWidget {
  const WirdiBadge({
    super.key,
    required this.label,
    this.type = WirdiBadgeType.secondary,
    this.icon,
  });

  final String label;
  final WirdiBadgeType type;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color bg;
    Color fg;

    switch (type) {
      case WirdiBadgeType.primary:
        bg = isDark ? AppColors.emeraldDark : AppColors.emeraldPrimary;
        fg = Colors.white;
        break;
      case WirdiBadgeType.secondary:
        bg = isDark ? AppColors.softGreenDarkContainer : AppColors.softGreenContainer;
        fg = isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary;
        break;
      case WirdiBadgeType.subtle:
        bg = isDark ? AppColors.darkSurface : AppColors.lightSurface;
        fg = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
        break;
      case WirdiBadgeType.warning:
        bg = isDark ? const Color(0xFF332511) : AppColors.warningContainer;
        fg = isDark ? const Color(0xFFFBBF24) : AppColors.warning;
        break;
      case WirdiBadgeType.success:
        bg = isDark ? const Color(0xFF14301B) : AppColors.successContainer;
        fg = isDark ? const Color(0xFF81C784) : AppColors.success;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: fg,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
