enum PrayerType {
  fajr,
  sunrise,
  dhuhr,
  asr,
  maghrib,
  isha,
}

extension PrayerTypeExtension on PrayerType {
  String get nameAr {
    switch (this) {
      case PrayerType.fajr:
        return "الفجر";
      case PrayerType.sunrise:
        return "الشروق";
      case PrayerType.dhuhr:
        return "الظهر";
      case PrayerType.asr:
        return "العصر";
      case PrayerType.maghrib:
        return "المغرب";
      case PrayerType.isha:
        return "العشاء";
    }
  }

  String get nameEn {
    switch (this) {
      case PrayerType.fajr:
        return "Fajr";
      case PrayerType.sunrise:
        return "Sunrise";
      case PrayerType.dhuhr:
        return "Dhuhr";
      case PrayerType.asr:
        return "Asr";
      case PrayerType.maghrib:
        return "Maghrib";
      case PrayerType.isha:
        return "Isha";
    }
  }

  /// Default Iqama delay in minutes for Makkah mosques
  int get defaultIqamaDelayMinutes {
    switch (this) {
      case PrayerType.fajr:
        return 25;
      case PrayerType.sunrise:
        return 0;
      case PrayerType.dhuhr:
        return 20;
      case PrayerType.asr:
        return 20;
      case PrayerType.maghrib:
        return 10;
      case PrayerType.isha:
        return 20;
    }
  }
}
