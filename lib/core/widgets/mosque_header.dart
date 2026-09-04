import 'package:flutter/material.dart';
import '../../features/splash/widgets/mosque_vector_painter.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../theme/text_styles.dart';

/// Mosque Header featuring Kaaba Golden Emblem with Lateral Arched Borders
class MosqueHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? trailing;

  const MosqueHeader({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: isDark
              ? [
                  AppColors.primaryEmeraldDark,
                  AppColors.backgroundDark,
                ]
              : [
                  AppColors.primaryEmerald,
                  AppColors.primaryEmeraldDark,
                ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        // Lateral Arched Borders (حواف ذهبية فخمة من الجوانب)
        border: Border(
          left: BorderSide(color: AppColors.gold.withOpacity(0.5), width: 2),
          right: BorderSide(color: AppColors.gold.withOpacity(0.5), width: 2),
          bottom: BorderSide(color: AppColors.gold.withOpacity(0.6), width: 1.5),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryEmeraldDark.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Mosque Vector Silhouette Emblem in Emerald Arched Container
                Container(
                  width: 54,
                  height: 54,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: const Color(0xFF04382B),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.gold,
                      width: 1.8,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gold.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: CustomPaint(
                      size: const Size(36, 36),
                      painter: const MosqueVectorPainter(
                        animationProgress: 1.0,
                        strokeColor: AppColors.goldAccent,
                        strokeWidth: 2.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? AppConstants.appNameAr,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle ?? AppConstants.appSubtitleAr,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
