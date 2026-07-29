class AzkarCategory {
  final String title;
  final List<AzkarItem> items;

  AzkarCategory({
    required this.title,
    required this.items,
  });

  factory AzkarCategory.fromJson(String title, List<dynamic> jsonList) {
    return AzkarCategory(
      title: title,
      items: jsonList
          .map((e) => AzkarItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
class AzkarItem {
  final String text;
  final int repeat;
  final String description;
  final String reference;

  AzkarItem({
    required this.text,
    required this.repeat,
    this.description = '',
    this.reference = '',
  });

  factory AzkarItem.fromJson(Map<String, dynamic> json) {
    return AzkarItem(
      text: (json['content'] ?? '').toString().trim(),
      repeat: int.tryParse((json['count'] ?? '1').toString()) ?? 1,
      description: (json['description'] ?? '').toString(),
      reference: (json['reference'] ?? '').toString(),
    );
  }
}