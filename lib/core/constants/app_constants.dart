/// Mosque constants and metadata for جامع الشيخ عبد القادر فقيه
class AppConstants {
  static const String appNameAr = "جامع الشيخ عبد القادر فقيه";
  static const String appNameEn = "Sheikh Abdul Qader Fakieh Mosque";
  static const String appSubtitleAr = "مكة المكرمة - المملكة العربية السعودية";

  // Mosque Location (Makkah Al-Mukarramah)
  static const double mosqueLatitude = 21.4133;
  static const double mosqueLongitude = 39.8667;
  static const String mosqueAddressAr = "حي العزيزية، مكة المكرمة، المملكة العربية السعودية";
  static const String googleMapsUrl = "https://maps.google.com/?q=21.4133,39.8667";

  // Capacity & Architecture
  static const int totalCapacity = 8500;
  static const int tahfeezCirclesCount = 12;
  static const int activeStudentsCount = 280;

  // Notification Channels
  static const String azanNotificationChannelId = "fakieh_azan_channel";
  static const String azanNotificationChannelName = "تنبيهات الأذان ومواقيت الصلاة";
  
  static const String postPrayerChannelId = "fakieh_post_prayer_adhkar";
  static const String postPrayerChannelName = "أذكار ما بعد الصلاة التلقائية";

  static const String lessonsChannelId = "fakieh_lessons_channel";
  static const String lessonsChannelName = "الدروس والخطب والإعلانات";

  // Audio Assets
  static const String customAzanSoundAsset = "assets/audio/azan_makkah.mp3";
  static const String takbeerSoundAsset = "assets/audio/allahu_akbar.mp3";
}
