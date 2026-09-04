import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fakieh_mosque_app/core/constants/app_colors.dart';
import 'package:fakieh_mosque_app/core/constants/app_constants.dart';
import 'package:fakieh_mosque_app/features/auth/widgets/auth_wrapper.dart';
import 'package:fakieh_mosque_app/features/splash/widgets/mosque_vector_painter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Staged Animation Curves
  late Animation<double> _drawAnimation;
  late Animation<Offset> _iconSlideAnimation;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Total choreographed duration: 2600ms (~2.6 seconds)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );

    // Step 1: Vector Line-Drawing (0.0 -> 0.55)
    _drawAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.55, curve: Curves.easeInOutCubic),
      ),
    );

    // Step 2: Mosque Icon Slide to Right (0.55 -> 0.85)
    _iconSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.35, 0.0), // Slides right to welcome typography in RTL
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 0.85, curve: Curves.easeOutCubic),
      ),
    );

    _iconScaleAnimation = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 0.85, curve: Curves.easeInOut),
      ),
    );

    // Step 3: Arabic Typography "فقيه" Fade & Slide in (0.60 -> 0.90)
    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.60, 0.90, curve: Curves.easeOut),
      ),
    );

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.25, 0.0), // Slides in from left to position next to icon
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.60, 0.90, curve: Curves.easeOutCubic),
      ),
    );

    // Step 4: Auto-navigate to Mandatory Auth Guard upon completion
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToAuthWrapper();
      }
    });

    // Start Animation Sequence
    _controller.forward();
  }

  void _navigateToAuthWrapper() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 650),
        pageBuilder: (context, animation, secondaryAnimation) => const AuthWrapper(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Clean pure white (#FFFFFF)
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Center(
              child: Container(
                width: 370,
                height: 200,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: AppColors.primaryEmerald.withOpacity(0.18),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryEmeraldDark.withOpacity(0.06),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Mosque Vector Line-Art Icon (Traced & Sliding)
                    SlideTransition(
                      position: _iconSlideAnimation,
                      child: ScaleTransition(
                        scale: _iconScaleAnimation,
                        child: CustomPaint(
                          size: const Size(130, 130),
                          painter: MosqueVectorPainter(
                            animationProgress: _drawAnimation.value,
                            strokeColor: const Color(0xFF0F172A), // Crisp black outline
                            strokeWidth: 2.2,
                          ),
                        ),
                      ),
                    ),

                    // Arabic Typography "فقيه" without Tashkeel (Fading & Sliding in next to icon)
                    Positioned(
                      left: 16,
                      child: FadeTransition(
                        opacity: _textFadeAnimation,
                        child: SlideTransition(
                          position: _textSlideAnimation,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    "فقيه",
                                    style: GoogleFonts.cairo(
                                      fontSize: 38,
                                      fontWeight: FontWeight.w900,
                                      color: const Color(0xFF0F172A), // Minimalist Black
                                      letterSpacing: -0.5,
                                      height: 1.1,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Container(
                                    width: 7,
                                    height: 7,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.gold, // Subtle luxury gold accent dot
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "جامع الشيخ عبد القادر فقيه",
                                style: GoogleFonts.tajawal(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryEmerald,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              Text(
                                "مكة المكرمة",
                                style: GoogleFonts.tajawal(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.slate,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
