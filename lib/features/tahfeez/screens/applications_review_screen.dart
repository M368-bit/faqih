import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fakieh_mosque_app/core/constants/app_colors.dart';
import 'package:fakieh_mosque_app/core/services/auth_service.dart';
import 'package:fakieh_mosque_app/core/services/tahfeez_service.dart';
import 'package:fakieh_mosque_app/core/theme/text_styles.dart';
import 'package:fakieh_mosque_app/core/widgets/glass_card.dart';
import 'package:fakieh_mosque_app/features/tahfeez/models/tahfeez_models.dart';

class ApplicationsReviewScreen extends StatelessWidget {
  const ApplicationsReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final tahfeezService = Provider.of<TahfeezService>(context);
    final applications = tahfeezService.applications;
    final currentUser = authService.currentUser;

    if (applications.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text("لا توجد طلبات تقديم جديدة حالياً."),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: applications.length,
      separatorBuilder: (ctx, i) => const SizedBox(height: 14),
      itemBuilder: (ctx, index) {
        final app = applications[index];
        final isPending = app.status == ApplicationStatus.pending;

        return GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primaryEmerald.withOpacity(0.12),
                        child: Text(
                          app.applicantName.isNotEmpty ? app.applicantName[0] : 'U',
                          style: const TextStyle(color: AppColors.primaryEmerald, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            app.applicantName,
                            style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${app.phone} • ${app.age} سنة",
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isPending
                          ? AppColors.warning.withOpacity(0.15)
                          : (app.status == ApplicationStatus.approved
                              ? AppColors.success.withOpacity(0.15)
                              : AppColors.error.withOpacity(0.15)),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isPending
                            ? AppColors.warning
                            : (app.status == ApplicationStatus.approved
                                ? AppColors.success
                                : AppColors.error),
                      ),
                    ),
                    child: Text(
                      app.status.nameAr,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isPending
                            ? AppColors.goldDark
                            : (app.status == ApplicationStatus.approved
                                ? AppColors.success
                                : AppColors.error),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryEmerald.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star_outline_rounded, size: 16, color: AppColors.primaryEmerald),
                        const SizedBox(width: 6),
                        Expanded(child: Text("المستوى: ${app.currentMemorizationLevel}", style: AppTextStyles.bodySmall)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.group_outlined, size: 16, color: AppColors.goldDark),
                        const SizedBox(width: 6),
                        Expanded(child: Text("الحلقة المحددة: ${app.preferredCircleName}", style: AppTextStyles.bodySmall)),
                      ],
                    ),
                    if (app.notes != null) ...[
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.notes_rounded, size: 16, color: AppColors.slate),
                          const SizedBox(width: 6),
                          Expanded(child: Text("ملاحظة المتقدم: ${app.notes}", style: AppTextStyles.bodySmall.copyWith(color: AppColors.slateDark))),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (isPending) ...[
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryEmerald,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: const Icon(Icons.check_circle_rounded, size: 18),
                        label: const Text("قبول وتعيين الحلقة", style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () {
                          _showCircleAssignmentDialog(context, tahfeezService, app, currentUser?.name ?? 'المشرف');
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.error,
                          side: const BorderSide(color: AppColors.error),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: const Icon(Icons.cancel_outlined, size: 18),
                        label: const Text("رفض (اعتذار)", style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () {
                          tahfeezService.reviewApplication(
                            applicationId: app.id,
                            status: ApplicationStatus.rejected,
                            reviewerName: currentUser?.name ?? 'المشرف',
                            rejectionReason: 'نعتذر لعدم توفر مقاعد شاغرة حالياً',
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("تم رفض الطلب وتحديث الحالة إلى نعتذر لعدم التوفر."),
                              backgroundColor: AppColors.error,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _showCircleAssignmentDialog(
    BuildContext context,
    TahfeezService tahfeezService,
    TahfeezApplicationModel app,
    String reviewerName,
  ) {
    String selectedCircleId = tahfeezService.circles.first.id;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("تعيين ${app.applicantName} بحلقة:", style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("اختر الحلقة المناسبة لمستوى الطالب:"),
                const SizedBox(height: 12),
                ...tahfeezService.circles.map((c) {
                  return RadioListTile<String>(
                    title: Text(c.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    subtitle: Text(c.scheduleTime, style: const TextStyle(fontSize: 11)),
                    value: c.id,
                    groupValue: selectedCircleId,
                    activeColor: AppColors.primaryEmerald,
                    onChanged: (val) {
                      if (val != null) setState(() => selectedCircleId = val);
                    },
                  );
                }),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("إلغاء"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryEmerald),
                onPressed: () {
                  final circle = tahfeezService.getCircleById(selectedCircleId);
                  tahfeezService.reviewApplication(
                    applicationId: app.id,
                    status: ApplicationStatus.approved,
                    reviewerName: reviewerName,
                    assignedCircleId: selectedCircleId,
                    assignedCircleName: circle?.name ?? 'حلقة الإمام نافع',
                  );
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("تم قبول ${app.applicantName} وإدراجه في ${circle?.name} بنجاح."),
                      backgroundColor: AppColors.primaryEmerald,
                    ),
                  );
                },
                child: const Text("تأكيد القبول والإدراج", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
  }
}
