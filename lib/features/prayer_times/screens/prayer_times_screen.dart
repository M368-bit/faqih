import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/prayer_service.dart';
import '../../core/services/notification_service.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/prayer_countdown.dart';
import 'sheikh_prayer_override_sheet.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final prayerService = Provider.of<PrayerService>(context);
    final notifService = Provider.of<NotificationService>(context);
    final schedule = prayerService.schedule;
    final nextPrayer = prayerService.nextPrayer;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final canOverride = authService.currentUser?.canOverridePrayerTimes ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text("مواقيت الصلاة بمكة المكرمة"),
        actions: [
          if (canOverride)
            IconButton(
              tooltip: "تعديل المواقيت (صلاحية الشيخ)",
              icon: const Icon(Icons.edit_calendar_rounded, color: AppColors.gold),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (ctx) => const SheikhPrayerOverrideSheet(),
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Next Prayer Hero Card
            PrayerCountdownWidget(
              nextPrayerName: nextPrayer.nameAr,
              nextPrayerTime: nextPrayer.time,
              nextPrayerDateTime: nextPrayer.dateTime,
              iqamaDelayMinutes: nextPrayer.iqamaDelayMinutes,
              onPlayAzan: () => notifService.playCustomAzanSound(),
            ),

            const SizedBox(height: 20),

            // Hijri Date and Mosque Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_month_rounded, size: 18, color: AppColors.goldDark),
                    const SizedBox(width: 8),
                    Text(
                      schedule.hijriDate,
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (schedule.hasManualOverride)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.gold.withOpacity(0.4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.verified_rounded, size: 14, color: AppColors.goldDark),
                        const SizedBox(width: 4),
                        Text(
                          "معتمد من شيخ الجامع",
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.goldDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // Prayer Times List Cards
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: schedule.prayers.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 10),
              itemBuilder: (ctx, index) {
                final prayer = schedule.prayers[index];
                final isNext = prayer.key == nextPrayer.key;

                return GlassCard(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  customColor: isNext
                      ? (isDark ? const Color(0xFF163229) : const Color(0xFFECFDF5))
                      : null,
                  customBorder: isNext
                      ? Border.all(color: AppColors.primaryEmerald, width: 1.8)
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isNext
                                  ? AppColors.primaryEmerald
                                  : (isDark ? AppColors.surfaceDark : AppColors.backgroundLight),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _getPrayerIcon(prayer.key),
                              size: 20,
                              color: isNext ? Colors.white : AppColors.primaryEmerald,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    prayer.nameAr,
                                    style: AppTextStyles.titleMedium.copyWith(
                                      fontWeight: isNext ? FontWeight.bold : FontWeight.w600,
                                      color: isNext ? AppColors.primaryEmerald : null,
                                    ),
                                  ),
                                  if (prayer.isOverridden) ...[
                                    const SizedBox(width: 6),
                                    const Icon(Icons.tune_rounded, size: 14, color: AppColors.goldDark),
                                  ],
                                ],
                              ),
                              if (prayer.key != 'sunrise')
                                Text(
                                  "الإقامة بعد ${prayer.iqamaDelayMinutes} دقيقة",
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.slate,
                                    fontSize: 11,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        prayer.time,
                        style: AppTextStyles.titleLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isNext ? AppColors.primaryEmerald : null,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Sheikh Action Banner if privileged
            if (canOverride)
              GlassCard(
                customColor: AppColors.gold.withOpacity(0.08),
                customBorder: Border.all(color: AppColors.gold.withOpacity(0.3)),
                child: Row(
                  children: [
                    const Icon(Icons.admin_panel_settings_rounded, color: AppColors.goldDark, size: 28),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "لوحة تحكم الشيخ والمؤذن",
                            style: AppTextStyles.titleSmall.copyWith(
                              color: AppColors.goldDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "يمكنك تعديل مواقيت الصلوات وفترة انتظار الإقامة بما يتناسب مع جدول جامع فقيه.",
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.slate,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (ctx) => const SheikhPrayerOverrideSheet(),
                        );
                      },
                      child: const Text("تعديل", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getPrayerIcon(String key) {
    switch (key) {
      case 'fajr':
        return Icons.wb_twilight_rounded;
      case 'sunrise':
        return Icons.wb_sunny_outlined;
      case 'dhuhr':
        return Icons.wb_sunny_rounded;
      case 'asr':
        return Icons.wb_cloudy_rounded;
      case 'maghrib':
        return Icons.nights_stay_outlined;
      case 'isha':
      default:
        return Icons.nights_stay_rounded;
    }
  }
}
