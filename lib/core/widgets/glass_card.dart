import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? customColor;
  final Border? customBorder;
  final VoidCallback? onTap;
  final double blurAmount;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 20.0,
    this.customColor,
    this.customBorder,
    this.onTap,
    this.blurAmount = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultBgColor = isDark
        ? (customColor ?? AppColors.cardDark.withOpacity(0.75))
        : (customColor ?? Colors.white.withOpacity(0.85));

    final defaultBorder = customBorder ??
        Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : AppColors.primaryEmerald.withOpacity(0.08),
          width: 1.2,
        );

    Widget cardContent = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: defaultBgColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: defaultBorder,
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : AppColors.primaryEmerald.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      cardContent = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: cardContent,
      );
    }

    if (margin != null) {
      return Padding(
        padding: margin!,
        child: cardContent,
      );
    }

    return cardContent;
  }
}
