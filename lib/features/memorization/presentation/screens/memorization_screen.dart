import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/wirdi_app_bar.dart';
import '../../../../shared/widgets/wirdi_badge.dart';
import '../../../../shared/widgets/wirdi_card.dart';
import '../../../../shared/widgets/wirdi_progress_bar.dart';

class _MemorizedItem {
  const _MemorizedItem({
    required this.surahName,
    required this.ayahRange,
    required this.mastery,
    required this.dateAdded,
  });

  final String surahName;
  final String ayahRange;
  final String mastery; // متقن / قيد التثبيت / جديد
  final String dateAdded;
}

/// Memorization Screen for tracking memorized Quran portions and adding new ranges.
class MemorizationScreen extends StatefulWidget {
  const MemorizationScreen({super.key});

  @override
  State<MemorizationScreen> createState() => _MemorizationScreenState();
}

class _MemorizationScreenState extends State<MemorizationScreen> {
  final List<_MemorizedItem> _items = [
    const _MemorizedItem(
      surahName: 'سورة الفاتحة',
      ayahRange: 'كاملة (٧ آيات)',
      mastery: 'متقن',
      dateAdded: 'مكتمل',
    ),
    const _MemorizedItem(
      surahName: 'سورة البقرة',
      ayahRange: 'الآيات ١ - ٥٠',
      mastery: 'قيد التثبيت',
      dateAdded: 'أمس',
    ),
    const _MemorizedItem(
      surahName: 'سورة الكهف',
      ayahRange: 'الآيات ١ - ١٠',
      mastery: 'متقن',
      dateAdded: 'الجمعة الماضية',
    ),
    const _MemorizedItem(
      surahName: 'سورة الملك',
      ayahRange: 'الآيات ١ - ١٥',
      mastery: 'جديد',
      dateAdded: 'اليوم',
    ),
  ];

  void _showAddRangeSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        String selectedSurah = 'سورة البقرة';
        String selectedMastery = 'جديد';

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightCard,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'إضافة مقطع حفظ جديد',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Surah Name Input
                  DropdownButtonFormField<String>(
                    initialValue: selectedSurah,
                    decoration: InputDecoration(
                      labelText: 'السورة',
                      filled: true,
                      fillColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'سورة البقرة', child: Text('سورة البقرة')),
                      DropdownMenuItem(value: 'سورة آل عمران', child: Text('سورة آل عمران')),
                      DropdownMenuItem(value: 'سورة الكهف', child: Text('سورة الكهف')),
                      DropdownMenuItem(value: 'سورة الملك', child: Text('سورة الملك')),
                    ],
                    onChanged: (val) {
                      if (val != null) setModalState(() => selectedSurah = val);
                    },
                  ),
                  const SizedBox(height: 14),

                  // Range Inputs
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: '١',
                          decoration: InputDecoration(
                            labelText: 'من آية',
                            filled: true,
                            fillColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          initialValue: '٢٥',
                          decoration: InputDecoration(
                            labelText: 'إلى آية',
                            filled: true,
                            fillColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Mastery Level
                  DropdownButtonFormField<String>(
                    initialValue: selectedMastery,
                    decoration: InputDecoration(
                      labelText: 'مستوى الإتقان',
                      filled: true,
                      fillColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'جديد', child: Text('جديد (قيد الحفظ)')),
                      DropdownMenuItem(value: 'قيد التثبيت', child: Text('قيد التثبيت')),
                      DropdownMenuItem(value: 'متقن', child: Text('متقن')),
                    ],
                    onChanged: (val) {
                      if (val != null) setModalState(() => selectedMastery = val);
                    },
                  ),
                  const SizedBox(height: 20),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _items.insert(
                            0,
                            _MemorizedItem(
                              surahName: selectedSurah,
                              ayahRange: 'الآيات ١ - ٢٥',
                              mastery: selectedMastery,
                              dateAdded: 'اليوم',
                            ),
                          );
                        });
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تمت إضافة مقطع الحفظ الجديد بنجاح'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.emeraldPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('حفظ المقطع'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: const WirdiAppBar(
        title: 'الحفظ الجديد',
        subtitle: 'متابعة حفظ مقاطع القرآن الكريم',
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddRangeSheet,
        backgroundColor: AppColors.emeraldPrimary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('إضافة مقطع حفظ'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // 1. Memorization Summary Card
            WirdiCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'إجمالي المحفوظ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '٣ أجزاء • ٦٥ صفحة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary,
                            ),
                          ),
                        ],
                      ),
                      const WirdiBadge(
                        label: 'هدف الختمة: ٣٠ جزءاً',
                        type: WirdiBadgeType.secondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const WirdiLinearProgress(
                    progress: 0.10, // 3 out of 30 juz
                    height: 8,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '١٠٪ من المصحف الشريف محفوظ وموثق',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 2. Active Memorized Surahs List Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Text(
                'المقاطع والسور المسجلة (${_items.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // 3. Items List
            ..._items.map((item) {
              WirdiBadgeType badgeType;
              if (item.mastery == 'متقن') {
                badgeType = WirdiBadgeType.success;
              } else if (item.mastery == 'قيد التثبيت') {
                badgeType = WirdiBadgeType.warning;
              } else {
                badgeType = WirdiBadgeType.secondary;
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: WirdiCard(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.softGreenDarkContainer
                              : AppColors.softGreenContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.bookmark_added_rounded,
                          color: AppColors.emeraldPrimary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.surahName,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.ayahRange,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          WirdiBadge(
                            label: item.mastery,
                            type: badgeType,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.dateAdded,
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark
                                  ? AppColors.darkTextTertiary
                                  : AppColors.lightTextTertiary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 60), // Space for FAB
          ],
        ),
      ),
    );
  }
}
