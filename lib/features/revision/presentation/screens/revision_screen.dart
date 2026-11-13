import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/wirdi_app_bar.dart';
import '../../../../shared/widgets/wirdi_badge.dart';
import '../../../../shared/widgets/wirdi_card.dart';

class _RevisionTask {
  _RevisionTask({
    required this.portion,
    required this.surah,
    required this.type, // صغرى / كبرى
    required this.lastReviewed,
  }) : isDone = false;

  final String portion;
  final String surah;
  final String type;
  final String lastReviewed;
  bool isDone;
}

/// Revision Screen for tracking spaced revision cycles and logging review sessions.
class RevisionScreen extends StatefulWidget {
  const RevisionScreen({super.key});

  @override
  State<RevisionScreen> createState() => _RevisionScreenState();
}

class _RevisionScreenState extends State<RevisionScreen> {
  final List<_RevisionTask> _dueTasks = [
    _RevisionTask(
      portion: 'الآيات ١ - ٥٠',
      surah: 'سورة البقرة',
      type: 'مراجعة صغرى (يومية)',
      lastReviewed: 'أمس',
    ),
    _RevisionTask(
      portion: 'الجزء الثلاثون كاملاً',
      surah: 'جزء عم',
      type: 'مراجعة كبرى (أسبوعية)',
      lastReviewed: 'قبل ٥ أيام',
    ),
    _RevisionTask(
      portion: 'سورة الكهف كاملة',
      surah: 'سورة الكهف',
      type: 'تثبيت دوري',
      lastReviewed: 'قبل أسبوع',
    ),
  ];

  void _recordRevision(_RevisionTask task) {
    showDialog(
      context: context,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? AppColors.darkCard : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('تقييم جلسة المراجعة', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${task.surah} • ${task.portion}',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 18),
              const Text('كيف كان مستوى الإتقان في التسميع؟'),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _RatingChip(
                    label: 'ممتاز',
                    color: AppColors.success,
                    onTap: () => _finishReview(task, 'ممتاز'),
                  ),
                  _RatingChip(
                    label: 'جيد',
                    color: AppColors.softGreen,
                    onTap: () => _finishReview(task, 'جيد'),
                  ),
                  _RatingChip(
                    label: 'يحتاج تثبيت',
                    color: AppColors.warning,
                    onTap: () => _finishReview(task, 'يحتاج تثبيت'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _finishReview(_RevisionTask task, String rating) {
    setState(() {
      task.isDone = true;
    });
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم تسجيل مراجعة ${task.surah} بتقييم ($rating) بنجاح'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final doneCount = _dueTasks.where((t) => t.isDone).length;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: const WirdiAppBar(
        title: 'المراجعة والتثبيت',
        subtitle: 'المحافظة على ثبات القرآن في الصدر',
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // 1. Revision Strategy Card
            WirdiCard(
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
                              color: isDark
                                  ? AppColors.softGreenDarkContainer
                                  : AppColors.softGreenContainer,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.sync_rounded,
                              size: 20,
                              color: AppColors.emeraldPrimary,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'مراجعات اليوم المستحقة',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      WirdiBadge(
                        label: '$doneCount من ${_dueTasks.length} منجزة',
                        type: doneCount == _dueTasks.length
                            ? WirdiBadgeType.success
                            : WirdiBadgeType.secondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '«تعاهدوا هذا القرآن، فوالذي نفس محمد بيده لهو أشد تفلتاً من الإبل في عقلها»',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                      color: isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 2. Due Tasks Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Text(
                'المهام المستحقة للمراجعة اليوم',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                ),
              ),
            ),
            const SizedBox(height: 8),

            ..._dueTasks.map((task) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: WirdiCard(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Checkbox(
                        value: task.isDone,
                        activeColor: AppColors.emeraldPrimary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        onChanged: (val) {
                          if (val == true) {
                            _recordRevision(task);
                          } else {
                            setState(() => task.isDone = false);
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.surah,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                decoration: task.isDone ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${task.portion} • ${task.type}',
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
                      if (!task.isDone)
                        ElevatedButton(
                          onPressed: () => _recordRevision(task),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.emeraldPrimary,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          child: const Text('تسميع'),
                        )
                      else
                        const WirdiBadge(
                          label: 'تم التسميع',
                          type: WirdiBadgeType.success,
                        ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _RatingChip extends StatelessWidget {
  const _RatingChip({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color, width: 1.2),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
