import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../../feature/azkar/data/model/azkar_model.dart';



class AzkarService {
  static List<AzkarCategory>? azkarCategory;

  static Future<List<AzkarCategory>> loadAll() async {
    if (azkarCategory != null) return azkarCategory!;
    final raw = await rootBundle.loadString("assets/data/azkar.json");
    final Map<String, dynamic> jsonMap = json.decode(raw);

    final categories = jsonMap.entries
        .map((e) => AzkarCategory.fromJson(e.key, e.value as List<dynamic>))
        .toList();

    azkarCategory = categories;
    return categories;
  }

  static Future<AzkarCategory?> loadByTitle(String title) async {
    final all = await loadAll();
    try {
      return all.firstWhere((c) => c.title == title);
    } catch (_) {
      return null;
    }
  }
}