import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/wirdi_app_bar.dart';
import '../../../../shared/widgets/wirdi_badge.dart';
import '../../../../shared/widgets/wirdi_card.dart';

class _SurahMeta {
  const _SurahMeta({
    required this.number,
    required this.name,
    required this.type,
    required this.ayahCount,
    required this.startPage,
  });

  final int number;
  final String name;
  final String type; // مكية / مدنية
  final int ayahCount;
  final int startPage;
}

/// Standard canonical metadata for Quran Surahs.
const List<_SurahMeta> _kSurahsList = [
  _SurahMeta(number: 1, name: 'الفاتحة', type: 'مكية', ayahCount: 7, startPage: 1),
  _SurahMeta(number: 2, name: 'البقرة', type: 'مدنية', ayahCount: 286, startPage: 2),
  _SurahMeta(number: 3, name: 'آل عمران', type: 'مدنية', ayahCount: 200, startPage: 50),
  _SurahMeta(number: 4, name: 'النساء', type: 'مدنية', ayahCount: 176, startPage: 77),
  _SurahMeta(number: 5, name: 'المائدة', type: 'مدنية', ayahCount: 120, startPage: 106),
  _SurahMeta(number: 6, name: 'الأنعام', type: 'مكية', ayahCount: 165, startPage: 128),
  _SurahMeta(number: 7, name: 'الأعراف', type: 'مكية', ayahCount: 206, startPage: 151),
  _SurahMeta(number: 8, name: 'الأنفال', type: 'مدنية', ayahCount: 75, startPage: 177),
  _SurahMeta(number: 9, name: 'التوبة', type: 'مدنية', ayahCount: 129, startPage: 187),
  _SurahMeta(number: 10, name: 'يونس', type: 'مكية', ayahCount: 109, startPage: 208),
  _SurahMeta(number: 11, name: 'هود', type: 'مكية', ayahCount: 123, startPage: 221),
  _SurahMeta(number: 12, name: 'يوسف', type: 'مكية', ayahCount: 111, startPage: 235),
  _SurahMeta(number: 13, name: 'الرعد', type: 'مدنية', ayahCount: 43, startPage: 249),
  _SurahMeta(number: 14, name: 'إبراهيم', type: 'مكية', ayahCount: 52, startPage: 255),
  _SurahMeta(number: 15, name: 'الحجر', type: 'مكية', ayahCount: 99, startPage: 262),
  _SurahMeta(number: 16, name: 'النحل', type: 'مكية', ayahCount: 128, startPage: 267),
  _SurahMeta(number: 17, name: 'الإسراء', type: 'مكية', ayahCount: 111, startPage: 282),
  _SurahMeta(number: 18, name: 'الكهف', type: 'مكية', ayahCount: 110, startPage: 293),
  _SurahMeta(number: 19, name: 'مريم', type: 'مكية', ayahCount: 98, startPage: 305),
  _SurahMeta(number: 20, name: 'طه', type: 'مكية', ayahCount: 135, startPage: 312),
  _SurahMeta(number: 36, name: 'يس', type: 'مكية', ayahCount: 83, startPage: 440),
  _SurahMeta(number: 55, name: 'الرحمن', type: 'مدنية', ayahCount: 78, startPage: 531),
  _SurahMeta(number: 56, name: 'الواقعة', type: 'مكية', ayahCount: 96, startPage: 534),
  _SurahMeta(number: 67, name: 'الملك', type: 'مكية', ayahCount: 30, startPage: 562),
  _SurahMeta(number: 112, name: 'الإخلاص', type: 'مكية', ayahCount: 4, startPage: 604),
  _SurahMeta(number: 113, name: 'الفلق', type: 'مكية', ayahCount: 5, startPage: 604),
  _SurahMeta(number: 114, name: 'الناس', type: 'مكية', ayahCount: 6, startPage: 604),
];

/// Surah Index Screen with search and canonical metadata.
class SurahIndexScreen extends StatefulWidget {
  const SurahIndexScreen({super.key});

  @override
  State<SurahIndexScreen> createState() => _SurahIndexScreenState();
}

class _SurahIndexScreenState extends State<SurahIndexScreen> {
  String _searchQuery = '';
  int _selectedTab = 0; // 0: السور, 1: الأجزاء

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filteredSurahs = _kSurahsList.where((s) {
      if (_searchQuery.isEmpty) return true;
      return s.name.contains(_searchQuery) || s.number.toString().contains(_searchQuery);
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: const WirdiAppBar(
        title: 'فهرس المصحف الشريف',
        subtitle: '١١٤ سورة • ٣٠ جزءاً',
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search & Filter Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  // Search Bar
                  TextField(
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val.trim();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'ابحث عن سورة أو رقمها...',
                      prefixIcon: const Icon(Icons.search_rounded, size: 20),
                      filled: true,
                      fillColor: isDark ? AppColors.darkCard : Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Segmented Tabs (السور / الأجزاء)
                  Row(
                    children: [
                      Expanded(
                        child: _TabButton(
                          label: 'السور (${filteredSurahs.length})',
                          isSelected: _selectedTab == 0,
                          onTap: () => setState(() => _selectedTab = 0),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _TabButton(
                          label: 'الأجزاء (٣٠ جزءاً)',
                          isSelected: _selectedTab == 1,
                          onTap: () => setState(() => _selectedTab = 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // List Content
            Expanded(
              child: _selectedTab == 0
                  ? ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      itemCount: filteredSurahs.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final surah = filteredSurahs[index];
                        return WirdiCard(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              // Surah Number in circle
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.softGreenDarkContainer
                                      : AppColors.softGreenContainer,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${surah.number}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: isDark
                                          ? AppColors.softGreenLight
                                          : AppColors.emeraldPrimary,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),

                              // Surah Name and Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      surah.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${surah.ayahCount} آية • ${surah.type}',
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

                              // Page Number Badge
                              WirdiBadge(
                                label: 'ص ${surah.startPage}',
                                type: WirdiBadgeType.subtle,
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      itemCount: 30,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final juzNumber = index + 1;
                        final pageStart = (juzNumber - 1) * 20 + 2;
                        return WirdiCard(
                          onTap: () => Navigator.of(context).pop(),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.auto_stories_rounded,
                                    size: 20,
                                    color: AppColors.emeraldPrimary,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'الجزء $juzNumber',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              WirdiBadge(
                                label: 'يبدأ من ص $pageStart',
                                type: WirdiBadgeType.secondary,
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

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.softGreenDarkContainer : AppColors.softGreenContainer)
              : (isDark ? AppColors.darkCard : Colors.white),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppColors.emeraldPrimary
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isSelected ? 1.4 : 1.0,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected
                  ? (isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary)
                  : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
            ),
          ),
        ),
      ),
    );
  }
}
