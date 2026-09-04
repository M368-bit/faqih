import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:fakieh_mosque_app/features/prayer_times/models/prayer_time_model.dart';
import 'package:fakieh_mosque_app/core/services/mock_data_service.dart';

class PrayerService extends ChangeNotifier {
  DayPrayerSchedule _schedule = MockDataService.getInitialPrayerSchedule();
  bool _isLoading = false;
  Timer? _ticker;

  DayPrayerSchedule get schedule => _schedule;
  bool get isLoading => _isLoading;

  PrayerService() {
    // Start 1-second ticker to keep countdowns responsive
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  PrayerTimeItem get nextPrayer => _schedule.getNextPrayer();

  /// Sheikh / Admin Exclusive Override for a Prayer Time
  Future<bool> overridePrayerTime({
    required String prayerKey,
    required String newTimeStr,
    required DateTime newDateTime,
    required String sheikhName,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 400));

    final updatedPrayers = _schedule.prayers.map((p) {
      if (p.key == prayerKey) {
        return p.copyWith(
          time: newTimeStr,
          dateTime: newDateTime,
          isOverridden: true,
        );
      }
      return p;
    }).toList();

    _schedule = DayPrayerSchedule(
      hijriDate: _schedule.hijriDate,
      gregorianDate: _schedule.gregorianDate,
      prayers: updatedPrayers,
      lastUpdated: DateTime.now(),
      updatedBySheikhName: sheikhName,
      hasManualOverride: true,
    );

    _isLoading = false;
    notifyListeners();
    return true;
  }

  /// Sheikh / Admin update Iqama Delay in Minutes
  Future<bool> updateIqamaDelay({
    required String prayerKey,
    required int delayMinutes,
    required String sheikhName,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    final updatedPrayers = _schedule.prayers.map((p) {
      if (p.key == prayerKey) {
        return p.copyWith(
          iqamaDelayMinutes: delayMinutes,
          isOverridden: true,
        );
      }
      return p;
    }).toList();

    _schedule = DayPrayerSchedule(
      hijriDate: _schedule.hijriDate,
      gregorianDate: _schedule.gregorianDate,
      prayers: updatedPrayers,
      lastUpdated: DateTime.now(),
      updatedBySheikhName: sheikhName,
      hasManualOverride: true,
    );

    _isLoading = false;
    notifyListeners();
    return true;
  }

  /// Reset all prayer times back to default Makkah calculation
  Future<void> resetToOfficialCalculation() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 400));
    _schedule = MockDataService.getInitialPrayerSchedule();

    _isLoading = false;
    notifyListeners();
  }
}
