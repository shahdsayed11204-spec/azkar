import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const _prefsKey = 'isDark';

  ThemeCubit() : super(const ThemeState(false)) {
    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool(_prefsKey) ?? false;
    emit(ThemeState(saved));
  }

  Future<void> setDarkMode(bool isDark) async {
    emit(ThemeState(isDark));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, isDark);
  }

  Future<void> toggle() async {
    await setDarkMode(!state.isDark);
  }
}