import 'package:flutter/foundation.dart';

/// Local database stub — Firebase removed for offline APK build
class DatabaseService {
  static Future<void> initDatabaseEngine() async {
    debugPrint('Local database engine initialized (offline mode).');
  }
}

