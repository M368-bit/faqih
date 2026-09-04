import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/mock_data_service.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/glass_card.dart';
import '../models/dhikr_model.dart';

enum AdhkarTimeWindow {
  postPrayer,
  morning,
  evening,
  generalTasbeeh,
}

class AdhkarHubScreen extends StatefulWidget {
  final int initialTabIndex;
  const AdhkarHubScreen({super.key, this.initialTabIndex = 0});

  @override
  State<AdhkarHubScreen> createState() => _AdhkarHubScreenState();
}

class _AdhkarHubScreenState extends State<AdhkarHubScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  // Active Category items
  List<DhikrItem> _currentList = [];
  int _currentSentenceIndex = 0;
  AdhkarTimeWindow _activeWindow = AdhkarTimeWindow.postPrayer;
  String _activeWindowDescription = "";
  Timer? _scheduleCheckTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabController = TabController(length: 4, vsync: this, initialIndex: widget.initialTabIndex);
    
    _evaluateTimeSchedule();
    _scheduleCheckTimer = Timer.periodic(const Duration(minutes: 1), (_) => _evaluateTimeSchedule());

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _onTabChanged(_tabController.index);
      }
    });

    _onTabChanged(_tabController.index);
  }

  @override
  void dispose() {
    _scheduleCheckTimer?.cancel();
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  /// Automatically calculates prayer time window based on current local time
  void _evaluateTimeSchedule() {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;
    final currentMinutes = hour * 60 + minute;

    // Approximate Makkah Prayer Times in minutes from midnight
    final prayerMinutes = [
      {'name': 'الفجر', 'start': 5 * 60 + 8},
      {'name': 'الظهر', 'start': 12 * 60 + 28},
      {'name': 'العصر', 'start': 15 * 60 + 52},
      {'name': 'المغرب', 'start': 18 * 60 + 33},
      {'name': 'العشاء', 'start': 20 * 60 + 3},
    ];

    bool inPostPrayer = false;
    String matchedPrayer = "";

    for (var p in prayerMinutes) {
      final start = p['start'] as int;
      if (currentMinutes >= start && currentMinutes <= start + 30) {
        inPostPrayer = true;
        matchedPrayer = p['name'] as String;
        break;
      }
    }

    setState(() {
      if (inPostPrayer) {
        _activeWindow = AdhkarTimeWindow.postPrayer;
        _activeWindowDescription = "أذكار بعد صلاة $matchedPrayer (متاحة لمدة 30 دقيقة بعد الأذان)";
      } else if (currentMinutes >= 5 * 60 && currentMinutes < 12 * 60) {
        _activeWindow = AdhkarTimeWindow.morning;
        _activeWindowDescription = "أذكار الصباح المباركة (من طلوع الفجر حتى الزوال)";
      } else if (currentMinutes >= 15 * 60 + 30 && currentMinutes < 23 * 60 + 59) {
        _activeWindow = AdhkarTimeWindow.evening;
        _activeWindowDescription = "أذكار المساء وحصن المسلم (من العصر حتى نهاية الليل)";
      } else {
        _activeWindow = AdhkarTimeWindow.generalTasbeeh;
        _activeWindowDescription = "التسابيح العامة والأذكار المطلقة";
      }
    });
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentSentenceIndex = 0;
      switch (index) {
        case 0:
          // Intelligent Auto Window
          if (_activeWindow == AdhkarTimeWindow.postPrayer) {
            _currentList = MockDataService.postPrayerAdhkar;
          } else if (_activeWindow == AdhkarTimeWindow.morning) {
            _currentList = MockDataService.morningAdhkar;
          } else if (_activeWindow == AdhkarTimeWindow.evening) {
            _currentList = MockDataService.eveningAdhkar;
          } else {
            _currentList = MockDataService.tasbeehAdhkar;
          }
          break;
        case 1:
          _currentList = MockDataService.postPrayerAdhkar;
          break;
        case 2:
          _currentList = MockDataService.morningAdhkar;
          break;
        case 3:
          _currentList = MockDataService.eveningAdhkar;
          break;
      }
    });

    if (_pageController.hasClients) {
      _pageController.jumpToPage(0);
    }
  }

  void _handleDhikrCompleted(int index) {
    HapticFeedback.mediumImpact();
    // Auto-advance to the next sentence if not last
    if (index < _currentList.length - 1) {
      Future.delayed(const Duration(milliseconds: 380), () {
        if (mounted && _pageController.hasClients) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeInOutCubic,
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("هنيئاً لك! أتممت هذا الورد المبارك وتقبل الله طاعتكم."),
          backgroundColor: AppColors.primaryEmerald,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("الأذكار وحصن المسلم"),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppColors.primaryEmerald,
          unselectedLabelColor: AppColors.slate,
          indicatorColor: AppColors.primaryEmerald,
          tabs: const [
            Tab(icon: Icon(Icons.auto_awesome_rounded, size: 18), text: "الجدول الذكي"),
            Tab(icon: Icon(Icons.mosque_outlined, size: 18), text: "بعد الصلاة"),
            Tab(icon: Icon(Icons.wb_sunny_outlined, size: 18), text: "أذكار الصباح"),
            Tab(icon: Icon(Icons.nightlight_round, size: 18), text: "أذكار المساء"),
          ],
        ),
      ),
      body: Column(
        children: [
          // Time-window dynamic status banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF13231B) : const Color(0xFFE8F5E9),
              border: Border(
                bottom: BorderSide(color: AppColors.primaryEmerald.withOpacity(0.2)),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.access_time_rounded, size: 18, color: AppColors.primaryEmerald),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _activeWindowDescription,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primaryEmeraldDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "${_currentSentenceIndex + 1} / ${_currentList.length}",
                    style: const TextStyle(
                      color: AppColors.goldDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Linear progress bar across the set
          LinearProgressIndicator(
            value: _currentList.isNotEmpty
                ? (_currentSentenceIndex + 1) / _currentList.length
                : 0.0,
            backgroundColor: AppColors.primaryEmerald.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.gold),
            minHeight: 4,
          ),

          // Step-by-Step Sentence View with interactive Auto-Advancing Counter
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _currentList.length,
              onPageChanged: (index) {
                setState(() => _currentSentenceIndex = index);
              },
              itemBuilder: (context, index) {
                final dhikr = _currentList[index];
                return _buildSentenceCard(dhikr, index, isDark);
              },
            ),
          ),

          // Bottom navigation controls (Previous / Reset / Next)
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0F172A) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, -2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      foregroundColor: AppColors.slateDark,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                    label: const Text("السابق"),
                    onPressed: _currentSentenceIndex > 0
                        ? () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        : null,
                  ),

                  // Reset current dhikr count
                  IconButton(
                    tooltip: "إعادة العداد",
                    icon: const Icon(Icons.refresh_rounded, color: AppColors.slate),
                    onPressed: () {
                      setState(() {
                        _currentList[_currentSentenceIndex].reset();
                      });
                    },
                  ),

                  // Next button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryEmerald,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    label: const Text("التالي", style: TextStyle(fontWeight: FontWeight.bold)),
                    icon: const Icon(Icons.arrow_back_ios_rounded, size: 14),
                    onPressed: _currentSentenceIndex < _currentList.length - 1
                        ? () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentenceCard(DhikrItem dhikr, int index, bool isDark) {
    final progress = dhikr.targetCount > 0
        ? (dhikr.currentCount / dhikr.targetCount).clamp(0.0, 1.0)
        : 0.0;
    final isDone = dhikr.isCompleted;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Main Dhikr Sentence Glass Container
          GlassCard(
            customBorder: Border.all(
              color: isDone
                  ? AppColors.success.withOpacity(0.5)
                  : AppColors.primaryEmerald.withOpacity(0.2),
              width: 1.5,
            ),
            customColor: isDark
                ? (isDone ? const Color(0xFF0D2818) : const Color(0xFF16251E))
                : (isDone ? const Color(0xFFF0FDF4) : Colors.white),
            child: Column(
              children: [
                // Header tag with source
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDone
                            ? AppColors.success.withOpacity(0.15)
                            : AppColors.primaryEmerald.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "الذكر ${index + 1} من ${_currentList.length}",
                        style: TextStyle(
                          color: isDone ? AppColors.success : AppColors.primaryEmerald,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    if (dhikr.source != null)
                      Text(
                        dhikr.source!,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.slate,
                          fontSize: 11,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 18),

                // Beautiful Arabic Dhikr Text
                Text(
                  dhikr.arabicText,
                  style: AppTextStyles.dhikrText.copyWith(
                    height: 2.1,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),

                if (dhikr.reward != null) ...[
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.gold.withOpacity(0.25)),
                    ),
                    child: Text(
                      "⭐ الفضل: ${dhikr.reward}",
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.goldDark,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Interactive Step Counter Button with Auto-Advancing Trigger
          Center(
            child: GestureDetector(
              onTap: () {
                if (!isDone) {
                  setState(() {
                    dhikr.increment();
                  });
                  HapticFeedback.lightImpact();

                  if (dhikr.isCompleted) {
                    _handleDhikrCompleted(index);
                  }
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 170,
                height: 170,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular Progress Track
                    SizedBox(
                      width: 170,
                      height: 170,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 9,
                        backgroundColor: AppColors.primaryEmerald.withOpacity(0.12),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDone ? AppColors.success : AppColors.gold,
                        ),
                      ),
                    ),

                    // Core Button
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: isDone
                            ? const LinearGradient(
                                colors: [Color(0xFF059669), Color(0xFF10B981)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : AppColors.emeraldGlassGradient,
                        boxShadow: [
                          BoxShadow(
                            color: isDone
                                ? AppColors.success.withOpacity(0.4)
                                : AppColors.primaryEmeraldDark.withOpacity(0.35),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isDone) ...[
                            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 38),
                            const SizedBox(height: 4),
                            const Text(
                              "تم بحمد الله",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ] else ...[
                            Text(
                              "${dhikr.currentCount} / ${dhikr.targetCount}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "انقر للعد",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          Center(
            child: Text(
              isDone
                  ? "سيتم الانتقال تلقائياً للذكر التالي..."
                  : "المطلوب: ${dhikr.targetCount} ${dhikr.targetCount > 2 ? 'مرات' : 'مرة'}",
              style: AppTextStyles.bodySmall.copyWith(
                color: isDone ? AppColors.success : AppColors.slate,
                fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

