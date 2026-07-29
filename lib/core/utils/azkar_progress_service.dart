import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AzkarProgressService {
  static const _progressPrefix = 'azkar_progress_';
  static const _datePrefix = 'azkar_progress_date_';

  static String _todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  static Future<Map<int, int>> loadProgress({
    required String categoryTitle,
    required List<int> defaultRepeats, // repeat الأصلي لكل عنصر بالترتيب
  })
  async {
    final prefs = await SharedPreferences.getInstance();
    final dateKey = '$_datePrefix$categoryTitle';
    final progressKey = '$_progressPrefix$categoryTitle';

    final savedDate = prefs.getString(dateKey);
    final today = _todayKey();

    if (savedDate != today) {
      await prefs.setString(dateKey, today);
      await prefs.remove(progressKey);
      return {
        for (var i = 0; i < defaultRepeats.length; i++) i: defaultRepeats[i]
      };
    }

    final raw = prefs.getString(progressKey);
    if (raw == null) {
      return {
        for (var i = 0; i < defaultRepeats.length; i++) i: defaultRepeats[i]
      };
    }

    final Map<String, dynamic> decoded = json.decode(raw);
    return {
      for (var i = 0; i < defaultRepeats.length; i++)
        i: (decoded[i.toString()] as int?) ?? defaultRepeats[i],
    };
  }

  static Future<void> saveProgress({
    required String categoryTitle,
    required Map<int, int> progress,
  })
  async {
    final prefs = await SharedPreferences.getInstance();
    final progressKey = '$_progressPrefix$categoryTitle';
    final encoded = json.encode(
        progress.map((k, v) => MapEntry(k.toString(), v)));
    await prefs.setString(progressKey, encoded);
  }

  static Future<void> resetProgress({
    required String categoryTitle,
    required List<int> defaultRepeats,
  })
  async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_progressPrefix$categoryTitle');
    await prefs.setString('$_datePrefix$categoryTitle', _todayKey());
  }

}
