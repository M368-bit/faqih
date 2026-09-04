import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/quran_data.dart';
import '../../core/services/tahfeez_service.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_surah_picker.dart';
import '../models/tahfeez_models.dart';

class AssignHomeworkModal extends StatefulWidget {
  final String teacherId;
  final String initialStudentId;
  final String initialStudentName;

  const AssignHomeworkModal({
    super.key,
    required this.teacherId,
    this.initialStudentId = '',
    this.initialStudentName = 'طالب الحلقة',
  });

  @override
  State<AssignHomeworkModal> createState() => _AssignHomeworkModalState();
}

class _AssignHomeworkModalState extends State<AssignHomeworkModal> {
  late String _studentId;
  late String _studentName;

  // New Memorization (الجديد)
  int _newSurahNumber = 18; // Al-Kahf
  int _newAyahFrom = 1;
  int _newAyahTo = 16;

  // Review (المراجعة)
  int _reviewSurahNumber = 17; // Al-Isra
  int _reviewAyahFrom = 70;
  int _reviewAyahTo = 111;

  final TextEditingController _notesController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _studentId = widget.initialStudentId;
    _studentName = widget.initialStudentName;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tahfeezService = Provider.of<TahfeezService>(context, listen: false);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final newSurah = QuranData.getByNumber(_newSurahNumber);
    final reviewSurah = QuranData.getByNumber(_reviewSurahNumber);

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(color: AppColors.gold.withOpacity(0.5), width: 2),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryEmerald.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.assignment_add_rounded, color: AppColors.primaryEmerald, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "تعيين الواجب والجدول اليومي",
                          style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "للطالب: $_studentName",
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryEmerald, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // SECTION 1: New Memorization (الجديد)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryEmerald.withOpacity(0.35)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primaryEmerald,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "الجديد (الحفظ الجديد)",
                          style: AppTextStyles.labelSmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Custom Surah Selector Trigger (Custom Islamic Dialog)
                  InkWell(
                    onTap: () async {
                      final picked = await CustomSurahPickerModal.show(context, initialSurah: _newSurahNumber);
                      if (picked != null) {
                        setState(() {
                          _newSurahNumber = picked.number;
                          _newAyahFrom = 1;
                          _newAyahTo = picked.totalVerses.clamp(1, 15);
                        });
                      }
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.cardDark : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.primaryEmerald.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.menu_book_rounded, color: AppColors.primaryEmerald, size: 20),
                              const SizedBox(width: 10),
                              Text(
                                "سورة ${newSurah.nameAr} (${newSurah.totalVerses} آية)",
                                style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            "تغيير السورة",
                            style: AppTextStyles.labelSmall.copyWith(color: AppColors.goldDark, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _newAyahFrom.toString(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: "من الآية"),
                          onChanged: (v) => _newAyahFrom = int.tryParse(v) ?? 1,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          initialValue: _newAyahTo.toString(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "إلى الآية (حتى ${newSurah.totalVerses})"),
                          onChanged: (v) => _newAyahTo = int.tryParse(v) ?? newSurah.totalVerses,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // SECTION 2: Review (المراجعة)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.gold.withOpacity(0.35)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "المراجعة (التثبيت)",
                          style: AppTextStyles.labelSmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Custom Surah Selector Trigger
                  InkWell(
                    onTap: () async {
                      final picked = await CustomSurahPickerModal.show(context, initialSurah: _reviewSurahNumber);
                      if (picked != null) {
                        setState(() {
                          _reviewSurahNumber = picked.number;
                          _reviewAyahFrom = 1;
                          _reviewAyahTo = picked.totalVerses;
                        });
                      }
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.cardDark : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.gold.withOpacity(0.4)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.refresh_rounded, color: AppColors.goldDark, size: 20),
                              const SizedBox(width: 10),
                              Text(
                                "سورة ${reviewSurah.nameAr} (${reviewSurah.totalVerses} آية)",
                                style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            "تغيير السورة",
                            style: AppTextStyles.labelSmall.copyWith(color: AppColors.goldDark, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _reviewAyahFrom.toString(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: "من الآية"),
                          onChanged: (v) => _reviewAyahFrom = int.tryParse(v) ?? 1,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          initialValue: _reviewAyahTo.toString(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "إلى الآية (حتى ${reviewSurah.totalVerses})"),
                          onChanged: (v) => _reviewAyahTo = int.tryParse(v) ?? reviewSurah.totalVerses,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Teacher Notes
            TextFormField(
              controller: _notesController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: "ملاحظات وتوجيهات المعلم للطالب",
                hintText: "مثال: مراجعة مخارج الحروف وقواعد الإدغام...",
              ),
            ),

            const SizedBox(height: 24),

            // Submit Button
            CustomButton(
              text: "اعتماد وإرسال الواجب للطالب",
              icon: Icons.send_rounded,
              isLoading: _isLoading,
              onPressed: () async {
                setState(() => _isLoading = true);

                final hw = DailyHomeworkModel(
                  id: 'hw_${DateTime.now().millisecondsSinceEpoch}',
                  studentId: _studentId,
                  studentName: _studentName,
                  teacherId: widget.teacherId,
                  date: DateTime.now(),
                  newSurahNumber: _newSurahNumber,
                  newSurahName: QuranData.getByNumber(_newSurahNumber).nameAr,
                  newAyahFrom: _newAyahFrom,
                  newAyahTo: _newAyahTo,
                  reviewSurahNumber: _reviewSurahNumber,
                  reviewSurahName: QuranData.getByNumber(_reviewSurahNumber).nameAr,
                  reviewAyahFrom: _reviewAyahFrom,
                  reviewAyahTo: _reviewAyahTo,
                  teacherNotes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
                  isCompleted: false,
                );

                await tahfeezService.assignHomework(hw);
                setState(() => _isLoading = false);

                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("تم إرسال واجب الجديد والمراجعة للطالب $_studentName بنجاح."),
                      backgroundColor: AppColors.primaryEmerald,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
