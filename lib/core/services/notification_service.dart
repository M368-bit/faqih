import 'package:flutter/foundation.dart';

class NotificationService extends ChangeNotifier {
  bool _isPlayingAudio = false;
  bool _azanSoundEnabled = true;
  bool _postPrayerAdhkarEnabled = true;
  bool _lessonRemindersEnabled = true;

  bool get isPlayingAudio => _isPlayingAudio;
  bool get azanSoundEnabled => _azanSoundEnabled;
  bool get postPrayerAdhkarEnabled => _postPrayerAdhkarEnabled;
  bool get lessonRemindersEnabled => _lessonRemindersEnabled;

  /// Play Custom Azan sound (stub — audio package not included in this build)
  Future<void> playCustomAzanSound() async {
    debugPrint("AZAN SOUND: الله أكبر - أشهد أن لا إله إلا الله");
    _isPlayingAudio = !_isPlayingAudio;
    notifyListeners();
  }

  Future<void> stopAudio() async {
    _isPlayingAudio = false;
    notifyListeners();
  }

  void toggleAzanSound(bool value) {
    _azanSoundEnabled = value;
    notifyListeners();
  }

  void togglePostPrayerAdhkar(bool value) {
    _postPrayerAdhkarEnabled = value;
    notifyListeners();
  }

  void toggleLessonReminders(bool value) {
    _lessonRemindersEnabled = value;
    notifyListeners();
  }

  /// Simulate automated Post-Prayer Adhkar notification
  void triggerAutomatedPostPrayerNotification(String prayerName) {
    debugPrint("PUSH NOTIFICATION: [أذكار ما بعد صلاة $prayerName]");
  }
}

