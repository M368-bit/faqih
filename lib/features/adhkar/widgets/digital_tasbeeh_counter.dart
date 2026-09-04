import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fakieh_mosque_app/core/constants/app_colors.dart';
import 'package:fakieh_mosque_app/core/theme/text_styles.dart';

class DigitalTasbeehCounter extends StatefulWidget {
  final int targetCount;
  final int initialCount;
  final ValueChanged<int>? onCountChanged;
  final VoidCallback? onCompleted;

  const DigitalTasbeehCounter({
    super.key,
    required this.targetCount,
    this.initialCount = 0,
    this.onCountChanged,
    this.onCompleted,
  });

  @override
  State<DigitalTasbeehCounter> createState() => _DigitalTasbeehCounterState();
}

class _DigitalTasbeehCounterState extends State<DigitalTasbeehCounter> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialCount;
  }

  void _increment() {
    if (_count < widget.targetCount) {
      HapticFeedback.lightImpact();
      setState(() {
        _count++;
      });
      widget.onCountChanged?.call(_count);
      if (_count >= widget.targetCount) {
        HapticFeedback.mediumImpact();
        widget.onCompleted?.call();
      }
    }
  }

  void _reset() {
    HapticFeedback.selectionClick();
    setState(() {
      _count = 0;
    });
    widget.onCountChanged?.call(0);
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.targetCount > 0 ? (_count / widget.targetCount).clamp(0.0, 1.0) : 0.0;
    final isDone = _count >= widget.targetCount;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: isDone ? null : _increment,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Circular Progress indicator
                SizedBox(
                  width: 140,
                  height: 140,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor: AppColors.primaryEmerald.withOpacity(0.12),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isDone ? AppColors.success : AppColors.gold,
                    ),
                  ),
                ),
                // Inner button
                Container(
                  width: 115,
                  height: 115,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isDone
                        ? const LinearGradient(
                            colors: [Color(0xFF059669), Color(0xFF10B981)],
                          )
                        : AppColors.emeraldGlassGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryEmeraldDark.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$_count / ${widget.targetCount}",
                        style: AppTextStyles.titleLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isDone ? "تم بحمد الله" : "انقر للتسبيح",
                        style: AppTextStyles.labelSmall.copyWith(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          IconButton(
            tooltip: "إعادة تعيين العداد",
            onPressed: _reset,
            icon: const Icon(Icons.refresh_rounded, color: AppColors.slate),
          ),
        ],
      ),
    );
  }
}
