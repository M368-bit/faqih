import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fakieh_mosque_app/core/constants/app_colors.dart';
import 'package:fakieh_mosque_app/core/constants/app_constants.dart';
import 'package:fakieh_mosque_app/core/services/auth_service.dart';
import 'package:fakieh_mosque_app/core/theme/text_styles.dart';
import 'package:fakieh_mosque_app/core/widgets/custom_button.dart';
import 'package:fakieh_mosque_app/core/widgets/glass_card.dart';
import 'package:fakieh_mosque_app/features/home/screens/home_screen.dart';
import 'package:fakieh_mosque_app/features/auth/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),

                // Mosque Brand Icon & Title
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryEmerald.withOpacity(0.12),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryEmerald.withOpacity(0.3)),
                    ),
                    child: const Icon(
                      Icons.mosque_rounded,
                      size: 52,
                      color: AppColors.primaryEmerald,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    AppConstants.appNameAr,
                    style: AppTextStyles.titleLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryEmerald,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "بوابة تسجيل الدخول الموحدة والمؤمنة",
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate),
                  ),
                ),

                const SizedBox(height: 24),

                // Error Banner if present
                if (authService.authError != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.error.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            authService.authError!,
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.error, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                const SizedBox(height: 10),

                // Credentials Inputs
                GlassCard(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "البريد الإلكتروني",
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (v) => v == null || !v.contains('@') ? "يرجى إدخال بريد صالح" : null,
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: "كلمة المرور",
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            ),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                        ),
                        validator: (v) => v == null || v.isEmpty ? "يرجى إدخال كلمة المرور" : null,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                CustomButton(
                  text: "تسجيل الدخول",
                  icon: Icons.login_rounded,
                  isLoading: authService.isLoading,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final success = await authService.signIn(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                      if (success && mounted) {
                        _navigateToHome();
                      }
                    }
                  },
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ليس لديك حساب مسجل؟", style: AppTextStyles.bodySmall),
                    TextButton(
                      child: Text(
                        "إنشاء حساب جديد",
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.primaryEmerald,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
