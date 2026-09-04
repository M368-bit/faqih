import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/prayer_service.dart';
import '../../core/services/notification_service.dart';
import '../../core/services/tahfeez_service.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/mosque_header.dart';
import '../../core/widgets/prayer_countdown.dart';
import '../auth/models/user_model.dart';
import '../../features/prayer_times/screens/prayer_times_screen.dart';
import '../../features/tahfeez/screens/teacher_dashboard_screen.dart';
import '../../features/tahfeez/screens/student_dashboard_screen.dart';
import '../../features/tahfeez/screens/tahfeez_apply_screen.dart';
import '../../features/adhkar/screens/adhkar_hub_screen.dart';
import '../../features/mosque_info/screens/about_mosque_screen.dart';
import '../../features/lessons_sermons/screens/lessons_screen.dart';
import '../../features/profile/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    // The 5 Tabs
    final List<Widget> pages = [
      _buildHomeTab(context),
      const PrayerTimesScreen(),
      _buildTahfeezTabForRole(user?.role ?? UserRole.standardUser),
      const AdhkarHubScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.surfaceDark
              : Colors.white,
          indicatorColor: AppColors.primaryEmerald.withOpacity(0.15),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded, color: AppColors.primaryEmerald),
              label: 'الرئيسية',
            ),
            NavigationDestination(
              icon: Icon(Icons.access_time_outlined),
              selectedIcon: Icon(Icons.access_time_filled_rounded, color: AppColors.primaryEmerald),
              label: 'المواقيت',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book_rounded, color: AppColors.primaryEmerald),
              label: 'التحفيظ',
            ),
            NavigationDestination(
              icon: Icon(Icons.auto_stories_outlined),
              selectedIcon: Icon(Icons.auto_stories_rounded, color: AppColors.primaryEmerald),
              label: 'الأذكار',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(Icons.person_rounded, color: AppColors.primaryEmerald),
              label: 'حسابي',
            ),
          ],
        ),
      ),
    );
  }

  /// Tahfeez View dynamically selected by Role
  Widget _buildTahfeezTabForRole(UserRole role) {
    switch (role) {
      case UserRole.quranTeacher:
      case UserRole.founderAdmin:
        return const TeacherDashboardScreen();
      case UserRole.student:
        return const StudentDashboardScreen();
      case UserRole.mosqueSheikh:
      case UserRole.standardUser:
      default:
        // Replaces student timetable with Tahfeez application form!
        return const TahfeezApplyScreen();
    }
  }

  Widget _buildHomeTab(BuildContext context) {
    final prayerService = Provider.of<PrayerService>(context);
    final notifService = Provider.of<NotificationService>(context);
    final authService = Provider.of<AuthService>(context);
    final nextPrayer = prayerService.nextPrayer;
    final user = authService.currentUser;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mosque Header
          MosqueHeader(
            trailing: IconButton(
              icon: Icon(
                notifService.isPlayingAudio ? Icons.volume_up_rounded : Icons.volume_mute_rounded,
                color: AppColors.goldAccent,
              ),
              onPressed: () => notifService.playCustomAzanSound(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Prayer Countdown Hero
                PrayerCountdownWidget(
                  nextPrayerName: nextPrayer.nameAr,
                  nextPrayerTime: nextPrayer.time,
                  nextPrayerDateTime: nextPrayer.dateTime,
                  iqamaDelayMinutes: nextPrayer.iqamaDelayMinutes,
                  onPlayAzan: () => notifService.playCustomAzanSound(),
                ),

                const SizedBox(height: 24),

                // Quick Navigation Grid (2026 Sleek Islamic Cards)
                Text(
                  "خدمات جامع فقيه المتاحة:",
                  style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.35,
                  children: [
                    _buildQuickAction(
                      title: "مواقيت الصلاة",
                      subtitle: "تقويم مكة المكرمة",
                      icon: Icons.access_time_filled_rounded,
                      color: AppColors.primaryEmerald,
                      onTap: () => setState(() => _currentIndex = 1),
                    ),
                    _buildQuickAction(
                      title: "حلقات التحفيظ",
                      subtitle: user?.role == UserRole.student ? "واجب الجديد والمراجعة" : "المقرأة القرآنية",
                      icon: Icons.menu_book_rounded,
                      color: AppColors.goldDark,
                      onTap: () => setState(() => _currentIndex = 2),
                    ),
                    _buildQuickAction(
                      title: "أذكار بعد الصلاة",
                      subtitle: "الأذكار والتسبيح الآلي",
                      icon: Icons.auto_stories_rounded,
                      color: const Color(0xFF0D9488),
                      onTap: () => setState(() => _currentIndex = 3),
                    ),
                    _buildQuickAction(
                      title: "الدروس والخطب",
                      subtitle: "المكتبة الصوتية والمرئية",
                      icon: Icons.cast_for_education_rounded,
                      color: const Color(0xFF2563EB),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LessonsScreen()),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Mosque Info Banner
                GlassCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutMosqueScreen()),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primaryEmerald.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.mosque_rounded, color: AppColors.primaryEmerald, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "عن جامع الشيخ عبد القادر فقيه",
                              style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "تعرف على مرافق الجامع، المصلى الرئيسي، وتفاصيل الوصول عبر الخريطة.",
                              style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.slate),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
