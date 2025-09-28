/// Root application widget for the Memory Math game.
/// Configures the application theme, routing, and authentication state.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/core/app_theme.dart';
import 'package:mathsgames/src/core/app_routes.dart';
import 'package:mathsgames/src/ui/app/auth_provider.dart';
import 'package:mathsgames/src/ui/app/theme_provider.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_view.dart';
import '../login/login_view.dart';

/// MyApp is the root widget of the Memory Math application.
/// It sets up the application's theme, navigation, and authentication state management.
class MyApp extends ConsumerWidget {
  /// Default font family used throughout the application
  final String fontFamily = "Montserrat";

  /// Creates a new MyApp instance
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lock the application to portrait orientation only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Watch Riverpod providers
    final themeMode = ref.watch(themeProvider);
    final isAuthenticated = ref.watch(authProvider);

    return MaterialApp(
      title: 'Memory Math',
      debugShowCheckedModeBanner: false,

      // Configure application theming
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      initialRoute: KeyUtil.splash,

      // Handle authentication state and route to appropriate screen
      home: isAuthenticated ? DashboardView() : LoginScreen(),

      // Configure application routes
      routes: appRoutes,
      navigatorObservers: const [],
    );
  }
}