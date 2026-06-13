import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fruits_hub/core/services/shared_preferences_singleton.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(
          locale: Locale(Prefs.getString('locale').isEmpty
              ? 'ar'
              : Prefs.getString('locale')),
          themeMode: Prefs.getString('theme') == 'dark'
              ? ThemeMode.dark
              : ThemeMode.light,
        ));

  void changeLocale(String languageCode) {
    Prefs.setString('locale', languageCode);
    emit(state.copyWith(locale: Locale(languageCode)));
  }

  void toggleTheme() {
    final newMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    Prefs.setString('theme', newMode == ThemeMode.dark ? 'dark' : 'light');
    emit(state.copyWith(themeMode: newMode));
  }

  bool get isDarkMode => state.themeMode == ThemeMode.dark;
  bool get isArabic => state.locale.languageCode == 'ar';
}
