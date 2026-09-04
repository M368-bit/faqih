import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fakieh_mosque_app/core/constants/app_colors.dart';
import 'package:fakieh_mosque_app/core/services/auth_service.dart';
import 'package:fakieh_mosque_app/core/services/tahfeez_service.dart';
import 'package:fakieh_mosque_app/core/theme/text_styles.dart';
import 'package:fakieh_mosque_app/core/widgets/glass_card.dart';
import 'package:fakieh_mosque_app/core/widgets/custom_button.dart';
import 'package:fakieh_mosque_app/features/tahfeez/screens/assign_homework_modal.dart';
import 'package:fakieh_mosque_app/features/tahfeez/screens/applications_review_screen.dart';

class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final tahfeezService = Provider.of<TahfeezService>(context);
    final currentUser = authService.currentUser;
    final circle = tahfeezService.circles.first;
    final homeworks = tahfeezService.getHomeworkByTeacher(currentUser?.id ?? 'usr_teacher');
    final pendingApplications = tahfeezService.applications
        .where((a) => a.status.name == 'pending')
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة تحكم معلم التحفيظ"),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryEmerald,
          unselectedLabelColor: AppColors.slate,
          indicatorColor: AppColors.primaryEmerald,
          tabs: [
            const Tab(text: "طلاب الحلقة"),
            const Tab(text: "الواجبات والتقييم"),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("طلبات التسجيل"),
                  if (pendingApplications.isNotEmpty) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${pendingApplications.length}",
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Students in Circle
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Circle Hero Card
                GlassCard(
                  customColor: AppColors.primaryEmerald.withOpacity(0.08),
                  customBorder: Border.all(color: AppColors.primaryEmerald.withOpacity(0.3)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            circle.name,
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.primaryEmerald,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryEmerald,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "${circle.activeStudentsCount} / ${circle.maxCapacity} طالب",
                              style: AppTextStyles.labelSmall.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.access_time_rounded, size: 16, color: AppColors.slate),
                          const SizedBox(width: 6),
                          Text(circle.scheduleTime, style: AppTextStyles.bodySmall),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.room_rounded, size: 16, color: AppColors.slate),
                          const SizedBox(width: 6),
                          Text(circle.locationRoom, style: AppTextStyles.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Text(
                  "قائمة الطلاب المسجلين بالحلقة:",
                  style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // Dynamic Student List
                () {
                  final enrolledStudents = authService.users.where((u) => u.role == UserRole.student).toList();
                  if (enrolledStudents.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            Icon(Icons.people_outline_rounded, size: 48, color: AppColors.slate.withOpacity(0.5)),
                            const SizedBox(height: 8),
                            Text("لا يوجد طلاب مسجلون حالياً بالحلقة", style: AppTextStyles.bodyMedium.copyWith(color: AppColors.slate)),
                            const SizedBox(height: 4),
                            Text("سيظهر الطلاب هنا فور تسجيلهم وقبول طلباتهم", style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate.withOpacity(0.8))),
                          ],
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: enrolledStudents.map((st) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _buildStudentCard(
                        context,
                        studentId: st.id,
                        name: st.name,
                        phone: st.phone.isEmpty ? 'غير مسجل' : st.phone,
                        level: st.circleName ?? 'مستوى الحفظ العام',
                        progress: 0.0,
                        teacherId: currentUser?.id ?? '',
                      ),
                    )).toList(),
                  );
                }(),
              ],
            ),
          ),

          // Tab 2: Homeworks and Dynamic Progress
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "جدول التسميع اليومي والمتابعة:",
                  style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                if (homeworks.isEmpty)
                  const Center(child: Text("لا توجد واجبات مسندة لليوم."))
                else
                  ...homeworks.map((hw) => _buildHomeworkCard(context, hw, tahfeezService)),
              ],
            ),
          ),

          // Tab 3: Applications Review
          const ApplicationsReviewScreen(),
        ],
      ),
    );
  }

  Widget _buildStudentCard(
    BuildContext context, {
    required String studentId,
    required String name,
    required String phone,
    required String level,
    required double progress,
    required String teacherId,
  }) {
    return GlassCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primaryEmerald.withOpacity(0.15),
                    child: Text(
                      name[0],
                      style: const TextStyle(color: AppColors.primaryEmerald, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                      Text(phone, style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate)),
                    ],
                  ),
                ],
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryEmerald,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.assignment_outlined, size: 16),
                label: const Text("تعيين واجب", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (ctx) => AssignHomeworkModal(
                      teacherId: teacherId,
                      initialStudentId: studentId,
                      initialStudentName: name,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(level, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600)),
              Text("${(progress * 100).toInt()}% نسبة الإتقان", style: AppTextStyles.labelSmall.copyWith(color: AppColors.primaryEmerald)),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.slate.withOpacity(0.15),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryEmerald),
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeworkCard(BuildContext context, dynamic hw, TahfeezService tahfeezService) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hw.studentName,
                  style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: hw.isCompleted ? AppColors.success.withOpacity(0.15) : AppColors.warning.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    hw.isCompleted ? "تم التسميع بنجاح" : "قيد الحفظ والتسميع",
                    style: AppTextStyles.labelSmall.copyWith(
                      color: hw.isCompleted ? AppColors.success : AppColors.warning,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryEmerald.withOpacity(0.06),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.bookmark_added_rounded, color: AppColors.primaryEmerald, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "الجديد: ${hw.newFormattedText}",
                      style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.gold.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.refresh_rounded, color: AppColors.goldDark, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "المراجعة: ${hw.reviewFormattedText}",
                      style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            if (hw.teacherNotes != null) ...[
              const SizedBox(height: 8),
              Text(
                "توجيه المعلم: ${hw.teacherNotes}",
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate, fontStyle: FontStyle.italic),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  icon: Icon(
                    hw.isCompleted ? Icons.close_rounded : Icons.check_circle_rounded,
                    size: 16,
                    color: hw.isCompleted ? AppColors.error : AppColors.success,
                  ),
                  label: Text(
                    hw.isCompleted ? "إلغاء التسميع" : "اعتماد تسميع الطالب",
                    style: TextStyle(
                      color: hw.isCompleted ? AppColors.error : AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    tahfeezService.updateHomeworkCompletion(
                      homeworkId: hw.id,
                      isCompleted: !hw.isCompleted,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
