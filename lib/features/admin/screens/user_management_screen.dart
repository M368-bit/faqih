import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/auth_service.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/glass_card.dart';
import '../../features/auth/models/user_model.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  String _searchQuery = '';
  UserRole? _filterRole;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final isFounder = authService.currentUser?.role == UserRole.founderAdmin;

    final filteredUsers = authService.users.where((u) {
      final matchesSearch = u.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          u.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          u.phone.contains(_searchQuery);
      final matchesRole = _filterRole == null || u.role == _filterRole;
      return matchesSearch && matchesRole;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("إدارة المستخدمين والصلاحيات"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            // Search field
            TextField(
              decoration: InputDecoration(
                hintText: "ابحث بالاسم، البريد أو رقم الجوال...",
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
            const SizedBox(height: 12),

            // Role Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text("الكل"),
                    selected: _filterRole == null,
                    onSelected: (s) => setState(() => _filterRole = null),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text("المؤسس"),
                    selected: _filterRole == UserRole.founderAdmin,
                    onSelected: (s) => setState(() => _filterRole = s ? UserRole.founderAdmin : null),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text("الشيخ"),
                    selected: _filterRole == UserRole.mosqueSheikh,
                    onSelected: (s) => setState(() => _filterRole = s ? UserRole.mosqueSheikh : null),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text("المعلمون"),
                    selected: _filterRole == UserRole.quranTeacher,
                    onSelected: (s) => setState(() => _filterRole = s ? UserRole.quranTeacher : null),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text("الطلاب"),
                    selected: _filterRole == UserRole.student,
                    onSelected: (s) => setState(() => _filterRole = s ? UserRole.student : null),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text("المستخدمون العامون"),
                    selected: _filterRole == UserRole.standardUser,
                    onSelected: (s) => setState(() => _filterRole = s ? UserRole.standardUser : null),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Users List
            Expanded(
              child: ListView.separated(
                itemCount: filteredUsers.length,
                separatorBuilder: (ctx, i) => const SizedBox(height: 10),
                itemBuilder: (ctx, index) {
                  final user = filteredUsers[index];

                  return GlassCard(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.primaryEmerald.withOpacity(0.12),
                              child: Text(
                                user.name.isNotEmpty ? user.name[0] : 'U',
                                style: const TextStyle(color: AppColors.primaryEmerald, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${user.email} • ${user.phone}",
                                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate, fontSize: 11),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Role Selector for Founder Admin
                        if (isFounder)
                          DropdownButton<UserRole>(
                            value: user.role,
                            underline: const SizedBox(),
                            icon: const Icon(Icons.arrow_drop_down_rounded, color: AppColors.primaryEmerald),
                            items: const [
                              DropdownMenuItem(value: UserRole.founderAdmin, child: Text("مؤسس التطبيق", style: TextStyle(fontSize: 12))),
                              DropdownMenuItem(value: UserRole.mosqueSheikh, child: Text("شيخ المسجد", style: TextStyle(fontSize: 12))),
                              DropdownMenuItem(value: UserRole.quranTeacher, child: Text("معلم التحفيظ", style: TextStyle(fontSize: 12))),
                              DropdownMenuItem(value: UserRole.student, child: Text("طالب", style: TextStyle(fontSize: 12))),
                              DropdownMenuItem(value: UserRole.standardUser, child: Text("مستخدم عام", style: TextStyle(fontSize: 12))),
                            ],
                            onChanged: (newRole) {
                              if (newRole != null) {
                                authService.updateUserRole(user.id, newRole);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("تم تعديل صلاحية ${user.name} بنجاح."),
                                    backgroundColor: AppColors.primaryEmerald,
                                  ),
                                );
                              }
                            },
                          )
                        else
                          Text(
                            user.role.roleNameAr.isNotEmpty ? user.role.roleNameAr : "مستخدم عام",
                            style: AppTextStyles.labelSmall.copyWith(color: AppColors.slateDark, fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
