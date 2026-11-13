import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../shared/widgets/wirdi_app_bar.dart';
import '../../../../shared/widgets/wirdi_badge.dart';
import '../../../../shared/widgets/wirdi_card.dart';
import '../controllers/locale_controller.dart';

/// Settings Screen for managing appearance, language, reading preferences, and offline data.
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _keepScreenOn = true;
  bool _enableDailyReminder = true;
  final String _reminderTime = '٠٦:٠٠ ص';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentThemeMode = ref.watch(themeControllerProvider);
    final currentLocale = ref.watch(localeControllerProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: const WirdiAppBar(
        title: 'الإعدادات',
        subtitle: 'تخصيص المظهر وتجربة القراءة',
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // 1. Appearance Section
            _SectionTitle(title: 'المظهر والعرض'),
            WirdiCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                            color: AppColors.emeraldPrimary,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'وضع المظهر',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                      DropdownButton<ThemeMode>(
                        value: currentThemeMode,
                        underline: const SizedBox.shrink(),
                        borderRadius: BorderRadius.circular(12),
                        dropdownColor: isDark ? AppColors.darkCard : Colors.white,
                        items: const [
                          DropdownMenuItem(
                            value: ThemeMode.light,
                            child: Text('فاتح (عاجي)'),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.dark,
                            child: Text('داكن (ليلي)'),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.system,
                            child: Text('تلقائي النظام'),
                          ),
                        ],
                        onChanged: (mode) {
                          if (mode != null) {
                            ref.read(themeControllerProvider.notifier).setThemeMode(mode);
                          }
                        },
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.language_rounded, color: AppColors.emeraldPrimary, size: 20),
                          SizedBox(width: 12),
                          Text(
                            'لغة التطبيق',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(localeControllerProvider.notifier).toggleLocale();
                        },
                        child: Text(
                          currentLocale.languageCode == 'ar' ? 'العربية (RTL)' : 'English',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 2. Reading Preferences Section
            _SectionTitle(title: 'خيارات القراءة والورد'),
            WirdiCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'إبقاء الشاشة مضاءة أثناء القراءة',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: Text(
                      'منع قفل الشاشة أثناء تصفح صفحات المصحف الشريف',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                    value: _keepScreenOn,
                    activeThumbColor: AppColors.emeraldPrimary,
                    onChanged: (val) => setState(() => _keepScreenOn = val),
                  ),
                  const Divider(height: 20),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'تنبيه الورد اليومي',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: Text(
                      'تذكير في الموعد المحدد: $_reminderTime',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                    value: _enableDailyReminder,
                    activeThumbColor: AppColors.emeraldPrimary,
                    onChanged: (val) => setState(() => _enableDailyReminder = val),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 3. Data & Storage
            _SectionTitle(title: 'البيانات والأمان'),
            WirdiCard(
              onTap: () => context.push(AppRoutes.backup),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.softGreenDarkContainer : AppColors.softGreenContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.backup_rounded, color: AppColors.emeraldPrimary, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'النسخ الاحتياطي والاستعادة',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          'إدارة البيانات محلياً بلا اتصال بالإنترنت',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: Colors.grey),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 4. About App
            _SectionTitle(title: 'عن التطبيق'),
            WirdiCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'وِردي | Wirdi',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      WirdiBadge(
                        label: 'الإصدار ${AppConstants.appVersion}',
                        type: WirdiBadgeType.secondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'تطبيق رفيق القرآن الكريم للحفاظ وطلاب الحلقات القرآنية. يرتكز على مبدأ الاستقلالية التامة وعدم الاتصال بالإنترنت لحفظ الخصوصية والتركيز التام على كتاب الله.',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.6,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

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
