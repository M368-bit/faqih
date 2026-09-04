import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/mock_data_service.dart';
import '../../core/services/notification_service.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/glass_card.dart';
import '../widgets/digital_tasbeeh_counter.dart';

class PostPrayerAdhkarScreen extends StatelessWidget {
  const PostPrayerAdhkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifService = Provider.of<NotificationService>(context);
    final items = MockDataService.postPrayerAdhkar;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Automated Push Alert Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppColors.emeraldGlassGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.notifications_active_rounded, color: AppColors.goldAccent, size: 28),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "التنبيه الآلي بعد الصلوات المفروضة",
                        style: AppTextStyles.titleSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "يتم إرسال الأذكار المأثورة دبر كل صلاة مكتوبة تلقائياً على هاتفك.",
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: notifService.postPrayerAdhkarEnabled,
                  activeColor: AppColors.goldAccent,
                  onChanged: (val) => notifService.togglePostPrayerAdhkar(val),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Simulation Button for tester
          Center(
            child: TextButton.icon(
              icon: const Icon(Icons.send_to_mobile_rounded, size: 16, color: AppColors.primaryEmerald),
              label: const Text(
                "تجربة استلام إشعار الأذكار الآن",
                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryEmerald),
              ),
              onPressed: () {
                notifService.triggerAutomatedPostPrayerNotification("العصر");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("تم إرسال إشعار أذكار بعد الصلاة التجريبي بنجاح."),
                    backgroundColor: AppColors.primaryEmerald,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Post prayer items
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (ctx, i) => const SizedBox(height: 16),
            itemBuilder: (ctx, index) {
              final dhikr = items[index];
              return GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primaryEmerald.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "${index + 1} من ${items.length}",
                            style: AppTextStyles.labelSmall.copyWith(color: AppColors.primaryEmerald),
                          ),
                        ),
                        if (dhikr.source != null)
                          Text(
                            dhikr.source!,
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      dhikr.arabicText,
                      style: AppTextStyles.dhikrText,
                      textAlign: TextAlign.center,
                    ),
                    if (dhikr.reward != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          dhikr.reward!,
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.goldDark),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    DigitalTasbeehCounter(
                      targetCount: dhikr.targetCount,
                      initialCount: dhikr.currentCount,
                      onCountChanged: (c) => dhikr.currentCount = c,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
