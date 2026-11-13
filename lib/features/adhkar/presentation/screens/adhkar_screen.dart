import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/wirdi_app_bar.dart';
import '../../../../shared/widgets/wirdi_badge.dart';
import '../../../../shared/widgets/wirdi_card.dart';
import '../../../../shared/widgets/wirdi_progress_bar.dart';

class _DhikrItem {
  _DhikrItem({
    required this.title,
    required this.text,
    required this.targetCount,
    required this.virtue,
  }) : currentCount = 0;

  final String title;
  final String text;
  final int targetCount;
  final String virtue;
  int currentCount;

  bool get isCompleted => currentCount >= targetCount;
}

/// Morning and Evening Adhkar Screen with interactive repetition counters.
class AdhkarScreen extends StatefulWidget {
  const AdhkarScreen({super.key});

  @override
  State<AdhkarScreen> createState() => _AdhkarScreenState();
}

class _AdhkarScreenState extends State<AdhkarScreen> {
  int _selectedTab = 0; // 0: أذكار الصباح, 1: أذكار المساء

  late List<_DhikrItem> _morningAdhkar;
  late List<_DhikrItem> _eveningAdhkar;

  @override
  void initState() {
    super.initState();
    _resetAdhkar();
  }

  void _resetAdhkar() {
    _morningAdhkar = [
      _DhikrItem(
        title: 'آية الكرسي',
        text: '«اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ...» [البقرة: ٢٥٥]',
        targetCount: 1,
        virtue: 'من قرأها حين يصبح أجير من الجن حتى يمسي',
      ),
      _DhikrItem(
        title: 'سيد الاستغفار',
        text: '«اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ لَكَ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ»',
        targetCount: 1,
        virtue: 'من قالها موقناً بها حين يصبح فمات من يومه دخل الجنة',
      ),
      _DhikrItem(
        title: 'المعوذتان والإخلاص',
        text: 'قراءة سورة الإخلاص والمعوذتين (الفلق والناس)',
        targetCount: 3,
        virtue: 'تكفيك من كل شيء',
      ),
      _DhikrItem(
        title: 'التسبيح والتحميد',
        text: '«سُبْحَانَ اللَّهِ وَبِحَمْدِهِ»',
        targetCount: 100,
        virtue: 'حُطت خطاياه وإن كانت مثل زبد البحر',
      ),
    ];

    _eveningAdhkar = [
      _DhikrItem(
        title: 'آية الكرسي',
        text: '«اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ...» [البقرة: ٢٥٥]',
        targetCount: 1,
        virtue: 'من قرأها حين يمسي أجير من الجن حتى يصبح',
      ),
      _DhikrItem(
        title: 'دعاء المساء',
        text: '«أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ...»',
        targetCount: 1,
        virtue: 'حفظ وبركة المساء',
      ),
      _DhikrItem(
        title: 'المعوذتان والإخلاص',
        text: 'قراءة سورة الإخلاص والمعوذتين (الفلق والناس)',
        targetCount: 3,
        virtue: 'تكفيك من كل شيء',
      ),
      _DhikrItem(
        title: 'الاستعاذة بكلمات الله',
        text: '«أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ»',
        targetCount: 3,
        virtue: 'لم يضره شيء في ليلته تلك',
      ),
    ];
  }

  void _incrementDhikr(_DhikrItem item) {
    if (item.currentCount < item.targetCount) {
      setState(() {
        item.currentCount++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeList = _selectedTab == 0 ? _morningAdhkar : _eveningAdhkar;
    final completedCount = activeList.where((d) => d.isCompleted).length;
    final progress = activeList.isNotEmpty ? (completedCount / activeList.length) : 0.0;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: WirdiAppBar(
        title: 'الأذكار المأثورة',
        subtitle: _selectedTab == 0 ? 'أذكار الصباح' : 'أذكار المساء',
        actions: [
          IconButton(
            tooltip: 'إعادة ضبط العداد',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              setState(() => _resetAdhkar());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تمت إعادة ضبط عدادات الأذكار'),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Segmented Tab Selector & Progress
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _AdhkarTabButton(
                          icon: Icons.wb_sunny_rounded,
                          label: 'أذكار الصباح',
                          isSelected: _selectedTab == 0,
                          onTap: () => setState(() => _selectedTab = 0),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _AdhkarTabButton(
                          icon: Icons.nights_stay_rounded,
                          label: 'أذكار المساء',
                          isSelected: _selectedTab == 1,
                          onTap: () => setState(() => _selectedTab = 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Progress Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'إنجاز الأذكار ($completedCount من ${activeList.length})',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                      Text(
                        '${(progress * 100).toInt()}٪',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  WirdiLinearProgress(progress: progress, height: 6),
                ],
              ),
            ),

            // Adhkar List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: activeList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final dhikr = activeList[index];
                  final isDone = dhikr.isCompleted;

                  return WirdiCard(
                    padding: const EdgeInsets.all(16),
                    borderColor: isDone
                        ? (isDark ? const Color(0xFF1B4D2E) : AppColors.softGreen)
                        : null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dhikr.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                              ),
                            ),
                            WirdiBadge(
                              label: '${dhikr.currentCount} / ${dhikr.targetCount}',
                              type: isDone ? WirdiBadgeType.success : WirdiBadgeType.secondary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Dhikr Body Text
                        Text(
                          dhikr.text,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.7,
                            fontWeight: FontWeight.w500,
                            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Virtue note
                        Text(
                          'الفضل: ${dhikr.virtue}',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? AppColors.softGreenLight : AppColors.softGreen,
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Interactive Tap-to-count Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isDone ? null : () => _incrementDhikr(dhikr),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDone
                                  ? (isDark ? AppColors.darkSurface : AppColors.lightSurface)
                                  : AppColors.emeraldPrimary,
                              foregroundColor: isDone ? Colors.grey : Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isDone ? Icons.check_circle_rounded : Icons.touch_app_rounded,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  isDone
                                      ? 'تم إكمال الذكر'
                                      : 'اضغط للعد (${dhikr.targetCount - dhikr.currentCount} متبقٍ)',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdhkarTabButton extends StatelessWidget {
  const _AdhkarTabButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.softGreenDarkContainer : AppColors.softGreenContainer)
              : (isDark ? AppColors.darkCard : Colors.white),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.emeraldPrimary
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected
                  ? (isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary)
                  : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? (isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary)
                    : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
