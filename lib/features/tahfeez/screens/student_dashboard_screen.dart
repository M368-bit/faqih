import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fakieh_mosque_app/core/constants/app_colors.dart';
import 'package:fakieh_mosque_app/core/services/auth_service.dart';
import 'package:fakieh_mosque_app/core/services/tahfeez_service.dart';
import 'package:fakieh_mosque_app/core/theme/text_styles.dart';
import 'package:fakieh_mosque_app/core/widgets/glass_card.dart';
import 'package:fakieh_mosque_app/core/widgets/custom_button.dart';

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final tahfeezService = Provider.of<TahfeezService>(context);
    final currentUser = authService.currentUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final studentHomeworks = tahfeezService.getHomeworkForStudent(currentUser?.id ?? 'usr_student');
    final activeHomework = studentHomeworks.isNotEmpty ? studentHomeworks.first : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text("حلقات التحفيظ والواجب اليومي"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Teacher and Circle Info Card
            GlassCard(
              customColor: isDark ? const Color(0xFF0D251D) : const Color(0xFFF0FDF4),
              customBorder: Border.all(color: AppColors.primaryEmerald.withOpacity(0.35)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryEmerald,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 22),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentUser?.circleName ?? "حلقة الإمام نافع المدني",
                                style: AppTextStyles.titleMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryEmerald,
                                ),
                              ),
                              Text(
                                "معلم الحلقة: ${currentUser?.teacherName ?? 'الشيخ حمزة بن عبدالله القرشي'}",
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.slate,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time_rounded, size: 16, color: AppColors.slate),
                          const SizedBox(width: 6),
                          Text("يومياً بعد صلاة العصر", style: AppTextStyles.bodySmall),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 16, color: AppColors.gold),
                          const SizedBox(width: 4),
                          Text("تقييم الحفظ: ممتاز", style: AppTextStyles.labelSmall.copyWith(color: AppColors.goldDark, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Homework Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "واجبك اليومي (الجديد والمراجعة):",
                  style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "اليوم",
                    style: AppTextStyles.labelSmall.copyWith(color: AppColors.goldDark, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            if (activeHomework == null)
              GlassCard(
                child: Center(
                  child: Column(
                    children: [
                      const Icon(Icons.check_circle_outline_rounded, size: 48, color: AppColors.primaryEmerald),
                      const SizedBox(height: 10),
                      Text("أحسنت! لا توجد واجبات جديدة مسندة حالياً.", style: AppTextStyles.bodyMedium),
                    ],
                  ),
                ),
              )
            else ...[
              // Assignment 1: New Memorization (الجديد)
              GlassCard(
                customColor: isDark ? const Color(0xFF132A24) : Colors.white,
                customBorder: Border.all(color: AppColors.primaryEmerald.withOpacity(0.4), width: 1.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primaryEmerald,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "الجديد (الحفظ الجديد)",
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          activeHomework.isCompleted ? Icons.check_circle_rounded : Icons.pending_rounded,
                          color: activeHomework.isCompleted ? AppColors.success : AppColors.gold,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "سورة ${activeHomework.newSurahName}",
                      style: AppTextStyles.displayMedium.copyWith(
                        color: AppColors.primaryEmerald,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "من الآية ${activeHomework.newAyahFrom} إلى الآية ${activeHomework.newAyahTo}",
                      style: AppTextStyles.titleMedium.copyWith(
                        color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Assignment 2: Review (المراجعة)
              GlassCard(
                customColor: isDark ? const Color(0xFF232014) : Colors.white,
                customBorder: Border.all(color: AppColors.gold.withOpacity(0.4), width: 1.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.gold,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "المراجعة (التثبيت)",
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          activeHomework.isCompleted ? Icons.check_circle_rounded : Icons.history_edu_rounded,
                          color: activeHomework.isCompleted ? AppColors.success : AppColors.goldDark,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "سورة ${activeHomework.reviewSurahName}",
                      style: AppTextStyles.displayMedium.copyWith(
                        color: AppColors.goldDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "من الآية ${activeHomework.reviewAyahFrom} إلى الآية ${activeHomework.reviewAyahTo}",
                      style: AppTextStyles.titleMedium.copyWith(
                        color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),

              if (activeHomework.teacherNotes != null) ...[
                const SizedBox(height: 14),
                GlassCard(
                  customColor: AppColors.slate.withOpacity(0.06),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.lightbulb_outline_rounded, color: AppColors.gold, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "توجيه الشيخ: ${activeHomework.teacherNotes}",
                          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.slateDark),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 20),

              // Action button to mark ready
              CustomButton(
                text: activeHomework.isCompleted ? "تم التسميع بنجاح" : "تأكيد جاهزية التسميع للمعلم",
                icon: activeHomework.isCompleted ? Icons.verified_rounded : Icons.check_circle_outline_rounded,
                isGold: !activeHomework.isCompleted,
                onPressed: () {
                  tahfeezService.updateHomeworkCompletion(
                    homeworkId: activeHomework.id,
                    isCompleted: !activeHomework.isCompleted,
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
