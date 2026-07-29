// نموذج الآية الواحدة
class Ayah {
  final int id; // رقم الآية داخل السورة
  final String text;
  final String transliteration;

  Ayah({
    required this.id,
    required this.text,
    required this.transliteration,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
      transliteration: json['transliteration'] ?? '',
    );
  }
}

// نموذج السورة
class Surah {
  final int id;
  final String name; // بالعربي، زي "الإخلاص"
  final String transliteration; // زي "Al-Ikhlas"
  final String type; // "meccan" أو "medinan"
  final int totalVerses;
  final List<Ayah> verses;

  Surah({
    required this.id,
    required this.name,
    required this.transliteration,
    required this.type,
    required this.totalVerses,
    required this.verses,
  });

  bool get isMeccan => type == 'meccan';

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      transliteration: json['transliteration'] ?? '',
      type: json['type'] ?? '',
      totalVerses: json['total_verses'] ?? 0,
      verses: (json['verses'] as List<dynamic>? ?? [])
          .map((e) => Ayah.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}