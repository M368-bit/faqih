import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fakieh_mosque_app/core/constants/app_colors.dart';
import 'package:fakieh_mosque_app/core/constants/app_constants.dart';
import 'package:fakieh_mosque_app/core/services/prayer_service.dart';
import 'package:fakieh_mosque_app/core/theme/text_styles.dart';
import 'package:fakieh_mosque_app/core/widgets/custom_button.dart';

class SheikhPrayerOverrideSheet extends StatefulWidget {
  const SheikhPrayerOverrideSheet({super.key});

  @override
  State<SheikhPrayerOverrideSheet> createState() => _SheikhPrayerOverrideSheetState();
}

class _SheikhPrayerOverrideSheetState extends State<SheikhPrayerOverrideSheet> {
  String? _selectedPrayerKey;
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _iqamaDelay = 20;
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final prayerService = Provider.of<PrayerService>(context);
    final schedule = prayerService.schedule;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.tune_rounded, color: AppColors.goldDark, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "تعديل مواقيت الصلاة والإقامة",
                          style: AppTextStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "صلاحية خاصة بشيخ المسجد وإدارة الجامع",
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.slate,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Select Prayer
            Text(
              "اختر الصلاة المراد ضبط وقتها:",
              style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: schedule.prayers.map((prayer) {
                final isSelected = _selectedPrayerKey == prayer.key;
                return ChoiceChip(
                  label: Text("${prayer.nameAr} (${prayer.time})"),
                  selected: isSelected,
                  selectedColor: AppColors.primaryEmerald,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : (isDark ? Colors.white70 : AppColors.textPrimaryLight),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontFamily: 'Tajawal',
                  ),
                  backgroundColor: isDark ? AppColors.surfaceDark : AppColors.backgroundLight,
                  onSelected: (selected) {
                    setState(() {
                      _selectedPrayerKey = selected ? prayer.key : null;
                      if (selected) {
                        _iqamaDelay = prayer.iqamaDelayMinutes;
                        _selectedTime = TimeOfDay.fromDateTime(prayer.dateTime);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            if (_selectedPrayerKey != null) ...[
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 12),

              // Time Picker Trigger
              Text(
                "وقت الأذان:",
                style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime,
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedTime = picked;
                    });
                  }
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.goldLight.withOpacity(0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time_rounded, color: AppColors.goldDark),
                          const SizedBox(width: 10),
                          Text(
                            "${_selectedTime.hourOfPeriod}:${_selectedTime.minute.toString().padLeft(2, '0')} ${_selectedTime.period == DayPeriod.am ? 'ص' : 'م'}",
                            style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        "تغيير الوقت",
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primaryEmerald,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Iqama Delay Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "مدة انتظار الإقامة بعد الأذان:",
                    style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$_iqamaDelay دقيقة",
                    style: AppTextStyles.titleSmall.copyWith(
                      color: AppColors.goldDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Slider(
                value: _iqamaDelay.toDouble(),
                min: 5,
                max: 45,
                divisions: 8,
                activeColor: AppColors.gold,
                inactiveColor: AppColors.slate.withOpacity(0.3),
                label: "$_iqamaDelay دقيقة",
                onChanged: (val) {
                  setState(() {
                    _iqamaDelay = val.round();
                  });
                },
              ),

              const SizedBox(height: 24),

              // Action Buttons
              CustomButton(
                text: "حفظ ونشر التعديل لرواد المسجد",
                icon: Icons.check_circle_outline_rounded,
                isGold: true,
                isLoading: _isSaving,
                onPressed: () async {
                  setState(() => _isSaving = true);
                  final now = DateTime.now();
                  final newDateTime = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    _selectedTime.hour,
                    _selectedTime.minute,
                  );
                  final timeStr =
                      "${_selectedTime.hourOfPeriod}:${_selectedTime.minute.toString().padLeft(2, '0')} ${_selectedTime.period == DayPeriod.am ? 'ص' : 'م'}";

                  await prayerService.overridePrayerTime(
                    prayerKey: _selectedPrayerKey!,
                    newTimeStr: timeStr,
                    newDateTime: newDateTime,
                    sheikhName: "فضيلة الشيخ د. ماهر السلمي",
                  );

                  await prayerService.updateIqamaDelay(
                    prayerKey: _selectedPrayerKey!,
                    delayMinutes: _iqamaDelay,
                    sheikhName: "فضيلة الشيخ د. ماهر السلمي",
                  );

                  setState(() => _isSaving = false);
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("تم تحديث مواقيت الأذان والإقامة لجامع فقيه بنجاح."),
                        backgroundColor: AppColors.primaryEmerald,
                      ),
                    );
                  }
                },
              ),
            ],

            const SizedBox(height: 12),
            CustomButton(
              text: "استعادة مواقيت أم القرى التلقائية",
              isSecondary: true,
              onPressed: () async {
                await prayerService.resetToOfficialCalculation();
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("تمت استعادة مواقيت تقويم أم القرى الافتراضية."),
                      backgroundColor: AppColors.primaryEmerald,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
