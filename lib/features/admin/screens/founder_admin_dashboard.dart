import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/tahfeez_service.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/glass_card.dart';
import 'user_management_screen.dart';
import '../../features/auth/models/user_model.dart';
import '../../features/prayer_times/screens/sheikh_prayer_override_sheet.dart';
import '../../features/tahfeez/screens/applications_review_screen.dart';

class FounderAdminDashboard extends StatelessWidget {
  const FounderAdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final tahfeezService = Provider.of<TahfeezService>(context);

    final totalUsers = authService.users.length;
    final totalStudents = authService.users.where((u) => u.role == UserRole.student).length;
    final totalTeachers = authService.users.where((u) => u.role == UserRole.quranTeacher).length;
    final pendingApps = tahfeezService.applications.where((a) => a.status.name == 'pending').length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة تحكم مؤسس التطبيق"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Admin Hero
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF064E3B), Color(0xFF0F2620)],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.gold.withOpacity(0.4)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.admin_panel_settings_rounded, color: AppColors.goldLight, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "مركز إدارة جامع فقيه",
                          style: AppTextStyles.titleMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "صلاحيات كاملة لإدارة المستخدمين، الحلقات، والمواقيت.",
                          style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Stats Grid
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard("المستخدمون", "$totalUsers مستخدم", Icons.people_outline_rounded, AppColors.primaryEmerald),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricCard("الطلاب", "$totalStudents طالب", Icons.school_outlined, AppColors.goldDark),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard("المعلمون", "$totalTeachers معلمين", Icons.menu_book_outlined, AppColors.info),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricCard("طلبات التقديم", "$pendingApps معلقة", Icons.pending_actions_rounded, AppColors.warning),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              "الوصول السريع للعمليات الإدارية:",
              style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Action 1: User Management
            _buildActionTile(
              icon: Icons.manage_accounts_rounded,
              title: "إدارة المستخدمين والأدوار (RBAC)",
              subtitle: "تعديل صلاحيات 1,000+ مستخدم، ترقية المعلمين والشيوخ",
              color: AppColors.primaryEmerald,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UserManagementScreen()),
                );
              },
            ),

            const SizedBox(height: 10),

            // Action 2: Tahfeez Applications
            _buildActionTile(
              icon: Icons.how_to_reg_rounded,
              title: "مراجعة طلبات التحفيظ والقبول",
              subtitle: "$pendingApps طلبات بحاجة إلى اعتماد أو فرز للحلقات",
              color: AppColors.goldDark,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
                      appBar: AppBar(title: const Text("مراجعة طلبات الالتحاق")),
                      body: const ApplicationsReviewScreen(),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            // Action 3: Prayer Times Override
            _buildActionTile(
              icon: Icons.edit_calendar_rounded,
              title: "تعديل مواقيت الصلاة والإقامة",
              subtitle: "ضبط يدوي لمواقيت الأذان وتوقيت الإقامة بالجامع",
              color: AppColors.info,
              onTap: () {
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
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold, color: color)),
          Text(title, style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate)),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GlassCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate, fontSize: 11)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.slate),
        ],
      ),
    );
  }
}
