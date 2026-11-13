import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/wirdi_badge.dart';
import '../../../../shared/widgets/wirdi_card.dart';
import '../../../../shared/widgets/wirdi_progress_bar.dart';
import '../../../../shared/widgets/wirdi_section_header.dart';

/// Daily Wird Screen for managing and tracking the user's daily Quran reading goal.
class DailyWirdScreen extends StatefulWidget {
  const DailyWirdScreen({super.key});

  @override
  State<DailyWirdScreen> createState() => _DailyWirdScreenState();
}

class _DailyWirdScreenState extends State<DailyWirdScreen> {
  bool _isCompletedToday = false;
  int _targetPages = 4;
  int _readPages = 2;
  String _selectedPlan = 'حزب يومياً (٤ صفحات)';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = _targetPages > 0 ? (_readPages / _targetPages) : 0.0;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'الورد اليومي',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // 1. Today's Wird Overview Card
            WirdiCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ورد اليوم',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'من ص ٢ إلى ص ٦ • سورة البقرة',
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                      WirdiBadge(
                        label: _isCompletedToday ? 'مكتمل' : 'قيد القراءة',
                        type: _isCompletedToday ? WirdiBadgeType.success : WirdiBadgeType.secondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Circular Progress Indicator
                  WirdiCircularProgress(
                    progress: _isCompletedToday ? 1.0 : progress,
                    size: 88,
                    strokeWidth: 7,
                    centerText: _isCompletedToday ? '١٠٠٪' : '${(progress * 100).toInt()}٪',
                    subText: _isCompletedToday ? 'تم الإنجاز' : '$_readPages / $_targetPages ص',
                  ),

                  const SizedBox(height: 24),

                  // Complete Action Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isCompletedToday = !_isCompletedToday;
                          if (_isCompletedToday) {
                            _readPages = _targetPages;
                          } else {
                            _readPages = 2;
                          }
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _isCompletedToday
                                  ? 'هنيئاً لك! تم تسجيل إنجاز ورد اليوم مباركاً'
                                  : 'تمت إعادة تعيين حالة الورد',
                            ),
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: Icon(
                        _isCompletedToday ? Icons.check_circle_rounded : Icons.task_alt_rounded,
                        size: 20,
                      ),
                      label: Text(
                        _isCompletedToday ? 'تم إنجاز ورد اليوم' : 'تسجيل إنجاز الورد',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isCompletedToday
                            ? (isDark ? const Color(0xFF1B4D2E) : AppColors.success)
                            : AppColors.emeraldPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 2. Reading Target Configuration
            const WirdiSectionHeader(
              title: 'خطة الورد اليومي',
            ),
            const SizedBox(height: 8),

            WirdiCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  _PlanOption(
                    title: 'حزب يومياً (٤ صفحات)',
                    description: 'ختم القرآن الكريم في غضون ٥ أشهر',
                    isSelected: _selectedPlan == 'حزب يومياً (٤ صفحات)',
                    onSelect: () => setState(() {
                      _selectedPlan = 'حزب يومياً (٤ صفحات)';
                      _targetPages = 4;
                    }),
                  ),
                  const Divider(height: 16),
                  _PlanOption(
                    title: 'جزء يومياً (٢٠ صفحة)',
                    description: 'ختم القرآن الكريم شهرياً',
                    isSelected: _selectedPlan == 'جزء يومياً (٢٠ صفحة)',
                    onSelect: () => setState(() {
                      _selectedPlan = 'جزء يومياً (٢٠ صفحة)';
                      _targetPages = 20;
                    }),
                  ),
                  const Divider(height: 16),
                  _PlanOption(
                    title: 'صفحتان يومياً',
                    description: 'خطة ميسرة للبداية والتثبيت',
                    isSelected: _selectedPlan == 'صفحتان يومياً',
                    onSelect: () => setState(() {
                      _selectedPlan = 'صفحتان يومياً';
                      _targetPages = 2;
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 3. Streak and Habit Consistency
            const WirdiSectionHeader(
              title: 'سجل الاستمرار',
            ),
            const SizedBox(height: 8),

            WirdiCard(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.softGreenDarkContainer : AppColors.softGreenContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.local_fire_department_rounded,
                      size: 28,
                      color: AppColors.emeraldPrimary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '٥ أيام متتالية',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'أفضل التزام لك: ١٤ يوماً • استمر في المحافظة على وردك',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
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

class _PlanOption extends StatelessWidget {
  const _PlanOption({
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onSelect,
  });

  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onSelect,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
              color: isSelected ? AppColors.emeraldPrimary : Colors.grey,
              size: 22,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
