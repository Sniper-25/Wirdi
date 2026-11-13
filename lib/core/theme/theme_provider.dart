import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../services/storage_service.dart';

/// StateNotifier for controlling and persisting the active ThemeMode.
class ThemeController extends StateNotifier<ThemeMode> {
  ThemeController(this._storageService) : super(ThemeMode.system) {
    _loadTheme();
  }

  final StorageService _storageService;

  void _loadTheme() {
    final savedMode = _storageService.getString(AppConstants.prefThemeModeKey);
    if (savedMode == 'light') {
      state = ThemeMode.light;
    } else if (savedMode == 'dark') {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    String modeString;
    switch (mode) {
      case ThemeMode.light:
        modeString = 'light';
        break;
      case ThemeMode.dark:
        modeString = 'dark';
        break;
      case ThemeMode.system:
        modeString = 'system';
        break;
    }
    await _storageService.setString(AppConstants.prefThemeModeKey, modeString);
  }

  Future<void> toggleTheme() async {
    if (state == ThemeMode.dark) {
      await setThemeMode(ThemeMode.light);
    } else {
      await setThemeMode(ThemeMode.dark);
    }
  }
}

final themeControllerProvider =
    StateNotifierProvider<ThemeController, ThemeMode>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return ThemeController(storageService);
});
