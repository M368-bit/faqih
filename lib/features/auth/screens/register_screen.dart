import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fakieh_mosque_app/core/constants/app_colors.dart';
import 'package:fakieh_mosque_app/core/constants/app_constants.dart';
import 'package:fakieh_mosque_app/core/services/auth_service.dart';
import 'package:fakieh_mosque_app/core/theme/text_styles.dart';
import 'package:fakieh_mosque_app/core/utils/password_validator.dart';
import 'package:fakieh_mosque_app/core/widgets/custom_button.dart';
import 'package:fakieh_mosque_app/core/widgets/glass_card.dart';
import 'package:fakieh_mosque_app/features/home/screens/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  PasswordStrength _passwordStrength = PasswordStrength.weak;
  List<String> _passwordErrors = [];

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkPasswordStrength);
  }

  void _checkPasswordStrength() {
    final result = PasswordValidator.validate(_passwordController.text);
    setState(() {
      _passwordStrength = result.strength;
      _passwordErrors = result.errorsAr;
    });
  }

  @override
  void dispose() {
    _passwordController.removeListener(_checkPasswordStrength);
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("إنشاء حساب آمن"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "انضم إلى منصة جامع الشيخ عبد القادر فقيه",
                  style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  "تسجيل حساب جديد مع حماية التشفير وسياسة كلمة المرور الصارمة",
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                // One-Tap Social Options
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          side: const BorderSide(color: AppColors.borderLight),
                        ),
                        icon: const Icon(Icons.g_mobiledata_rounded, color: Colors.red, size: 22),
                        label: const Text("Google", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                        onPressed: () async {
                          final success = await authService.signInWithGoogle();
                          if (success && mounted) _navigateToHome();
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        icon: const Icon(Icons.apple_rounded, size: 20),
                        label: const Text("Apple", style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          final success = await authService.signInWithApple();
                          if (success && mounted) _navigateToHome();
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                GlassCard(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: "الاسم الكامل",
                          prefixIcon: Icon(Icons.person_outline_rounded),
                        ),
                        validator: (v) => v == null || v.trim().length < 3 ? "يرجى كتابة الاسم الثلاثي" : null,
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: "رقم الجوال",
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                        validator: (v) => v == null || v.trim().length < 9 ? "يرجى إدخال رقم جوال صحيح" : null,
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "البريد الإلكتروني",
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (v) => v == null || !v.contains('@') ? "بريد إلكتروني غير صالح" : null,
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: "كلمة المرور المشفرة",
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            ),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return "يرجى إدخال كلمة المرور";
                          final res = PasswordValidator.validate(v);
                          return res.isValid ? null : res.errorsAr.first;
                        },
                      ),

                      if (_passwordController.text.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        // Password Strength Visual Indicator
                        _buildStrengthMeter(),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                CustomButton(
                  text: "إنشاء الحساب الآمن",
                  icon: Icons.shield_rounded,
                  isLoading: authService.isLoading,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final success = await authService.register(
                        name: _nameController.text.trim(),
                        email: _emailController.text.trim(),
                        phone: _phoneController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                      if (success && mounted) {
                        _navigateToHome();
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStrengthMeter() {
    Color barColor;
    String labelText;
    double progress;

    switch (_passwordStrength) {
      case PasswordStrength.weak:
        barColor = AppColors.error;
        labelText = "ضعيفة (يجب استيفاء شروط الأمان)";
        progress = 0.25;
        break;
      case PasswordStrength.medium:
        barColor = AppColors.warning;
        labelText = "متوسطة (أضف رموزاً خاصة)";
        progress = 0.55;
        break;
      case PasswordStrength.strong:
        barColor = AppColors.primaryEmeraldLight;
        labelText = "قوية ✓";
        progress = 0.85;
        break;
      case PasswordStrength.veryStrong:
        barColor = AppColors.success;
        labelText = "ممتازة وفائقة الأمان ✓✓";
        progress = 1.0;
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("مستوى قوة كلمة المرور:", style: AppTextStyles.labelSmall.copyWith(color: AppColors.slate)),
            Text(labelText, style: AppTextStyles.labelSmall.copyWith(color: barColor, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.slate.withOpacity(0.15),
          valueColor: AlwaysStoppedAnimation<Color>(barColor),
          borderRadius: BorderRadius.circular(6),
        ),
      ],
    );
  }
}
