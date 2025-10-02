import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mathsgames/src/data/models/random_find_missing_data.dart';

import 'package:mathsgames/src/ui/app/app.dart';
import 'package:mathsgames/src/ui/app/auth_provider.dart';
import 'package:mathsgames/src/ui/app/coin_provider.dart';
import 'package:mathsgames/src/ui/app/theme_provider.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_provider.dart';
import 'package:mathsgames/src/ui/reports/user_report_provider.dart';
import 'package:mathsgames/src/data/repositories/user_report_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mathsgames/src/ui/app/accessibility_provider.dart';

/// Main entry point of the application.
/// Initializes necessary services and runs the app with required providers.
Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences for persistent storage
  final sharedPreferences = await SharedPreferences.getInstance();

  // Debug print statement for formatted string
  print("va===${getFormattedString(19.2)}");

  // Set up dependency injection
  setupServiceLocator(sharedPreferences);

  // Run the app with multiple providers for state management
  runApp(
    MultiProvider(
      providers: [
        // Theme provider for app-wide theme management
        ChangeNotifierProvider(
          create: (context) =>
              ThemeProvider(sharedPreferences: sharedPreferences),
        ),
        // Accessibility / Assistive preferences
        ChangeNotifierProvider<AccessibilityProvider>(
          create: (_) => AccessibilityProvider(),
        ),
        // Dashboard provider for managing dashboard state
        ChangeNotifierProvider<DashboardProvider>(
          create: (context) => GetIt.I.get<DashboardProvider>(),
        ),
        // Coin provider for managing in-game currency (user-specific)
        ChangeNotifierProvider<CoinProvider>(
          create: (context) => GetIt.I.get<CoinProvider>(),
        ),
        // Authentication provider for user management
        ChangeNotifierProxyProvider<CoinProvider, AuthProvider>(
          create: (context) => AuthProvider(),
          update: (context, coinProvider, authProvider) {
            // Wire the coin provider to auth provider for user-specific coin management
            authProvider?.setCoinProvider(coinProvider);
            return authProvider!;
          },
        ),
        // User report provider for analytics and reporting
        ChangeNotifierProvider<UserReportProvider>(
          create: (context) => GetIt.I.get<UserReportProvider>(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

/// Sets up dependency injection using GetIt service locator.
/// Registers singleton instances of providers that require shared preferences.
///
/// @param sharedPreferences Instance of SharedPreferences for persistent storage
setupServiceLocator(SharedPreferences sharedPreferences) {
  GetIt.I.registerSingleton<DashboardProvider>(
      DashboardProvider(preferences: sharedPreferences));

  // Register UserReportRepository as singleton
  GetIt.I.registerSingleton<UserReportRepository>(
      UserReportRepository());

  // Register CoinProvider as singleton with user-specific functionality
  if (!GetIt.I.isRegistered<CoinProvider>()) {
    GetIt.I.registerSingleton<CoinProvider>(
        CoinProvider(preferences: sharedPreferences));
  }

  // Register UserReportProvider as singleton
  GetIt.I.registerSingleton<UserReportProvider>(
      UserReportProvider(GetIt.I.get<UserReportRepository>()));
}
