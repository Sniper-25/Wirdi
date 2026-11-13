import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wirdi/core/services/storage_service.dart';
import 'package:wirdi/main.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('WirdiApp boots with Arabic RTL, Calm Green UI, and bottom navigation', (WidgetTester tester) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
        child: const WirdiApp(),
      ),
    );

    // Initial frame on Splash screen
    await tester.pump();
    expect(find.text('وِردي'), findsWidgets);

    // Verify RTL text directionality
    final directionality = tester.widget<Directionality>(find.byType(Directionality).first);
    expect(directionality.textDirection, TextDirection.rtl);

    // Transition through splash animation to home
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Verify Home Screen with Calm Green identity
    expect(find.text('وِردي'), findsWidgets);
    expect(find.text('ورد اليوم'), findsOneWidget);
    expect(find.text('متابعة الورد القرآني'), findsOneWidget);

    // Verify Bottom Navigation Destinations
    expect(find.widgetWithText(NavigationDestination, 'الرئيسية'), findsOneWidget);
    expect(find.widgetWithText(NavigationDestination, 'المصحف'), findsOneWidget);
    expect(find.widgetWithText(NavigationDestination, 'الورد'), findsOneWidget);
    expect(find.widgetWithText(NavigationDestination, 'الإحصائيات'), findsOneWidget);
    expect(find.widgetWithText(NavigationDestination, 'المزيد'), findsOneWidget);

    // Test Navigation to 'المصحف' (Mushaf Reader)
    await tester.tap(find.widgetWithText(NavigationDestination, 'المصحف'));
    await tester.pumpAndSettle();
    expect(find.text('سورة البقرة'), findsWidgets);
    expect(find.text('الصفحة التالية'), findsOneWidget);
    expect(find.text('الصفحة السابقة'), findsOneWidget);

    // Test Navigation to 'الورد' (Daily Wird)
    await tester.tap(find.widgetWithText(NavigationDestination, 'الورد'));
    await tester.pumpAndSettle();
    expect(find.text('خطة الورد اليومي'), findsOneWidget);
    expect(find.text('تسجيل إنجاز الورد'), findsOneWidget);

    // Test Navigation to 'الإحصائيات' (Statistics)
    await tester.tap(find.widgetWithText(NavigationDestination, 'الإحصائيات'));
    await tester.pumpAndSettle();
    expect(find.text('الإحصائيات والتقدم'), findsOneWidget);
    expect(find.text('الصفحات المقروءة'), findsOneWidget);

    // Test Navigation to 'المزيد' (More Hub)
    await tester.tap(find.widgetWithText(NavigationDestination, 'المزيد'));
    await tester.pumpAndSettle();
    expect(find.text('الحفظ الجديد'), findsOneWidget);
    expect(find.text('المراجعة والتثبيت'), findsOneWidget);
    expect(find.text('الأذكار المأثورة'), findsOneWidget);
    expect(find.text('النسخ الاحتياطي والاستعادة'), findsOneWidget);
    expect(find.text('الإعدادات'), findsOneWidget);
  });
}
