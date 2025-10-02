/// Root application widget for the Memory Math game.
/// Configures the application theme, routing, and authentication state.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/core/app_theme.dart';
import 'package:mathsgames/src/core/app_routes.dart';
import 'package:mathsgames/src/ui/app/auth_provider.dart';
import 'package:mathsgames/src/ui/app/theme_provider.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_view.dart';
import 'package:mathsgames/src/ui/splash/splash_view.dart';
import 'package:provider/provider.dart';

import '../login/login_view.dart';

/// MyApp is the root widget of the Memory Math application.
/// It sets up the application's theme, navigation, and authentication state management.
class MyApp extends StatelessWidget {
  /// Default font family used throughout the application
  final String fontFamily = "Montserrat";

  /// Creates a new MyApp instance
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lock the application to portrait orientation only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Listen to theme changes using ThemeProvider
    return Consumer<ThemeProvider>(
        builder: (context, ThemeProvider provider, child) {
      return MaterialApp(
        title: 'Memory Math',
        debugShowCheckedModeBanner: false,
        // Configure application theming
        theme: AppTheme.theme,
        darkTheme: AppTheme.darkTheme,
        themeMode: provider.themeMode,
        // Use proper routing - start with splash screen
        initialRoute: KeyUtil.splash,
        // Configure application routes
        routes: appRoutes,
        // Handle route generation for unknown routes
        onGenerateRoute: (settings) {
          // Handle authentication-based routing
          return MaterialPageRoute(
            builder: (context) {
              // Check if trying to access dashboard or home
              if (settings.name == KeyUtil.dashboard || settings.name == KeyUtil.home) {
                return Consumer<AuthProvider>(
                  builder: (context, authProvider, _) {
                    if (authProvider.isAuthenticated) {
                      // User is authenticated, allow access to requested route
                      if (settings.name == KeyUtil.dashboard) {
                        return DashboardView();
                      } else if (settings.name == KeyUtil.home) {
                        // Handle home route with arguments if needed
                        return appRoutes[KeyUtil.home]!(context);
                      }
                    }
                    // User not authenticated, redirect to login
                    return LoginScreen();
                  },
                );
              }

              // For other routes, use default routing
              if (appRoutes.containsKey(settings.name)) {
                return appRoutes[settings.name]!(context);
              }

              // Fallback to splash screen for unknown routes
              return SplashView();
            },
          );
        },
        // Handle unknown routes
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => SplashView(),
          );
        },
        navigatorObservers: [],
      );
    });
  }
}
