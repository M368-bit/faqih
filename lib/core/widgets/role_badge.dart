import 'package:flutter/material.dart';
import '../../features/auth/models/user_model.dart';
import '../constants/app_colors.dart';
import '../theme/text_styles.dart';

class RoleBadge extends StatelessWidget {
  final UserRole role;
  final bool isLarge;

  const RoleBadge({
    super.key,
    required this.role,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    // Strict Privacy Rule: Standard users NEVER have a role badge shown anywhere!
    if (role == UserRole.standardUser) {
      return const SizedBox.shrink();
    }

    Color bgColor;
    Color textColor;
    IconData icon;
    String label = role.roleNameAr;

    switch (role) {
      case UserRole.founderAdmin:
        bgColor = AppColors.gold.withOpacity(0.15);
        textColor = AppColors.goldDark;
        icon = Icons.verified_user_rounded;
        break;
      case UserRole.mosqueSheikh:
        bgColor = AppColors.primaryEmerald.withOpacity(0.15);
        textColor = AppColors.primaryEmerald;
        icon = Icons.menu_book_rounded;
        break;
      case UserRole.quranTeacher:
        bgColor = const Color(0xFF2563EB).withOpacity(0.15);
        textColor = const Color(0xFF1D4ED8);
        icon = Icons.school_rounded;
        break;
      case UserRole.student:
        bgColor = const Color(0xFF059669).withOpacity(0.15);
        textColor = const Color(0xFF047857);
        icon = Icons.person_rounded;
        break;
      case UserRole.standardUser:
        return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLarge ? 14 : 10,
        vertical: isLarge ? 8 : 4,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: textColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isLarge ? 18 : 14,
            color: textColor,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: (isLarge ? AppTextStyles.labelLarge : AppTextStyles.labelSmall).copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
