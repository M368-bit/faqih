import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_constants.dart';
import 'core/services/auth_service.dart';
import 'core/services/prayer_service.dart';
import 'core/services/notification_service.dart';
import 'core/services/tahfeez_service.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/screens/splash_screen.dart';

class FakiehMosqueApp extends StatelessWidget {
  const FakiehMosqueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => PrayerService()),
        ChangeNotifierProvider(create: (_) => NotificationService()),
        ChangeNotifierProvider(create: (_) => TahfeezService()),
      ],
      child: MaterialApp(
        title: AppConstants.appNameAr,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        locale: const Locale('ar', 'SA'),
        supportedLocales: const [
          Locale('ar', 'SA'),
          Locale('en', 'US'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // Starts with the animated Splash Screen which transitions to AuthWrapper
        home: const SplashScreen(),
      ),
    );
  }
}
