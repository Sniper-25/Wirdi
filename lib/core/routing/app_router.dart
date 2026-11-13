import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/adhkar/presentation/screens/adhkar_screen.dart';
import '../../features/daily_wird/presentation/screens/daily_wird_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/more_screen.dart';
import '../../features/home/presentation/screens/splash_screen.dart';
import '../../features/memorization/presentation/screens/memorization_screen.dart';
import '../../features/mushaf/presentation/screens/mushaf_reader_screen.dart';
import '../../features/mushaf/presentation/screens/surah_index_screen.dart';
import '../../features/revision/presentation/screens/revision_screen.dart';
import '../../features/settings/presentation/screens/backup_restore_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/statistics/presentation/screens/statistics_screen.dart';
import '../../shared/widgets/wirdi_nav_shell.dart';
import 'app_routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Riverpod provider configuring the application GoRouter with persistent bottom navigation.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      // 1. Splash / Launch Screen (Outside Bottom Nav)
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splashName,
        builder: (context, state) => const SplashScreen(),
      ),

      // 2. Persistent Bottom Navigation Shell (5 Branches)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return WirdiNavShell(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: الرئيسية (Home)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: AppRoutes.homeName,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          // Branch 1: المصحف (Mushaf)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.mushaf,
                name: AppRoutes.mushafName,
                builder: (context, state) => const MushafReaderScreen(),
                routes: [
                  GoRoute(
                    path: 'index',
                    name: AppRoutes.surahIndexName,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const SurahIndexScreen(),
                  ),
                ],
              ),
            ],
          ),

          // Branch 2: الورد (Wird)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.wird,
                name: AppRoutes.wirdName,
                builder: (context, state) => const DailyWirdScreen(),
              ),
            ],
          ),

          // Branch 3: الإحصائيات (Statistics)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.statistics,
                name: AppRoutes.statisticsName,
                builder: (context, state) => const StatisticsScreen(),
              ),
            ],
          ),

          // Branch 4: المزيد (More Hub)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.more,
                name: AppRoutes.moreName,
                builder: (context, state) => const MoreScreen(),
                routes: [
                  GoRoute(
                    path: 'memorization',
                    name: AppRoutes.memorizationName,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const MemorizationScreen(),
                  ),
                  GoRoute(
                    path: 'revision',
                    name: AppRoutes.revisionName,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const RevisionScreen(),
                  ),
                  GoRoute(
                    path: 'adhkar',
                    name: AppRoutes.adhkarName,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const AdhkarScreen(),
                  ),
                  GoRoute(
                    path: 'backup',
                    name: AppRoutes.backupName,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const BackupRestoreScreen(),
                  ),
                  GoRoute(
                    path: 'settings',
                    name: AppRoutes.settingsName,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const SettingsScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('الصفحة غير موجودة: ${state.uri}'),
      ),
    ),
  );
});
