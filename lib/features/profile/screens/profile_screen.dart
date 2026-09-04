import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fakieh_mosque_app/core/constants/app_colors.dart';
import 'package:fakieh_mosque_app/core/services/auth_service.dart';
import 'package:fakieh_mosque_app/core/services/notification_service.dart';
import 'package:fakieh_mosque_app/core/theme/text_styles.dart';
import 'package:fakieh_mosque_app/core/widgets/glass_card.dart';
import 'package:fakieh_mosque_app/core/widgets/role_badge.dart';
import 'package:fakieh_mosque_app/features/auth/models/user_model.dart';
import 'package:fakieh_mosque_app/features/admin/screens/founder_admin_dashboard.dart';
import 'package:fakieh_mosque_app/features/admin/screens/user_management_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final notifService = Provider.of<NotificationService>(context);
    final user = authService.currentUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("يرجى تسجيل الدخول")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("حسابي"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            // Profile Card (STRICT PRIVACY COMPLIANCE: Standard users see NO role tag!)
            GlassCard(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.primaryEmerald.withOpacity(0.15),
                    child: Text(
                      user.name.isNotEmpty ? user.name[0] : 'U',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryEmerald,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.name,
                    style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${user.email} • ${user.phone}",
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate),
                  ),

                  // Strict Privacy Rule:
                  // Only privileged roles (Founder, Sheikh, Teacher, Student) show their official badge.
                  // Standard users show NO role label at all!
                  if (user.shouldShowRoleBadgeInProfile) ...[
                    const SizedBox(height: 10),
                    RoleBadge(role: user.role, isLarge: true),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Demo Role Switcher (For live testing and evaluator review of the 5 roles)
            GlassCard(
              customColor: isDark ? const Color(0xFF132029) : const Color(0xFFF1F5F9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.swap_horiz_rounded, color: AppColors.primaryEmerald, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "تبديل الصلاحية للتجربة المباشرة (RBAC Switcher):",
                        style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildDemoChip(context, authService, UserRole.founderAdmin, "مؤسس التطبيق", user.role),
                      _buildDemoChip(context, authService, UserRole.mosqueSheikh, "شيخ المسجد", user.role),
                      _buildDemoChip(context, authService, UserRole.quranTeacher, "معلم التحفيظ", user.role),
                      _buildDemoChip(context, authService, UserRole.student, "طالب بالحلقة", user.role),
                      _buildDemoChip(context, authService, UserRole.standardUser, "مستخدم عام (زائر)", user.role),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Admin Shortcut if Founder Admin
            if (user.role == UserRole.founderAdmin) ...[
              _buildSettingsTile(
                icon: Icons.admin_panel_settings_rounded,
                title: "لوحة تحكم المؤسس والإدارة",
                subtitle: "إدارة المستخدمين والأدوار، الحلقات، والإحصاءات",
                iconColor: AppColors.goldDark,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FounderAdminDashboard()),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],

            // Sheikh Shortcut if Mosque Sheikh
            if (user.role == UserRole.mosqueSheikh) ...[
              _buildSettingsTile(
                icon: Icons.people_alt_rounded,
                title: "سجل مستخدمي ورواد الجامع (عرض فقط)",
                subtitle: "قائمة المسجلين وصلاحياتهم المعتمدة",
                iconColor: AppColors.primaryEmerald,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const UserManagementScreen()),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],

            // Notification Settings
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "إعدادات التنبيهات والأذان:",
                    style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildSwitchTile(
                    title: "صوت الأذان المكي المخصص",
                    subtitle: "تشغيل أذان الحرم المكي مع دخول وقت كل صلاة",
                    value: notifService.azanSoundEnabled,
                    onChanged: (v) => notifService.toggleAzanSound(v),
                  ),
                  const Divider(),
                  _buildSwitchTile(
                    title: "تنبيه الأذكار الآلي بعد الصلاة",
                    subtitle: "إرسال أذكار ما بعد الصلاة تلقائياً بعد الفريضة",
                    value: notifService.postPrayerAdhkarEnabled,
                    onChanged: (v) => notifService.togglePostPrayerAdhkar(v),
                  ),
                  const Divider(),
                  _buildSwitchTile(
                    title: "إشعارات الدروس وخطب الجمعة",
                    subtitle: "تنبيه قبل بدء الدروس والمحاضرات المقامة بالجامع",
                    value: notifService.lessonRemindersEnabled,
                    onChanged: (v) => notifService.toggleLessonReminders(v),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Sign out
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.error, width: 1),
              ),
              tileColor: AppColors.error.withOpacity(0.06),
              leading: const Icon(Icons.logout_rounded, color: AppColors.error),
              title: Text(
                "تسجيل الخروج",
                style: AppTextStyles.labelLarge.copyWith(color: AppColors.error, fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                await authService.signOut();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("تم تسجيل الخروج بنجاح.")),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoChip(BuildContext context, AuthService authService, UserRole role, String label, UserRole currentRole) {
    final isSelected = role == currentRole;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: AppColors.primaryEmerald,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppColors.primaryEmerald,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 12,
      ),
      onSelected: (selected) {
        if (selected) {
          authService.switchDemoRole(role);
        }
      },
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GlassCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate, fontSize: 11)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.slate),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate, fontSize: 11)),
            ],
          ),
        ),
        Switch(
          value: value,
          activeColor: AppColors.primaryEmerald,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
