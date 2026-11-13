import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/wirdi_badge.dart';

/// Quran Mushaf Reader with neutral placeholder display conforming to religious content guidelines.
class MushafReaderScreen extends StatefulWidget {
  const MushafReaderScreen({super.key});

  @override
  State<MushafReaderScreen> createState() => _MushafReaderScreenState();
}

class _MushafReaderScreenState extends State<MushafReaderScreen> {
  int _currentPage = 2;
  final int _totalPages = 604;
  bool _isBookmarked = false;
  String _currentSurah = 'سورة البقرة';
  int _currentJuz = 1;

  void _nextPage() {
    if (_currentPage < _totalPages) {
      setState(() {
        _currentPage++;
        if (_currentPage >= 50) {
          _currentSurah = 'سورة آل عمران';
          _currentJuz = 3;
        }
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
        if (_currentPage < 50) {
          _currentSurah = 'سورة البقرة';
          _currentJuz = 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              _currentSurah,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text(
              'الجزء $_currentJuz • الحزب الأول',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
        actions: [
          // Bookmark Action
          IconButton(
            tooltip: _isBookmarked ? 'إزالة الفاصل' : 'حفظ فاصل القراءة',
            icon: Icon(
              _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: _isBookmarked ? AppColors.emeraldPrimary : null,
            ),
            onPressed: () {
              setState(() {
                _isBookmarked = !_isBookmarked;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isBookmarked
                        ? 'تم حفظ فاصل القراءة في الصفحة $_currentPage'
                        : 'تمت إزالة الفاصل',
                  ),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          // Surah Index Shortcut
          IconButton(
            tooltip: 'فهرس السور',
            icon: const Icon(Icons.format_list_bulleted_rounded),
            onPressed: () => context.push(AppRoutes.surahIndex),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Page Display Canvas
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.mushafPaperDark : AppColors.mushafPaperLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? AppColors.darkBorder : AppColors.mushafBorder,
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      children: [
                        // Top Page Header inside canvas
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'الجزء $_currentJuz',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                              ),
                            ),
                            Text(
                              _currentSurah,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24, thickness: 0.8),

                        // Neutral Quran Canvas Content
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Surah Header Frame
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? AppColors.softGreenDarkContainer
                                          : AppColors.softGreenContainer,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: isDark ? AppColors.darkBorder : AppColors.softGreen,
                                        width: 0.8,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _currentSurah,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isDark
                                              ? AppColors.softGreenLight
                                              : AppColors.emeraldPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),

                                  // Neutral Canvas Notice & Structure Indicator
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: isDark ? AppColors.darkCard : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.menu_book_rounded,
                                          size: 38,
                                          color: isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary,
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          'الصفحة $_currentPage',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'مساحة عرض صفحات المصحف الشريف\nوفق الرسم العثماني المعتمد',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13,
                                            height: 1.5,
                                            color: isDark
                                                ? AppColors.darkTextSecondary
                                                : AppColors.lightTextSecondary,
                                          ),
                                        ),
                                        const SizedBox(height: 14),
                                        const WirdiBadge(
                                          label: 'مساحة قراءة محايدة ومعتمدة',
                                          type: WirdiBadgeType.secondary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const Divider(height: 24, thickness: 0.8),
                        // Page Bottom Number inside canvas
                        Text(
                          '$_currentPage',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Navigation Controls
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  // Page Slider & Indicator
                  Row(
                    children: [
                      Text(
                        'ص ١',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: _currentPage.toDouble(),
                          min: 1,
                          max: _totalPages.toDouble(),
                          divisions: _totalPages,
                          activeColor: AppColors.emeraldPrimary,
                          inactiveColor: isDark ? AppColors.darkBorder : AppColors.softGreenContainer,
                          onChanged: (val) {
                            setState(() {
                              _currentPage = val.toInt();
                            });
                          },
                        ),
                      ),
                      Text(
                        'ص ٦٠٤',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                        ),
                      ),
                    ],
                  ),

                  // Prev / Next Page Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _currentPage > 1 ? _previousPage : null,
                          icon: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                          label: const Text('الصفحة السابقة'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _currentPage < _totalPages ? _nextPage : null,
                          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 14),
                          label: const Text('الصفحة التالية'),
                        ),
                      ),
                    ],
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
