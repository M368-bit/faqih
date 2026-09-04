import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_PKCS1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static const String _keyAccessToken = "fakieh_access_token";
  static const String _keyRefreshToken = "fakieh_refresh_token";
  static const String _keyUserId = "fakieh_user_id";
  static const String _keyBiometricsEnabled = "fakieh_biometrics_enabled";

  /// Save authenticated tokens
  static Future<void> saveAuthSession({
    required String accessToken,
    required String refreshToken,
    required String userId,
  }) async {
    await _storage.write(key: _keyAccessToken, value: accessToken);
    await _storage.write(key: _keyRefreshToken, value: refreshToken);
    await _storage.write(key: _keyUserId, value: userId);
  }

  /// Retrieve Access Token
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _keyAccessToken);
  }

  /// Retrieve Refresh Token for token rotation
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _keyRefreshToken);
  }

  /// Retrieve Saved User ID
  static Future<String?> getSavedUserId() async {
    return await _storage.read(key: _keyUserId);
  }

  /// Rotate and Update Access Token
  static Future<void> rotateAccessToken(String newAccessToken) async {
    await _storage.write(key: _keyAccessToken, value: newAccessToken);
  }

  /// Biometrics setting
  static Future<void> setBiometricsEnabled(bool enabled) async {
    await _storage.write(key: _keyBiometricsEnabled, value: enabled.toString());
  }

  static Future<bool> isBiometricsEnabled() async {
    final val = await _storage.read(key: _keyBiometricsEnabled);
    return val == 'true';
  }

  /// Wipe all secure keys on logout
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
