import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/tahfeez_service.dart';
import '../../core/theme/text_styles.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/custom_button.dart';
import '../models/tahfeez_models.dart';

class TahfeezApplyScreen extends StatefulWidget {
  const TahfeezApplyScreen({super.key});

  @override
  State<TahfeezApplyScreen> createState() => _TahfeezApplyScreenState();
}

class _TahfeezApplyScreenState extends State<TahfeezApplyScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _ageController;
  late TextEditingController _notesController;

  int _memorizedAjzaa = 5;
  String _selectedLevel = "5 أجزاء";
  bool _isSubmitting = false;

  final List<int> _quickAjzaaPresets = [0, 1, 3, 5, 7, 10, 15, 17, 20, 25, 30];

  @override
  void initState() {
    super.initState();
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;

    _nameController = TextEditingController(text: user?.name ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
    _ageController = TextEditingController(text: '18');
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final tahfeezService = Provider.of<TahfeezService>(context);
    final currentUser = authService.currentUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final existingApp = tahfeezService.getApplicationForUser(currentUser?.id ?? 'usr_standard');

    return Scaffold(
      appBar: AppBar(
        title: const Text("حلقات تحفيظ القرآن الكريم"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // If already submitted, show Status Card
            if (existingApp != null) ...[
              GlassCard(
                customColor: isDark ? const Color(0xFF16251E) : const Color(0xFFF0FDF4),
                customBorder: Border.all(color: AppColors.primaryEmerald.withOpacity(0.4), width: 1.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "حالة طلب التسجيل بالحلقات",
                      style: AppTextStyles.titleSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryEmerald,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: existingApp.status == ApplicationStatus.pending
                            ? AppColors.warning.withOpacity(0.15)
                            : (existingApp.status == ApplicationStatus.approved
                                ? AppColors.success.withOpacity(0.15)
                                : AppColors.error.withOpacity(0.15)),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: existingApp.status == ApplicationStatus.pending
                              ? AppColors.warning
                              : (existingApp.status == ApplicationStatus.approved
                                  ? AppColors.success
                                  : AppColors.error),
                        ),
                      ),
                      child: Text(
                        existingApp.status.nameAr,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: existingApp.status == ApplicationStatus.pending
                              ? AppColors.goldDark
                              : (existingApp.status == ApplicationStatus.approved
                                  ? AppColors.success
                                  : AppColors.error),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  existingApp.status == ApplicationStatus.approved
                      ? "مرحباً بك ${existingApp.applicantName}، تم قبولك بنجاح في (${existingApp.preferredCircleName}). يرجى متابعة جدول التسميع اليومي."
                      : (existingApp.status == ApplicationStatus.rejected
                          ? "نعتذر لك ${existingApp.applicantName}، الحلقات مكتملة حالياً وتم إدراجك في قائمة الانتظار."
                          : "مرحباً بك ${existingApp.applicantName}، طلبك قيد الفرز من قِبل إدارة التحفيظ وسيتم تحديد الحلقة المناسبة لمستواك."),
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.info_outline_rounded, size: 16, color: AppColors.slate),
                    const SizedBox(width: 6),
                    Text(
                      "تاريخ التقديم: ${existingApp.submissionDate.day}/${existingApp.submissionDate.month}/${existingApp.submissionDate.year} م",
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],

            // Hero Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.emeraldGlassGradient,
                borderRadius: BorderRadius.circular(20),
                border: Border(
                  left: BorderSide(color: AppColors.gold.withOpacity(0.5), width: 2),
                  right: BorderSide(color: AppColors.gold.withOpacity(0.5), width: 2),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "طلب تقديم للتحفيظ",
                          style: AppTextStyles.titleMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "قدّم بياناتك وسيتم فرز وتعيين الحلقة المناسبة لمستواك بواسطة إدارة التحفيظ بجامع فقيه.",
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "استمارة التسجيل في الحلقات القرآنية:",
              style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "الاسم الثلاثي",
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                    validator: (v) => v == null || v.isEmpty ? "يرجى كتابة الاسم" : null,
                  ),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: "رقم الجوال",
                            prefixIcon: Icon(Icons.phone_outlined),
                          ),
                          validator: (v) => v == null || v.isEmpty ? "يرجى كتابة الجوال" : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "العمر",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Flexible Memorization Level Stepper & Quick Chips
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primaryEmerald.withOpacity(0.25)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "مستوى الحفظ الحالي (عدد الأجزاء):",
                              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primaryEmerald.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _memorizedAjzaa == 0
                                    ? "مبتدئ (تأسيس وتلقين)"
                                    : (_memorizedAjzaa == 30
                                        ? "خاتم للقرآن الكريم (30 جزءاً)"
                                        : "$_memorizedAjzaa أجزاء"),
                                style: const TextStyle(
                                  color: AppColors.primaryEmerald,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Stepper row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton.filled(
                              style: IconButton.filledStyleFrom(
                                backgroundColor: AppColors.primaryEmerald.withOpacity(0.15),
                                foregroundColor: AppColors.primaryEmerald,
                              ),
                              icon: const Icon(Icons.remove_rounded),
                              onPressed: _memorizedAjzaa > 0
                                  ? () => setState(() {
                                        _memorizedAjzaa--;
                                        _selectedLevel = _memorizedAjzaa == 0
                                            ? "مبتدئ (تأسيس)"
                                            : (_memorizedAjzaa == 30
                                                ? "خاتم للقرآن الكريم (30 جزءاً)"
                                                : "$_memorizedAjzaa أجزاء");
                                      })
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              "$_memorizedAjzaa",
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryEmerald,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text("جزءاً", style: TextStyle(color: AppColors.slate, fontSize: 13)),
                            const SizedBox(width: 16),
                            IconButton.filled(
                              style: IconButton.filledStyleFrom(
                                backgroundColor: AppColors.primaryEmerald,
                                foregroundColor: Colors.white,
                              ),
                              icon: const Icon(Icons.add_rounded),
                              onPressed: _memorizedAjzaa < 30
                                  ? () => setState(() {
                                        _memorizedAjzaa++;
                                        _selectedLevel = _memorizedAjzaa == 30
                                            ? "خاتم للقرآن الكريم (30 جزءاً)"
                                            : "$_memorizedAjzaa أجزاء";
                                      })
                                  : null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "اختيار سريع:",
                          style: AppTextStyles.labelSmall.copyWith(color: AppColors.slate),
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: _quickAjzaaPresets.map((preset) {
                            final isSelected = _memorizedAjzaa == preset;
                            final label = preset == 0 ? "تأسيس" : (preset == 30 ? "خاتم (30)" : "$preset أجزاء");
                            return ChoiceChip(
                              label: Text(label, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                              selected: isSelected,
                              selectedColor: AppColors.primaryEmerald,
                              labelStyle: TextStyle(color: isSelected ? Colors.white : null),
                              onSelected: (_) {
                                setState(() {
                                  _memorizedAjzaa = preset;
                                  _selectedLevel = preset == 0
                                      ? "مبتدئ (تأسيس)"
                                      : (preset == 30 ? "خاتم للقرآن الكريم (30 جزءاً)" : "$preset أجزاء");
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  TextFormField(
                    controller: _notesController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: "ملاحظات وتفاصيل الحفظ السابق والأوقات المفضلة",
                      hintText: "مثال: حفظت 17 جزءاً، أوقات التفرغ بعد العصر...",
                    ),
                  ),
                  const SizedBox(height: 24),

                  CustomButton(
                    text: existingApp != null ? "تحديث طلب التقديم" : "إرسال طلب الانضمام للحلقة",
                    icon: Icons.send_rounded,
                    isLoading: _isSubmitting,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => _isSubmitting = true);

                        final levelString = _memorizedAjzaa == 0
                            ? "مبتدئ (تأسيس وقراءة)"
                            : (_memorizedAjzaa == 30
                                ? "خاتم للقرآن الكريم (30 جزءاً)"
                                : "$_memorizedAjzaa أجزاء من القرآن الكريم");

                        final application = TahfeezApplicationModel(
                          id: 'app_${DateTime.now().millisecondsSinceEpoch}',
                          applicantId: currentUser?.id ?? 'usr_standard',
                          applicantName: _nameController.text.trim(),
                          phone: _phoneController.text.trim(),
                          email: currentUser?.email ?? 'standard@fakieh-mosque.sa',
                          age: int.tryParse(_ageController.text) ?? 18,
                          currentMemorizationLevel: levelString,
                          preferredCircleId: '', // To be assigned by supervisor upon review
                          preferredCircleName: 'يتم التحديد من قِبل المشرف',
                          notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
                          status: ApplicationStatus.pending,
                          submissionDate: DateTime.now(),
                        );

                        await tahfeezService.submitApplication(application);
                        setState(() => _isSubmitting = false);

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("تم استلام طلبك بنجاح! طلبك قيد المراجعة من قِبل إدارة التحفيظ."),
                              backgroundColor: AppColors.primaryEmerald,
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
