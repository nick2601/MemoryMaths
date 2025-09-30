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

class MyApp extends ConsumerWidget {
  final String fontFamily = "Montserrat";

  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lock orientation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final themeMode = ref.watch(themeProvider);

    // ✅ Now we get an AuthState instead of a bool
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'Memory Math',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      initialRoute: KeyUtil.splash,

      // ✅ Use authState.isLoggedIn
      home: authState.isLoggedIn ? const DashboardView() : const LoginScreen(),

      routes: appRoutes,
      navigatorObservers: const [],
    );
  }
}