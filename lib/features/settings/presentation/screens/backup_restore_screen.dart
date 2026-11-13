import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/wirdi_app_bar.dart';
import '../../../../shared/widgets/wirdi_badge.dart';
import '../../../../shared/widgets/wirdi_card.dart';

/// Backup and Restore Screen highlighting the offline-first privacy approach.
class BackupRestoreScreen extends StatefulWidget {
  const BackupRestoreScreen({super.key});

  @override
  State<BackupRestoreScreen> createState() => _BackupRestoreScreenState();
}

class _BackupRestoreScreenState extends State<BackupRestoreScreen> {
  String _lastBackupDate = 'اليوم • ٢:١٥ ص';
  bool _isProcessing = false;

  void _createBackup() {
    setState(() => _isProcessing = true);
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) {
        setState(() {
          _isProcessing = false;
          _lastBackupDate = 'الآن • ملف محلي جاهز';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إنشاء وتصدير النسخة الاحتياطية بنجاح في مجلد التنزيلات'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  void _restoreBackup() {
    showDialog(
      context: context,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? AppColors.darkCard : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('استعادة البيانات المحلية'),
          content: const Text(
            'سيتم استبدال البيانات الحالية بمحتوى النسخة الاحتياطية المحددة. هل تود المتابعة؟',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم استرجاع بياناتك بنجاح'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.emeraldPrimary),
              child: const Text('تأكيد الاستعادة'),
            ),
          ],
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
        title: 'النسخ الاحتياطي والاستعادة',
        subtitle: 'حماية وتأمين بياناتك محلياً',
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // Offline-first Privacy Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.softGreenDarkContainer : AppColors.softGreenContainer,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.softGreen,
                  width: 0.8,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.security_rounded,
                    size: 28,
                    color: AppColors.emeraldPrimary,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تطبيق محلي بلا اتصال (Offline-First)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.softGreenLight : AppColors.emeraldPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'جميع أورادك وإحصائياتك وسجلات الحفظ محفوظة على جهازك فقط، ولا يتم إرسال أي بيانات إلى أي خوادم خارجية.',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.5,
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

            // Backup Status Card
            WirdiCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'حالة النسخ الاحتياطي',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const WirdiBadge(
                        label: 'محلي وآمن',
                        type: WirdiBadgeType.success,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 16,
                        color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'آخر نسخة محفوظة: $_lastBackupDate',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Actions
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isProcessing ? null : _createBackup,
                      icon: _isProcessing
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Icon(Icons.file_upload_rounded, size: 18),
                      label: const Text('إنشاء نسخة احتياطية جديدة'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.emeraldPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _restoreBackup,
                      icon: const Icon(Icons.file_download_rounded, size: 18),
                      label: const Text('استعادة نسخة احتياطية سابقة'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                      ),
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
