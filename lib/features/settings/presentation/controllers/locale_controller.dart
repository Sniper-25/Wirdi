import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/storage_service.dart';

/// StateNotifier for controlling and persisting the active app Locale.
/// Defaults to Arabic ('ar') with full RTL support.
class LocaleController extends StateNotifier<Locale> {
  LocaleController(this._storageService) : super(const Locale(AppConstants.localeArabic)) {
    _loadLocale();
  }

  final StorageService _storageService;

  void _loadLocale() {
    final savedCode = _storageService.getString(AppConstants.prefLocaleKey);
    if (savedCode == AppConstants.localeEnglish) {
      state = const Locale(AppConstants.localeEnglish);
    } else {
      // Default to Arabic
      state = const Locale(AppConstants.localeArabic);
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    await _storageService.setString(AppConstants.prefLocaleKey, locale.languageCode);
  }

  Future<void> toggleLocale() async {
    if (state.languageCode == AppConstants.localeArabic) {
      await setLocale(const Locale(AppConstants.localeEnglish));
    } else {
      await setLocale(const Locale(AppConstants.localeArabic));
    }
  }
}

final localeControllerProvider =
    StateNotifierProvider<LocaleController, Locale>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return LocaleController(storageService);
});
