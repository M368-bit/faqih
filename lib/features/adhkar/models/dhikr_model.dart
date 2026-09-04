enum DhikrCategoryType {
  morning,    // أذكار الصباح
  evening,    // أذكار المساء
  postPrayer, // أذكار بعد الصلاة
  custom,     // أذكار مخصصة ومختارة
}

extension DhikrCategoryExtension on DhikrCategoryType {
  String get titleAr {
    switch (this) {
      case DhikrCategoryType.morning:
        return 'أذكار الصباح';
      case DhikrCategoryType.evening:
        return 'أذكار المساء';
      case DhikrCategoryType.postPrayer:
        return 'أذكار بعد الصلاة المفروضة';
      case DhikrCategoryType.custom:
        return 'أذكار وأدعية مختارة';
    }
  }

  String get subtitleAr {
    switch (this) {
      case DhikrCategoryType.morning:
        return 'حصن نفسك بعد صلاة الفجر';
      case DhikrCategoryType.evening:
        return 'سكينة وطمأنينة بعد صلاة العصر';
      case DhikrCategoryType.postPrayer:
        return 'أذكار الاستغفار والتسبيح بعد السلام';
      case DhikrCategoryType.custom:
        return 'أدعية مأثورة من القرآن والسنة';
    }
  }
}

class DhikrItem {
  final String id;
  final DhikrCategoryType category;
  final String arabicText;
  final String? reward;
  final String? source;
  final int targetCount;
  int currentCount;
  final String? imageUrl;
  final String? audioUrl;

  DhikrItem({
    required this.id,
    required this.category,
    required this.arabicText,
    this.reward,
    this.source,
    this.targetCount = 1,
    this.currentCount = 0,
    this.imageUrl,
    this.audioUrl,
  });

  bool get isCompleted => currentCount >= targetCount;

  void increment() {
    if (currentCount < targetCount) {
      currentCount++;
    }
  }

  void reset() {
    currentCount = 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category.name,
      'arabicText': arabicText,
      'reward': reward,
      'source': source,
      'targetCount': targetCount,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
    };
  }

  factory DhikrItem.fromMap(Map<String, dynamic> map, String docId) {
    return DhikrItem(
      id: docId.isNotEmpty ? docId : (map['id'] ?? ''),
      category: DhikrCategoryType.values.firstWhere(
        (c) => c.name == map['category'],
        orElse: () => DhikrCategoryType.postPrayer,
      ),
      arabicText: map['arabicText'] ?? '',
      reward: map['reward'],
      source: map['source'],
      targetCount: map['targetCount'] ?? 1,
      imageUrl: map['imageUrl'],
      audioUrl: map['audioUrl'],
    );
  }
}
