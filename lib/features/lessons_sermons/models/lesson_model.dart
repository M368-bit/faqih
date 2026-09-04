enum LessonCategory {
  fridayKhutbah, // خطبة الجمعة
  tafseer,       // تفسير القرآن الكريم
  fiqh,          // دروس الفقه
  hadith,        // شرح الأحاديث النبوية
  seerah,        // السيرة النبوية العطرة
}

extension LessonCategoryExtension on LessonCategory {
  String get nameAr {
    switch (this) {
      case LessonCategory.fridayKhutbah:
        return 'خطبة الجمعة';
      case LessonCategory.tafseer:
        return 'تفسير القرآن';
      case LessonCategory.fiqh:
        return 'الفقه وأحكامه';
      case LessonCategory.hadith:
        return 'شروح الحديث';
      case LessonCategory.seerah:
        return 'السيرة النبوية';
    }
  }
}

class LessonModel {
  final String id;
  final String title;
  final String speakerName;
  final LessonCategory category;
  final DateTime dateTime;
  final String locationHall; // e.g. "المصلى الرئيسي - جامع فقيه"
  final String description;
  final String? audioUrl;
  final String? videoUrl;
  final String? pdfSummaryUrl;
  final bool isUpcoming;

  const LessonModel({
    required this.id,
    required this.title,
    required this.speakerName,
    required this.category,
    required this.dateTime,
    required this.locationHall,
    required this.description,
    this.audioUrl,
    this.videoUrl,
    this.pdfSummaryUrl,
    this.isUpcoming = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'speakerName': speakerName,
      'category': category.name,
      'dateTime': dateTime.toIso8601String(),
      'locationHall': locationHall,
      'description': description,
      'audioUrl': audioUrl,
      'videoUrl': videoUrl,
      'pdfSummaryUrl': pdfSummaryUrl,
      'isUpcoming': isUpcoming,
    };
  }

  factory LessonModel.fromMap(Map<String, dynamic> map, String docId) {
    return LessonModel(
      id: docId.isNotEmpty ? docId : (map['id'] ?? ''),
      title: map['title'] ?? '',
      speakerName: map['speakerName'] ?? '',
      category: LessonCategory.values.firstWhere(
        (c) => c.name == map['category'],
        orElse: () => LessonCategory.fridayKhutbah,
      ),
      dateTime: map['dateTime'] != null
          ? DateTime.tryParse(map['dateTime']) ?? DateTime.now()
          : DateTime.now(),
      locationHall: map['locationHall'] ?? 'جامع فقيه - مكة المكرمة',
      description: map['description'] ?? '',
      audioUrl: map['audioUrl'],
      videoUrl: map['videoUrl'],
      pdfSummaryUrl: map['pdfSummaryUrl'],
      isUpcoming: map['isUpcoming'] ?? false,
    );
  }
}
