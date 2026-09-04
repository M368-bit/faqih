import 'dart:ui';
import 'package:flutter/material.dart';

/// Minimalist Vector Line-Art Painter for جامع الشيخ عبد القادر فقيه
/// Accurately derived from the mosque's real architectural silhouette:
/// - Tall slender minaret on the left with balcony, windows, and crescent finial
/// - Grand central hemispherical dome on the right with drum window row
/// - Elegant arched colonnade base facade
class MosqueVectorPainter extends CustomPainter {
  final double animationProgress; // 0.0 to 1.0 (Progressive stroke drawing)
  final Color strokeColor;
  final double strokeWidth;
  final bool fillInterior;

  const MosqueVectorPainter({
    required this.animationProgress,
    this.strokeColor = const Color(0xFF0F172A), // Crisp minimalist black/slate
    this.strokeWidth = 2.4,
    this.fillInterior = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Define standard normalization scale (100 x 100 viewBox)
    final scaleX = w / 100.0;
    final scaleY = h / 100.0;

    final completePath = Path();

    // ==========================================
    // 1. LEFT MINARET (المئذنة الشامخة على اليسار)
    // ==========================================
    // Minaret Crescent Finial (الهلال في القمة)
    completePath.moveTo(22 * scaleX, 5 * scaleY);
    completePath.cubicTo(23.5 * scaleX, 3 * scaleY, 23.5 * scaleX, 1 * scaleY, 22 * scaleX, 0.5 * scaleY);
    completePath.cubicTo(20.5 * scaleX, 1 * scaleY, 20.5 * scaleX, 3 * scaleY, 22 * scaleX, 5 * scaleY);

    // Minaret Crescent Pole & Domelet Cap
    completePath.moveTo(22 * scaleX, 5 * scaleY);
    completePath.lineTo(22 * scaleX, 9 * scaleY);
    completePath.moveTo(18 * scaleX, 13 * scaleY);
    completePath.quadraticBezierTo(22 * scaleX, 8.5 * scaleY, 26 * scaleX, 13 * scaleY);
    completePath.lineTo(18 * scaleX, 13 * scaleY);

    // Minaret Pavilion Posts
    completePath.moveTo(19 * scaleX, 13 * scaleY);
    completePath.lineTo(19 * scaleX, 17 * scaleY);
    completePath.moveTo(22 * scaleX, 13 * scaleY);
    completePath.lineTo(22 * scaleX, 17 * scaleY);
    completePath.moveTo(25 * scaleX, 13 * scaleY);
    completePath.lineTo(25 * scaleX, 17 * scaleY);

    // Balcony Base
    completePath.moveTo(16 * scaleX, 17 * scaleY);
    completePath.lineTo(28 * scaleX, 17 * scaleY);
    completePath.lineTo(26 * scaleX, 21 * scaleY);
    completePath.lineTo(18 * scaleX, 21 * scaleY);
    completePath.close();

    // Minaret Shaft Walls (Connecting into the Facade Box)
    completePath.moveTo(18 * scaleX, 21 * scaleY);
    completePath.lineTo(18 * scaleX, 64 * scaleY);
    completePath.moveTo(26 * scaleX, 21 * scaleY);
    completePath.lineTo(26 * scaleX, 64 * scaleY);

    // 4 Vertical Minaret Windows
    for (int i = 0; i < 4; i++) {
      final winY = (27 + (i * 9.5)) * scaleY;
      completePath.moveTo(20.5 * scaleX, winY);
      completePath.lineTo(23.5 * scaleX, winY);
      completePath.lineTo(23.5 * scaleX, winY + 5.5 * scaleY);
      completePath.lineTo(20.5 * scaleX, winY + 5.5 * scaleY);
      completePath.close();
    }

    // ==========================================
    // 2. GRAND CENTRAL DOME (القبة الكروية الضخمة ورقبتها)
    // ==========================================
    // Dome Crescent Finial
    completePath.moveTo(70 * scaleX, 31 * scaleY);
    completePath.cubicTo(71.5 * scaleX, 29 * scaleY, 71.5 * scaleX, 27 * scaleY, 70 * scaleX, 26 * scaleY);
    completePath.cubicTo(68.5 * scaleX, 27 * scaleY, 68.5 * scaleX, 29 * scaleY, 70 * scaleX, 31 * scaleY);

    // Connecting Rod between Crescent and Dome
    completePath.moveTo(70 * scaleX, 31 * scaleY);
    completePath.lineTo(70 * scaleX, 38 * scaleY);

    // Main Hemispherical Dome Arc
    completePath.moveTo(38 * scaleX, 60 * scaleY);
    completePath.cubicTo(40 * scaleX, 35 * scaleY, 96 * scaleX, 35 * scaleY, 98 * scaleX, 60 * scaleY);

    // Dome Drum Base Ring
    completePath.moveTo(36 * scaleX, 60 * scaleY);
    completePath.lineTo(100 * scaleX, 60 * scaleY);
    completePath.lineTo(99 * scaleX, 64 * scaleY);
    completePath.lineTo(37 * scaleX, 64 * scaleY);
    completePath.close();

    // Dome Drum Windows (Slits)
    for (int j = 0; j < 8; j++) {
      final drumWinX = (42 + (j * 7)) * scaleX;
      completePath.moveTo(drumWinX, 61 * scaleY);
      completePath.lineTo(drumWinX + 3 * scaleX, 61 * scaleY);
      completePath.lineTo(drumWinX + 3 * scaleX, 63 * scaleY);
      completePath.lineTo(drumWinX, 63 * scaleY);
      completePath.close();
    }

    // ==========================================
    // 3. ENCLOSED RECTANGULAR FACADE BOX & ARCHES (الهيكل الصندوقي للأقواس حسب الصورة)
    // ==========================================
    // Outer Enclosing Box (إطار الحواف المستطيل الكامل للواجهة)
    // Left vertical border
    completePath.moveTo(12 * scaleX, 64 * scaleY);
    completePath.lineTo(12 * scaleX, 94 * scaleY);

    // Top beam left of minaret
    completePath.moveTo(12 * scaleX, 64 * scaleY);
    completePath.lineTo(18 * scaleX, 64 * scaleY);

    // Top beam right of minaret across the entire facade
    completePath.moveTo(26 * scaleX, 64 * scaleY);
    completePath.lineTo(102 * scaleX, 64 * scaleY);

    // Right vertical border
    completePath.moveTo(102 * scaleX, 64 * scaleY);
    completePath.lineTo(102 * scaleX, 94 * scaleY);

    // Bottom baseline
    completePath.moveTo(10 * scaleX, 94 * scaleY);
    completePath.lineTo(104 * scaleX, 94 * scaleY);

    // Series of 7 Inner Arches enclosed within the box (صفوف الأقواس الداخلية)
    final archPositions = [14.0, 20.0, 31.0, 42.0, 53.0, 64.0, 75.0, 86.0];
    for (int k = 0; k < archPositions.length; k++) {
      final ax = archPositions[k] * scaleX;
      final aw = (k < 2 ? 5.5 : 8.5) * scaleX;
      final topY = 70 * scaleY;
      final botY = 94 * scaleY;

      completePath.moveTo(ax, botY);
      completePath.lineTo(ax, topY + 4 * scaleY);
      completePath.quadraticBezierTo(ax + (aw / 2), topY, ax + aw, topY + 4 * scaleY);
      completePath.lineTo(ax + aw, botY);
    }

    // ==========================================
    // 4. ANIMATED PATH EXTRACTION (تتبع المسار التدريجي)
    // ==========================================
    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    if (animationProgress <= 0.0) return;

    if (animationProgress >= 1.0) {
      canvas.drawPath(completePath, strokePaint);
      return;
    }

    // Measure total path metrics and extract the drawn proportion
    final animatedPath = Path();
    for (final metric in completePath.computeMetrics()) {
      final targetLength = metric.length * animationProgress;
      animatedPath.addPath(metric.extractPath(0.0, targetLength), Offset.zero);
    }

    canvas.drawPath(animatedPath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant MosqueVectorPainter oldDelegate) {
    return oldDelegate.animationProgress != animationProgress ||
        oldDelegate.strokeColor != strokeColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
