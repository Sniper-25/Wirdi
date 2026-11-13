import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/wirdi_badge.dart';
import '../../../../shared/widgets/wirdi_card.dart';
import '../../../../shared/widgets/wirdi_progress_bar.dart';
import '../../../../shared/widgets/wirdi_section_header.dart';
import '../../../settings/presentation/controllers/locale_controller.dart';

/// Home Dashboard for Wirdi (وِردي) – Calm Green Visual Identity.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentLocale = ref.watch(localeControllerProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isDark ? AppColors.softGreenDarkContainer : AppColors.softGreenContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                size: 18,
                color: AppColors.emeraldPrimary,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              l10n.appName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: isDark ? AppColors.darkTextPrimary : AppColors.emeraldPrimary,
              ),
            ),
          ],
        ),
        actions: [
          // Theme Toggle
          IconButton(
            tooltip: l10n.toggleTheme,
            icon: Icon(
              isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              size: 22,
              color: isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary,
            ),
            onPressed: () => ref.read(themeControllerProvider.notifier).toggleTheme(),
          ),
          // Language Toggle
          TextButton(
            onPressed: () => ref.read(localeControllerProvider.notifier).toggleLocale(),
            child: Text(
              currentLocale.languageCode == 'ar' ? 'English' : 'عربي',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // 1. Subtle Welcome Greeting
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'السلام عليكم ورحمة الله وبركاته',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'أهلاً بك يا قارئ القرآن',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // 2. Today's Reading Goal & Progress Card
            WirdiCard(
              backgroundColor: isDark ? AppColors.darkCard : Colors.white,
              borderColor: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.softGreenDarkContainer : AppColors.softGreenContainer,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.calendar_today_rounded,
                              size: 18,
                              color: AppColors.emeraldPrimary,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ورد اليوم',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                                ),
                              ),
                              Text(
                                'سورة البقرة • ص ٢ - ص ٦',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const WirdiBadge(
                        label: '٢ من ٤ صفحات',
                        type: WirdiBadgeType.secondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const WirdiLinearProgress(
                    progress: 0.5,
                    height: 8,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => context.go(AppRoutes.mushaf),
                      icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                      label: const Text('متابعة الورد القرآني'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.emeraldPrimary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 3. Quick Access Hub
            const WirdiSectionHeader(
              title: 'الوصول السريع',
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _QuickAccessCard(
                    icon: Icons.menu_book_rounded,
                    title: 'المصحف',
                    subtitle: 'تلاوة وتصفح',
                    onTap: () => context.go(AppRoutes.mushaf),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickAccessCard(
                    icon: Icons.bookmark_added_rounded,
                    title: 'الحفظ',
                    subtitle: 'متابعة الحفظ',
                    onTap: () => context.push(AppRoutes.memorization),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _QuickAccessCard(
                    icon: Icons.repeat_rounded,
                    title: 'المراجعة',
                    subtitle: 'تثبيت المحفوظ',
                    onTap: () => context.push(AppRoutes.revision),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickAccessCard(
                    icon: Icons.spa_rounded,
                    title: 'الأذكار',
                    subtitle: 'الصباح والمساء',
                    onTap: () => context.push(AppRoutes.adhkar),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 4. Minimal Weekly Progress
            WirdiSectionHeader(
              title: 'الالتزام الأسبوعي',
              actionLabel: 'التفاصيل',
              onAction: () => context.go(AppRoutes.statistics),
            ),
            const SizedBox(height: 8),
            WirdiCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '٥ أيام متتالية من القراءة',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                        ),
                      ),
                      const WirdiBadge(
                        label: 'مستمر',
                        type: WirdiBadgeType.success,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _DayIndicator(dayLabel: 'سبت', isDone: true),
                      _DayIndicator(dayLabel: 'أحد', isDone: true),
                      _DayIndicator(dayLabel: 'إثنين', isDone: true),
                      _DayIndicator(dayLabel: 'ثلاثاء', isDone: true),
                      _DayIndicator(dayLabel: 'أربعاء', isDone: true),
                      _DayIndicator(dayLabel: 'خميس', isDone: false, isToday: true),
                      _DayIndicator(dayLabel: 'جمعة', isDone: false),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  const _QuickAccessCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return WirdiCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDark ? AppColors.softGreenDarkContainer : AppColors.softGreenContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 22, color: AppColors.emeraldPrimary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DayIndicator extends StatelessWidget {
  const _DayIndicator({
    required this.dayLabel,
    required this.isDone,
    this.isToday = false,
  });

  final String dayLabel;
  final bool isDone;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color circleBg;
    Widget iconWidget;

    if (isDone) {
      circleBg = AppColors.emeraldPrimary;
      iconWidget = const Icon(Icons.check_rounded, size: 14, color: Colors.white);
    } else if (isToday) {
      circleBg = isDark ? AppColors.softGreenDarkContainer : AppColors.softGreenContainer;
      iconWidget = Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: AppColors.emeraldPrimary,
          shape: BoxShape.circle,
        ),
      );
    } else {
      circleBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;
      iconWidget = const SizedBox.shrink();
    }

    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: circleBg,
            shape: BoxShape.circle,
            border: isToday
                ? Border.all(color: AppColors.emeraldPrimary, width: 1.5)
                : null,
          ),
          child: Center(child: iconWidget),
        ),
        const SizedBox(height: 6),
        Text(
          dayLabel,
          style: TextStyle(
            fontSize: 11,
            color: isToday
                ? AppColors.emeraldPrimary
                : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
