import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/auth_service.dart';
import '../../home/screens/home_screen.dart';
import '../screens/login_screen.dart';

/// Mandatory Authentication Gatekeeper
/// Strictly prevents unauthenticated users from accessing the mosque dashboard.
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    // If authentication is loading or validating hardware session
    if (authService.isLoading && authService.currentUser == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryEmerald,
            strokeWidth: 2.5,
          ),
        ),
      );
    }

    // Strict Enforcement: If unauthenticated, rigidly force Login Screen
    if (!authService.isAuthenticated || authService.currentUser == null) {
      return const LoginScreen();
    }

    // Authenticated: Route directly to Mosque Dashboard
    return const HomeScreen();
  }
}
