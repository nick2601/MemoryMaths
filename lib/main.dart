import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/core/app_routes.dart';

import 'package:mathsgames/src/core/app_theme.dart';
import 'package:mathsgames/src/data/models/dashboard.dart';
import 'package:mathsgames/src/data/models/game_category.dart';
import 'package:mathsgames/src/ui/app/theme_provider.dart';
// Import other views as needed (Dashboard, Game screens, etc.)

/// Initialize Hive boxes and adapters
Future<void> _initializeHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(DashboardAdapter());
  Hive.registerAdapter(GameCategoryAdapter());
  // Register other adapters...

  await Future.wait([
    Hive.openBox('settings'),
    Hive.openBox('coins'),
    Hive.openBox('dashboard'),
  ]);
}

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await _initializeHive();

    runApp(
      ProviderScope(
        observers: [
          if (kDebugMode) ProviderLogger(),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e, stack) {
    debugPrint('Error during initialization: $e\n$stack');
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            'Error: $e',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    ));
  }
}

/// Custom provider observer for debugging
class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
      ProviderBase provider,
      Object? previousValue,
      Object? newValue,
      ProviderContainer container,
      ) {
    debugPrint(
        '[Provider Update] ${provider.name ?? provider.runtimeType} → $newValue');
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maths Games',
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      initialRoute: KeyUtil.splash, // 👈 start from splash
      routes: appRoutes,

      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("Page not found")),
          ),
        );
      },
    );
  }
}