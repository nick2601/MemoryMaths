import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mathsgames/src/ui/app/app.dart';
import 'package:mathsgames/src/ui/app/auth_provider.dart';
import 'package:mathsgames/src/ui/app/coin_provider.dart';
import 'package:mathsgames/src/ui/app/theme_provider.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_provider.dart';
import 'package:mathsgames/src/ui/reports/user_report_provider.dart';
import 'package:mathsgames/src/data/repositories/user_report_repository.dart';
import 'package:mathsgames/src/data/repositories/calculator_repository.dart';
import 'package:mathsgames/src/data/repositories/complex_calcualtion_repository.dart';
import 'package:mathsgames/src/data/repositories/correct_answer_repository.dart';
import 'package:mathsgames/src/data/repositories/cube_root_repository.dart';
import 'package:mathsgames/src/data/repositories/dual_repository.dart';
import 'package:mathsgames/src/data/repositories/find_missing_repository.dart';
import 'package:mathsgames/src/data/repositories/magic_triangle_repository.dart';
import 'package:mathsgames/src/data/repositories/math_grid_repository.dart';
import 'package:mathsgames/src/data/repositories/math_pairs_repository.dart';
import 'package:mathsgames/src/data/repositories/mental_arithmetic_repository.dart';
import 'package:mathsgames/src/data/repositories/number_pyramid_repository.dart';
import 'package:mathsgames/src/data/repositories/numeric_memory_repository.dart';
import 'package:mathsgames/src/data/repositories/picture_puzzle_repository.dart';
import 'package:mathsgames/src/data/repositories/quick_calculation_repository.dart';
import 'package:mathsgames/src/data/repositories/sign_repository.dart';
import 'package:mathsgames/src/data/repositories/square_root_repository.dart';
import 'package:mathsgames/src/data/repositories/true_false_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mathsgames/src/ui/app/accessibility_provider.dart';

/// Utility function to format double values for display
String getFormattedString(double d) {
  return d.toStringAsPrecision(2);
}

/// Main entry point of the application.
/// Initializes necessary services and runs the app with required providers.
Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences for persistent storage
  final sharedPreferences = await SharedPreferences.getInstance();

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
  // Register core providers first
  GetIt.I.registerSingleton<DashboardProvider>(
      DashboardProvider(preferences: sharedPreferences));

  GetIt.I.registerSingleton<CoinProvider>(
      CoinProvider(preferences: sharedPreferences));

  // Register core repositories

  // Register game repositories only if needed - use lazy registration
  _registerGameRepositories();
}

/// Registers game-specific repositories using lazy loading to avoid unnecessary memory usage
void _registerGameRepositories() {
  GetIt.I.registerSingleton<UserReportRepository>(UserReportRepository());
  GetIt.I.registerSingleton<UserReportProvider>(
      UserReportProvider(GetIt.I.get<UserReportRepository>()));
  GetIt.I.registerLazySingleton<CalculatorRepository>(
      () => CalculatorRepository());
  GetIt.I.registerLazySingleton<ComplexCalculationRepository>(
      () => ComplexCalculationRepository());
  GetIt.I.registerLazySingleton<CorrectAnswerRepository>(
      () => CorrectAnswerRepository());
  GetIt.I.registerLazySingleton<CubeRootRepository>(() => CubeRootRepository());
  GetIt.I.registerLazySingleton<DualRepository>(() => DualRepository());
  GetIt.I.registerLazySingleton<FindMissingRepository>(
      () => FindMissingRepository());
  GetIt.I.registerLazySingleton<MagicTriangleRepository>(
      () => MagicTriangleRepository());
  GetIt.I.registerLazySingleton<MathGridRepository>(() => MathGridRepository());
  GetIt.I
      .registerLazySingleton<MathPairsRepository>(() => MathPairsRepository());
  GetIt.I.registerLazySingleton<MentalArithmeticRepository>(
      () => MentalArithmeticRepository());
  GetIt.I.registerLazySingleton<NumberPyramidRepository>(
      () => NumberPyramidRepository());
  GetIt.I.registerLazySingleton<NumericMemoryRepository>(
      () => NumericMemoryRepository());
  GetIt.I.registerLazySingleton<PicturePuzzleRepository>(
      () => PicturePuzzleRepository());
  GetIt.I.registerLazySingleton<QuickCalculationRepository>(
      () => QuickCalculationRepository());
  GetIt.I.registerLazySingleton<SignRepository>(() => SignRepository());
  GetIt.I.registerLazySingleton<SquareRootRepository>(
      () => SquareRootRepository());
  GetIt.I
      .registerLazySingleton<TrueFalseRepository>(() => TrueFalseRepository());
}
