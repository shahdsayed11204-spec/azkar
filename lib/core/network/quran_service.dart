import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../../feature/quran/data/model/quran_model.dart';

class QuranService {
  static List<Surah>? surah;

  static Future<List<Surah>> loadAll() async {
    if (surah != null) return surah!;

    final raw = await rootBundle.loadString('assets/data/quran.json');
    final List<dynamic> jsonList = json.decode(raw);

    final surahs = jsonList
        .map((e) => Surah.fromJson(e as Map<String, dynamic>))
        .toList();

    surah = surahs;
    return surahs;
  }

  static Future<Surah?> loadById(int id) async {
    final all = await loadAll();
    try {
      return all.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }
}