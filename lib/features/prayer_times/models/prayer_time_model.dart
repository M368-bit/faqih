class PrayerTimeItem {
  final String key;
  final String nameAr;
  final String time; // e.g. "05:12 AM" or "18:45"
  final DateTime dateTime;
  final int iqamaDelayMinutes;
  final bool isOverridden;

  const PrayerTimeItem({
    required this.key,
    required this.nameAr,
    required this.time,
    required this.dateTime,
    required this.iqamaDelayMinutes,
    this.isOverridden = false,
  });

  PrayerTimeItem copyWith({
    String? time,
    DateTime? dateTime,
    int? iqamaDelayMinutes,
    bool? isOverridden,
  }) {
    return PrayerTimeItem(
      key: key,
      nameAr: nameAr,
      time: time ?? this.time,
      dateTime: dateTime ?? this.dateTime,
      iqamaDelayMinutes: iqamaDelayMinutes ?? this.iqamaDelayMinutes,
      isOverridden: isOverridden ?? this.isOverridden,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'nameAr': nameAr,
      'time': time,
      'dateTime': dateTime.toIso8601String(),
      'iqamaDelayMinutes': iqamaDelayMinutes,
      'isOverridden': isOverridden,
    };
  }

  factory PrayerTimeItem.fromMap(Map<String, dynamic> map) {
    return PrayerTimeItem(
      key: map['key'] ?? '',
      nameAr: map['nameAr'] ?? '',
      time: map['time'] ?? '',
      dateTime: map['dateTime'] != null
          ? DateTime.tryParse(map['dateTime']) ?? DateTime.now()
          : DateTime.now(),
      iqamaDelayMinutes: map['iqamaDelayMinutes'] ?? 20,
      isOverridden: map['isOverridden'] ?? false,
    );
  }
}

class DayPrayerSchedule {
  final String hijriDate;
  final String gregorianDate;
  final List<PrayerTimeItem> prayers;
  final DateTime lastUpdated;
  final String updatedBySheikhName;
  final bool hasManualOverride;

  const DayPrayerSchedule({
    required this.hijriDate,
    required this.gregorianDate,
    required this.prayers,
    required this.lastUpdated,
    this.updatedBySheikhName = "شيخ المسجد",
    this.hasManualOverride = false,
  });

  PrayerTimeItem get fajr => prayers.firstWhere((p) => p.key == 'fajr');
  PrayerTimeItem get sunrise => prayers.firstWhere((p) => p.key == 'sunrise');
  PrayerTimeItem get dhuhr => prayers.firstWhere((p) => p.key == 'dhuhr');
  PrayerTimeItem get asr => prayers.firstWhere((p) => p.key == 'asr');
  PrayerTimeItem get maghrib => prayers.firstWhere((p) => p.key == 'maghrib');
  PrayerTimeItem get isha => prayers.firstWhere((p) => p.key == 'isha');

  PrayerTimeItem getNextPrayer() {
    final now = DateTime.now();
    for (final p in prayers) {
      if (p.key != 'sunrise' && p.dateTime.isAfter(now)) {
        return p;
      }
    }
    // If all passed, next is tomorrow's Fajr
    return fajr.copyWith(dateTime: fajr.dateTime.add(const Duration(days: 1)));
  }

  Map<String, dynamic> toMap() {
    return {
      'hijriDate': hijriDate,
      'gregorianDate': gregorianDate,
      'prayers': prayers.map((p) => p.toMap()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'updatedBySheikhName': updatedBySheikhName,
      'hasManualOverride': hasManualOverride,
    };
  }

  factory DayPrayerSchedule.fromMap(Map<String, dynamic> map) {
    return DayPrayerSchedule(
      hijriDate: map['hijriDate'] ?? '',
      gregorianDate: map['gregorianDate'] ?? '',
      prayers: (map['prayers'] as List<dynamic>?)
              ?.map((item) => PrayerTimeItem.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [],
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.tryParse(map['lastUpdated']) ?? DateTime.now()
          : DateTime.now(),
      updatedBySheikhName: map['updatedBySheikhName'] ?? 'شيخ المسجد',
      hasManualOverride: map['hasManualOverride'] ?? false,
    );
  }
}
