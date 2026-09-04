import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fakieh_mosque_app/core/constants/app_colors.dart';
import 'package:fakieh_mosque_app/core/services/auth_service.dart';
import 'package:fakieh_mosque_app/core/services/lessons_service.dart';
import 'package:fakieh_mosque_app/core/theme/text_styles.dart';
import 'package:fakieh_mosque_app/core/widgets/glass_card.dart';
import 'package:fakieh_mosque_app/core/widgets/custom_button.dart';
import 'package:fakieh_mosque_app/features/lessons_sermons/models/lesson_model.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final lessonsService = Provider.of<LessonsService>(context);
    final lessons = lessonsService.lessons;
    final isStaff = authService.currentUser?.role.code == 'founder_admin' ||
        authService.currentUser?.role.code == 'mosque_sheikh';

    return Scaffold(
      appBar: AppBar(
        title: const Text("الدروس العلمية والخطب"),
        actions: [
          if (isStaff)
            IconButton(
              icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.gold),
              tooltip: "إضافة خطبة / درس جديد (حتى 1 جيجابايت)",
              onPressed: () => _showAddLessonModal(context, lessonsService, authService.currentUser?.name ?? 'الشيخ'),
            ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: lessons.length,
        separatorBuilder: (ctx, i) => const SizedBox(height: 16),
        itemBuilder: (ctx, index) {
          final lesson = lessons[index];

          return GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryEmerald.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        lesson.category.nameAr,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primaryEmerald,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        if (lesson.isUpcoming)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.gold.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "درس قادم",
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.goldDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (isStaff) ...[
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 20),
                            tooltip: "حذف الخطبة",
                            onPressed: () {
                              _confirmDelete(context, lessonsService, lesson);
                            },
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  lesson.title,
                  style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.person_outline_rounded, size: 16, color: AppColors.goldDark),
                    const SizedBox(width: 6),
                    Text(lesson.speakerName, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.place_outlined, size: 16, color: AppColors.slate),
                    const SizedBox(width: 6),
                    Text(lesson.locationHall, style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  lesson.description,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.slateDark),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    if (lesson.audioUrl != null)
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryEmerald,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: const Icon(Icons.play_arrow_rounded, size: 18),
                        label: const Text("استماع للتسجيل (1GB كحد أقصى)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("جاري تشغيل: ${lesson.title}"),
                              backgroundColor: AppColors.primaryEmerald,
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, LessonsService lessonsService, LessonModel lesson) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("تأكيد حذف الخطبة / الدرس"),
        content: Text("هل أنت متأكد من حذف \"${lesson.title}\" نهائياً؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("إلغاء"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () {
              lessonsService.deleteLesson(lesson.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("تم حذف الخطبة بنجاح."), backgroundColor: AppColors.error),
              );
            },
            child: const Text("حذف نهائي", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showAddLessonModal(BuildContext context, LessonsService lessonsService, String defaultSpeaker) {
    final titleController = TextEditingController();
    final speakerController = TextEditingController(text: defaultSpeaker);
    final hallController = TextEditingController(text: 'المصلى الرئيسي - جامع فقيه');
    final descController = TextEditingController();
    LessonCategory selectedCat = LessonCategory.fridayKhutbah;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("إضافة خطبة / درس جديد (حتى 1GB)", style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                      IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(Icons.close)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: "عنوان الخطبة أو الدرس"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: speakerController,
                    decoration: const InputDecoration(labelText: "اسم الخطيب / المحاضر"),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<LessonCategory>(
                    value: selectedCat,
                    decoration: const InputDecoration(labelText: "تصنيف المادة العلمية"),
                    items: LessonCategory.values.map((c) {
                      return DropdownMenuItem(value: c, child: Text(c.nameAr));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => selectedCat = val);
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: hallController,
                    decoration: const InputDecoration(labelText: "مكان الانعقاد بالجامع"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: descController,
                    maxLines: 2,
                    decoration: const InputDecoration(labelText: "نبذة عن محاور الدرس"),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "نشر الخطبة بالجامع",
                    icon: Icons.upload_file_rounded,
                    onPressed: () {
                      if (titleController.text.trim().isNotEmpty) {
                        lessonsService.addLesson(
                          LessonModel(
                            id: 'ls_${DateTime.now().millisecondsSinceEpoch}',
                            title: titleController.text.trim(),
                            speakerName: speakerController.text.trim(),
                            category: selectedCat,
                            dateTime: DateTime.now(),
                            locationHall: hallController.text.trim(),
                            description: descController.text.trim(),
                            audioUrl: 'https://audio.fakieh-mosque.sa/live_sermon.mp3',
                            isUpcoming: false,
                          ),
                        );
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("تم نشر الخطبة بنجاح."), backgroundColor: AppColors.primaryEmerald),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
