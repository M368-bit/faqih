import 'package:flutter/material.dart';
import 'package:fakieh_mosque_app/core/constants/app_colors.dart';
import 'package:fakieh_mosque_app/core/constants/quran_data.dart';
import 'package:fakieh_mosque_app/core/theme/text_styles.dart';

class CustomSurahPickerModal extends StatefulWidget {
  final int initialSurahNumber;
  final ValueChanged<SurahInfo> onSurahSelected;

  const CustomSurahPickerModal({
    super.key,
    required this.initialSurahNumber,
    required this.onSurahSelected,
  });

  static Future<SurahInfo?> show(BuildContext context, {int initialSurah = 1}) async {
    return showModalBottomSheet<SurahInfo>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CustomSurahPickerModal(
        initialSurahNumber: initialSurah,
        onSurahSelected: (s) => Navigator.pop(ctx, s),
      ),
    );
  }

  @override
  State<CustomSurahPickerModal> createState() => _CustomSurahPickerModalState();
}

class _CustomSurahPickerModalState extends State<CustomSurahPickerModal> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filtered = QuranData.surahs.where((s) {
      return s.nameAr.contains(_searchQuery) ||
          s.number.toString().contains(_searchQuery) ||
          s.nameEn.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(color: AppColors.gold.withOpacity(0.5), width: 2),
        ),
      ),
      child: Column(
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
                      color: AppColors.primaryEmerald.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.menu_book_rounded, color: AppColors.primaryEmerald, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "فهرس سور القرآن الكريم (114 سورة)",
                    style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Search Box with Islamic Theme
          TextField(
            decoration: InputDecoration(
              hintText: "ابحث برقم أو اسم السورة...",
              prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primaryEmerald),
              filled: true,
              fillColor: isDark ? AppColors.surfaceDark : const Color(0xFFF1F5F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.gold.withOpacity(0.3)),
              ),
            ),
            onChanged: (val) => setState(() => _searchQuery = val.trim()),
          ),

          const SizedBox(height: 14),

          // Scrollable Surah List
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (ctx, i) => const Divider(height: 1),
              itemBuilder: (ctx, index) {
                final surah = filtered[index];
                final isSelected = surah.number == widget.initialSurahNumber;

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  tileColor: isSelected ? AppColors.primaryEmerald.withOpacity(0.1) : null,
                  leading: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryEmerald : AppColors.gold.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.gold.withOpacity(0.5)),
                    ),
                    child: Center(
                      child: Text(
                        "${surah.number}",
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.goldDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    "سورة ${surah.nameAr}",
                    style: AppTextStyles.titleSmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColors.primaryEmerald : null,
                    ),
                  ),
                  subtitle: Text(
                    "${surah.totalVerses} آية • ${surah.nameEn}",
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle_rounded, color: AppColors.primaryEmerald)
                      : null,
                  onTap: () => widget.onSurahSelected(surah),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
