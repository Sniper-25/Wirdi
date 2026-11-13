import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/wirdi_badge.dart';
import '../../../../shared/widgets/wirdi_card.dart';
import '../../../../shared/widgets/wirdi_section_header.dart';

/// Minimal Statistics Dashboard with weekly and monthly progress overviews.
class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _selectedPeriod = 0; // 0: أسبوعي, 1: شهري

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'الإحصائيات والتقدم',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // Period Toggle (Weekly / Monthly)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _PeriodTab(
                      label: 'العرض الأسبوعي',
                      isSelected: _selectedPeriod == 0,
                      onTap: () => setState(() => _selectedPeriod = 0),
                    ),
                  ),
                  Expanded(
                    child: _PeriodTab(
                      label: 'العرض الشهري',
                      isSelected: _selectedPeriod == 1,
                      onTap: () => setState(() => _selectedPeriod = 1),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Demo Data Disclaimer
            Center(
              child: WirdiBadge(
                label: 'بيانات تجريبية إيضاحية',
                type: WirdiBadgeType.subtle,
              ),
            ),
            const SizedBox(height: 14),

            // 2x2 Metric Grid
            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    title: 'الصفحات المقروءة',
                    value: _selectedPeriod == 0 ? '٢٨' : '١١٢',
                    unit: 'صفحة',
                    icon: Icons.auto_stories_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetricCard(
                    title: 'الأوراد المكتملة',
                    value: _selectedPeriod == 0 ? '٦' : '٢٤',
                    unit: 'أوراد',
                    icon: Icons.task_alt_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    title: 'الأجزاء المحفوظة',
                    value: '٣',
                    unit: 'أجزاء موثقة',
                    icon: Icons.bookmark_added_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetricCard(
                    title: 'جلسات المراجعة',
                    value: _selectedPeriod == 0 ? '٩' : '٣٥',
                    unit: 'جلسة تسميع',
                    icon: Icons.repeat_rounded,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Weekly Pages Read Bar Visualization
            WirdiSectionHeader(
              title: _selectedPeriod == 0 ? 'معدل القراءة اليومي' : 'معدل القراءة الأسبوعي',
            ),
            const SizedBox(height: 8),

            WirdiCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedPeriod == 0 ? 'آخر ٧ أيام' : 'أسابيع الشهر الحالي',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                      Text(
                        _selectedPeriod == 0 ? 'متوسط ٤ صفحات / يوم' : 'متوسط ٢٨ صفحة / أسبوع',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Minimalist Bar Graph
                  SizedBox(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: _selectedPeriod == 0
                          ? const [
                              _BarItem(day: 'سبت', value: 4, maxValue: 6),
                              _BarItem(day: 'أحد', value: 4, maxValue: 6),
                              _BarItem(day: 'إثنين', value: 5, maxValue: 6),
                              _BarItem(day: 'ثلاثاء', value: 4, maxValue: 6),
                              _BarItem(day: 'أربعاء', value: 6, maxValue: 6),
                              _BarItem(day: 'خميس', value: 3, maxValue: 6, isCurrent: true),
                              _BarItem(day: 'جمعة', value: 2, maxValue: 6),
                            ]
                          : const [
                              _BarItem(day: 'أسبوع ١', value: 28, maxValue: 35),
                              _BarItem(day: 'أسبوع ٢', value: 30, maxValue: 35),
                              _BarItem(day: 'أسبوع ٣', value: 26, maxValue: 35),
                              _BarItem(day: 'أسبوع ٤', value: 28, maxValue: 35, isCurrent: true),
                            ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Memorization Portions Breakdown Card
            const WirdiSectionHeader(
              title: 'توزيع الإتقان في الحفظ',
            ),
            const SizedBox(height: 8),

            WirdiCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  _MasteryRow(
                    label: 'المحفوظ المتقن',
                    portion: 'سورة الفاتحة، الكهف (١-١٠)',
                    countBadge: '٧٠٪',
                    badgeType: WirdiBadgeType.success,
                  ),
                  Divider(height: 20),
                  _MasteryRow(
                    label: 'قيد التثبيت والمراجعة',
                    portion: 'سورة البقرة (١-٥٠)',
                    countBadge: '٢٠٪',
                    badgeType: WirdiBadgeType.warning,
                  ),
                  Divider(height: 20),
                  _MasteryRow(
                    label: 'الحفظ الجديد',
                    portion: 'سورة الملك (١-١٥)',
                    countBadge: '١٠٪',
                    badgeType: WirdiBadgeType.secondary,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _PeriodTab extends StatelessWidget {
  const _PeriodTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.emeraldPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
  });

  final String title;
  final String value;
  final String unit;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return WirdiCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.softGreenDarkContainer : AppColors.softGreenContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: AppColors.emeraldPrimary),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              fontSize: 10,
              color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _BarItem extends StatelessWidget {
  const _BarItem({
    required this.day,
    required this.value,
    required this.maxValue,
    this.isCurrent = false,
  });

  final String day;
  final double value;
  final double maxValue;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final factor = (value / maxValue).clamp(0.05, 1.0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '${value.toInt()}',
          style: TextStyle(
            fontSize: 10,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            color: isCurrent ? AppColors.emeraldPrimary : Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 22,
          height: 70 * factor,
          decoration: BoxDecoration(
            color: isCurrent
                ? AppColors.emeraldPrimary
                : (isDark ? AppColors.darkBorder : AppColors.softGreenContainer),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          day,
          style: TextStyle(
            fontSize: 11,
            color: isCurrent
                ? AppColors.emeraldPrimary
                : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _MasteryRow extends StatelessWidget {
  const _MasteryRow({
    required this.label,
    required this.portion,
    required this.countBadge,
    required this.badgeType,
  });

  final String label;
  final String portion;
  final String countBadge;
  final WirdiBadgeType badgeType;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 2),
            Text(
              portion,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
        WirdiBadge(label: countBadge, type: badgeType),
      ],
    );
  }
}
