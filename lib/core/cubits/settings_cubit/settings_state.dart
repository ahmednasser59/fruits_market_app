part of 'settings_cubit.dart';

class SettingsState {
  final Locale locale;
  final ThemeMode themeMode;

  const SettingsState({
    required this.locale,
    required this.themeMode,
  });

  SettingsState copyWith({
    Locale? locale,
    ThemeMode? themeMode,
  }) {
    return SettingsState(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
