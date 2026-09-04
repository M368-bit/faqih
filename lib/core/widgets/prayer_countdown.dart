import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fakieh_mosque_app/core/constants/app_colors.dart';
import 'package:fakieh_mosque_app/core/theme/text_styles.dart';

class PrayerCountdownWidget extends StatefulWidget {
  final String nextPrayerName;
  final String nextPrayerTime;
  final DateTime nextPrayerDateTime;
  final int iqamaDelayMinutes;
  final VoidCallback? onPlayAzan;

  const PrayerCountdownWidget({
    super.key,
    required this.nextPrayerName,
    required this.nextPrayerTime,
    required this.nextPrayerDateTime,
    this.iqamaDelayMinutes = 20,
    this.onPlayAzan,
  });

  @override
  State<PrayerCountdownWidget> createState() => _PrayerCountdownWidgetState();
}

class _PrayerCountdownWidgetState extends State<PrayerCountdownWidget> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _updateRemaining();
        });
      }
    });
  }

  void _updateRemaining() {
    final now = DateTime.now();
    final diff = widget.nextPrayerDateTime.difference(now);
    // Never show negative values — clamp to zero
    _remaining = diff.isNegative ? Duration.zero : diff;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hours = _remaining.inHours;
    final minutes = _remaining.inMinutes.remainder(60);
    final seconds = _remaining.inSeconds.remainder(60);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: isDark
              ? [
                  const Color(0xFF0F2620),
                  const Color(0xFF071512),
                ]
              : [
                  AppColors.primaryEmerald,
                  AppColors.primaryEmeraldDark,
                ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryEmeraldDark.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.goldLight,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      "الصلاة القادمة بمكة",
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.goldAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              if (widget.onPlayAzan != null)
                InkWell(
                  onTap: widget.onPlayAzan,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.volume_up_rounded, color: AppColors.goldAccent, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          "أذان الحرم",
                          style: AppTextStyles.labelSmall.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "صلاة ${widget.nextPrayerName}",
                    style: AppTextStyles.displayMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.access_time_filled_rounded, color: AppColors.goldAccent, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        widget.nextPrayerTime,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.goldAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "الإقامة بعد ${widget.iqamaDelayMinutes} د",
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Remaining Countdown Digits
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        "${_formatDigits(hours)}:${_formatDigits(minutes)}:${_formatDigits(seconds)}",
                        style: AppTextStyles.titleLarge.copyWith(
                          color: Colors.white,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "الوقت المتبقي لرفع الأذان",
                      style: AppTextStyles.labelSmall.copyWith(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
