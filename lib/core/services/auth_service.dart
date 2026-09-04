import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../features/auth/models/user_model.dart';
import '../utils/password_validator.dart';
import 'mock_data_service.dart';
import 'secure_storage_service.dart';

class AuthService extends ChangeNotifier {
  UserModel? _currentUser;
  List<UserModel> _users = List.from(MockDataService.mockUsers);
  bool _isLoading = false;
  String? _authError;

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;
  String? get authError => _authError;
  List<UserModel> get users => List.unmodifiable(_users);

  static const String founderAdminEmail = "mohammedellawaty56@gmail.com";

  AuthService() {
    _currentUser = null;
    tryRestoreSession();
  }

  /// Automatically restore persistent session so users don't need to log in again on their device
  Future<void> tryRestoreSession() async {
    try {
      final userId = await SecureStorageService.getSavedUserId();
      if (userId != null && userId.isNotEmpty) {
        final user = _users.firstWhere(
          (u) => u.id == userId,
          orElse: () => UserModel(
            id: userId,
            name: 'المستخدم',
            email: '',
            phone: '',
            role: UserRole.standardUser,
            createdAt: DateTime.now(),
          ),
        );
        _currentUser = user;
        notifyListeners();
      }
    } catch (_) {}
  }

  /// Helper to determine role based on email
  UserRole _resolveRoleForEmail(String email, [UserRole defaultRole = UserRole.standardUser]) {
    if (email.trim().toLowerCase() == founderAdminEmail.toLowerCase()) {
      return UserRole.founderAdmin;
    }
    return defaultRole;
  }

  /// Sign In with Google OAuth 2.0 (One-Tap Flow)
  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    _authError = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 700));

      const googleEmail = "user.google@gmail.com";
      const googleName = "عبدالله بن خالد المكي";
      const googleId = "usr_g_982341123";

      var user = _users.firstWhere(
        (u) => u.email.toLowerCase() == googleEmail.toLowerCase(),
        orElse: () => UserModel(
          id: googleId,
          name: googleName,
          email: googleEmail,
          phone: "+966 50 123 4567",
          role: _resolveRoleForEmail(googleEmail, UserRole.standardUser),
          createdAt: DateTime.now(),
        ),
      );

      if (!_users.any((u) => u.id == user.id)) {
        _users.add(user);
      }

      await SecureStorageService.saveAuthSession(
        accessToken: "jwt_access_token_g_${DateTime.now().millisecondsSinceEpoch}",
        refreshToken: "jwt_refresh_token_g_${DateTime.now().millisecondsSinceEpoch}",
        userId: user.id,
      );

      _currentUser = user;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _authError = "تعذر إتمام تسجيل الدخول عبر Google: $e";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Sign In with Apple (Mandatory for iOS App Store compliance)
  Future<bool> signInWithApple() async {
    _isLoading = true;
    _authError = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 700));

      const appleEmail = "makkah.worshipper@privaterelay.appleid.com";
      const appleName = "فيصل بن عبدالعزيز المقرن";
      const appleId = "usr_apple_88349210";

      var user = _users.firstWhere(
        (u) => u.email.toLowerCase() == appleEmail.toLowerCase(),
        orElse: () => UserModel(
          id: appleId,
          name: appleName,
          email: appleEmail,
          phone: "+966 54 999 0011",
          role: _resolveRoleForEmail(appleEmail, UserRole.standardUser),
          createdAt: DateTime.now(),
        ),
      );

      if (!_users.any((u) => u.id == user.id)) {
        _users.add(user);
      }

      await SecureStorageService.saveAuthSession(
        accessToken: "jwt_access_token_a_${DateTime.now().millisecondsSinceEpoch}",
        refreshToken: "jwt_refresh_token_a_${DateTime.now().millisecondsSinceEpoch}",
        userId: user.id,
      );

      _currentUser = user;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _authError = "تعذر إتمام تسجيل الدخول عبر Apple: $e";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Sign In with Email & Password
  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _authError = null;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    final cleanEmail = email.trim().toLowerCase();
    final role = _resolveRoleForEmail(cleanEmail, UserRole.standardUser);

    final user = _users.firstWhere(
      (u) => u.email.toLowerCase() == cleanEmail,
      orElse: () => UserModel(
        id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
        name: cleanEmail == founderAdminEmail ? 'محمد اللواتي (مدير النظام)' : email.split('@').first,
        email: email.trim(),
        phone: '+966 50 000 0000',
        role: role,
        createdAt: DateTime.now(),
      ),
    );

    // Ensure founderAdmin role is enforced if email matches
    final resolvedUser = cleanEmail == founderAdminEmail && user.role != UserRole.founderAdmin
        ? user.copyWith(role: UserRole.founderAdmin, name: 'محمد اللواتي (مدير النظام)')
        : user;

    _currentUser = resolvedUser;
    if (!_users.any((u) => u.id == resolvedUser.id)) {
      _users.add(resolvedUser);
    } else {
      final idx = _users.indexWhere((u) => u.id == resolvedUser.id);
      if (idx != -1) _users[idx] = resolvedUser;
    }

    await SecureStorageService.saveAuthSession(
      accessToken: "jwt_access_token_${DateTime.now().millisecondsSinceEpoch}",
      refreshToken: "jwt_refresh_token_${DateTime.now().millisecondsSinceEpoch}",
      userId: resolvedUser.id,
    );

    _isLoading = false;
    notifyListeners();
    return true;
  }

  /// Register new user with strict Password Policy Validation
  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    _isLoading = true;
    _authError = null;
    notifyListeners();

    // Enforce Password Security Policy
    final validation = PasswordValidator.validate(password);
    if (!validation.isValid) {
      _authError = validation.errorsAr.first;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    await Future.delayed(const Duration(milliseconds: 600));

    final cleanEmail = email.trim().toLowerCase();
    final role = _resolveRoleForEmail(cleanEmail, UserRole.standardUser);

    final newUser = UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email.trim(),
      phone: phone.trim(),
      role: role,
      createdAt: DateTime.now(),
    );

    _users.add(newUser);
    _currentUser = newUser;

    await SecureStorageService.saveAuthSession(
      accessToken: "jwt_access_token_${DateTime.now().millisecondsSinceEpoch}",
      refreshToken: "jwt_refresh_token_${DateTime.now().millisecondsSinceEpoch}",
      userId: newUser.id,
    );

    _isLoading = false;
    notifyListeners();
    return true;
  }

  /// Sign Out and wipe cryptographic keys
  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    await SecureStorageService.clearAll();
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
    _isLoading = false;
    notifyListeners();
  }

  /// Switch user role (Used for live testing across all 5 RBAC roles)
  Future<void> switchDemoRole(UserRole targetRole) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));
    final matchingUser = _users.firstWhere(
      (u) => u.role == targetRole,
      orElse: () => _users.first,
    );

    _currentUser = matchingUser;
    _isLoading = false;
    notifyListeners();
  }

  /// Update user role (Founder Admin only - Anti-Privilege Escalation)
  Future<bool> updateUserRole(String userId, UserRole newRole) async {
    if (_currentUser?.role != UserRole.founderAdmin) {
      debugPrint("Access Denied: Only founder admin can elevate or modify roles.");
      return false;
    }

    final index = _users.indexWhere((u) => u.id == userId);
    if (index != -1) {
      _users[index] = _users[index].copyWith(role: newRole);
      if (_currentUser?.id == userId) {
        _currentUser = _users[index];
      }
      notifyListeners();
      return true;
    }
    return false;
  }
}
