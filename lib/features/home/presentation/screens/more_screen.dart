import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/wirdi_card.dart';

/// More Hub Screen providing quick links to companion tools, backup, and settings.
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'المزيد',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // Companion Features Group
            _GroupHeader(title: 'أدوات الحفاظ'),
            WirdiCard(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                children: [
                  _NavTile(
                    icon: Icons.bookmark_added_rounded,
                    title: 'الحفظ الجديد',
                    subtitle: 'إدارة وتتبع السور والمقاطع المحفوظة',
                    onTap: () => context.push(AppRoutes.memorization),
                  ),
                  const Divider(height: 1),
                  _NavTile(
                    icon: Icons.repeat_rounded,
                    title: 'المراجعة والتثبيت',
                    subtitle: 'جدول المراجعة الصغرى والكبرى',
                    onTap: () => context.push(AppRoutes.revision),
                  ),
                  const Divider(height: 1),
                  _NavTile(
                    icon: Icons.spa_rounded,
                    title: 'الأذكار المأثورة',
                    subtitle: 'أذكار الصباح والمساء بعداد تكرار تفاعلي',
                    onTap: () => context.push(AppRoutes.adhkar),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // System & Data Group
            _GroupHeader(title: 'البيانات والتطبيق'),
            WirdiCard(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                children: [
                  _NavTile(
                    icon: Icons.settings_rounded,
                    title: 'الإعدادات',
                    subtitle: 'المظهر، التنبيهات، واللغة',
                    onTap: () => context.push(AppRoutes.settings),
                  ),
                  const Divider(height: 1),
                  _NavTile(
                    icon: Icons.backup_rounded,
                    title: 'النسخ الاحتياطي والاستعادة',
                    subtitle: 'حفظ واسترجاع بياناتك محلياً بلا اتصال',
                    onTap: () => context.push(AppRoutes.backup),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // App Identity Footer
            Center(
              child: Column(
                children: [
                  Text(
                    'وِردي • Wirdi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'رفيق الحفاظ وطلاب الحلقات • الإصدار ١.٠.٠',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                    ),
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

class _GroupHeader extends StatelessWidget {
  const _GroupHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
        ),
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
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

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? AppColors.softGreenDarkContainer : AppColors.softGreenContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.emeraldPrimary, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
        ),
      ),
      trailing: const Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: Colors.grey),
      onTap: onTap,
    );
  }
}
