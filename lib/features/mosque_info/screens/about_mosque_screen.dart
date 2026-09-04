import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/custom_button.dart';

class AboutMosqueScreen extends StatelessWidget {
  const AboutMosqueScreen({super.key});

  Future<void> _openGoogleMaps() async {
    final uri = Uri.parse(AppConstants.googleMapsUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("عن جامع الشيخ عبد القادر فقيه"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mosque Hero Image / Banner
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: AppColors.emeraldGlassGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryEmeraldDark.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.mosque_rounded, size: 90, color: Colors.white24),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConstants.appNameAr,
                          style: AppTextStyles.titleLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "معلم إسلامي ومنارة قرآنية في رحاب مكة المكرمة",
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Key Stats Grid
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.groups_rounded,
                    value: "8,500+",
                    label: "الطاقة الاستيعابية للمصلين",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.menu_book_rounded,
                    value: "12 حلقة",
                    label: "حلقات القرآن والإقراء",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.school_rounded,
                    value: "280+",
                    label: "طالب تحفيظ نشط",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.location_on_rounded,
                    value: "مكة المكرمة",
                    label: "العزيزية / طريق الهدا",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // History and Description
            Text(
              "نبذة عن الجامع ومرافقه:",
              style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GlassCard(
              child: Text(
                "يُعد جامع الشيخ عبد القادر فقيه -رحمه الله- من أبرز الجوامع والصروح الدعوية والقرآنية في مكة المكرمة. يجمع تصميمه المعماري بين الأصالة الإسلامية وأحدث التقنيات الذكية لخدمة ضيوف الرحمن وأهالي مكة المكرمة.\n\nيشتمل الجامع على مصلى رئيسي فسيح، مصلى متكامل ومستقل للنساء، مقرأة إلكترونية لتحفيظ القرآن الكريم وتدريس القراءات، مكتبة إسلامية عامرة، وقاعات مجهزة للندوات والمحاضرات.",
                style: AppTextStyles.bodyMedium.copyWith(height: 1.8),
              ),
            ),

            const SizedBox(height: 20),

            // Facilities checklist
            Text(
              "الخدمات والمرافق المتاحة:",
              style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildFacilityRow(Icons.ac_unit_rounded, "أنظمة تكييف مركزي متطورة لضمان راحة المصلين"),
            _buildFacilityRow(Icons.volume_up_rounded, "نظام صوتي رقمي عالي النقاء متصل بالمآذن والقاعات"),
            _buildFacilityRow(Icons.accessible_rounded, "مسارات ومصاعد مخصصة لذوي الإعاقة وكبار السن"),
            _buildFacilityRow(Icons.local_parking_rounded, "مواقف سيارات فسيحة تتسع لأكثر من 500 مركبة"),

            const SizedBox(height: 24),

            // Google Maps Button
            CustomButton(
              text: "فتح موقع الجامع في خرائط Google",
              icon: Icons.map_rounded,
              isGold: true,
              onPressed: _openGoogleMaps,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({required IconData icon, required String value, required String label}) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.goldDark, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryEmerald,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primaryEmerald.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primaryEmerald, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: AppTextStyles.bodyMedium)),
        ],
      ),
    );
  }
}
