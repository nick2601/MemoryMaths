import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Domain layer imports
import 'package:mathsgames/domain/repositories/calculator_repository.dart';
import 'package:mathsgames/domain/repositories/game_config_repository.dart';
import 'package:mathsgames/domain/repositories/game_score_repository.dart';
import 'package:mathsgames/domain/usecases/get_calculator_problems_usecase.dart';
import 'package:mathsgames/domain/usecases/game_config_usecases.dart';
import 'package:mathsgames/domain/usecases/game_score_usecases.dart';

// Data layer imports
import 'package:mathsgames/data/datasources/calculator_datasource.dart';
import 'package:mathsgames/data/datasources/game_config_datasource.dart';
import 'package:mathsgames/data/repositories_impl/calculator_repository_impl.dart';
import 'package:mathsgames/data/repositories_impl/game_config_repository_impl.dart';
import 'package:mathsgames/data/repositories_impl/game_score_repository_impl.dart';

// Presentation layer imports
import 'package:mathsgames/presentation/viewmodels/calculator_viewmodel.dart';
import 'package:mathsgames/presentation/viewmodels/game_config_viewmodel.dart';
import 'package:mathsgames/presentation/viewmodels/game_score_viewmodel.dart';

/// Dependency injection setup for Clean Architecture
/// This file sets up all dependencies following the dependency rule:
/// - Presentation depends on Domain
/// - Data depends on Domain
/// - Domain depends on nothing
final sl = GetIt.instance; // Service Locator

/// Initialize all dependencies
/// Call this at app startup before runApp()
Future<void> initDependencies(SharedPreferences sharedPreferences) async {
  // External dependencies
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Data sources
  sl.registerLazySingleton<CalculatorDataSource>(
    () => CalculatorDataSourceImpl(),
  );

  sl.registerLazySingleton<GameConfigDataSource>(
    () => GameConfigDataSourceImpl(sharedPreferences: sl()),
  );

  // Repositories (Data Layer implementing Domain interfaces)
  sl.registerLazySingleton<CalculatorRepository>(
    () => CalculatorRepositoryImpl(dataSource: sl()),
  );

  sl.registerLazySingleton<GameConfigRepository>(
    () => GameConfigRepositoryImpl(dataSource: sl()),
  );

  sl.registerLazySingleton<GameScoreRepository>(
    () => GameScoreRepositoryImpl(sharedPreferences: sl()),
  );

  // Use cases (Domain Layer)
  // Calculator use cases
  sl.registerLazySingleton(
    () => GetCalculatorProblemsUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => ClearCalculatorCacheUseCase(sl()),
  );

  // Game config use cases
  sl.registerLazySingleton(
    () => GetGameConfigUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => UpdateGameConfigUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => ToggleSoundUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => ToggleVibrationUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => ToggleDarkModeUseCase(sl()),
  );

  // Game score use cases
  sl.registerLazySingleton(
    () => SaveGameScoreUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => GetGameScoreUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => GetHighScoreUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => ManageCoinsUseCase(sl()),
  );

  // ViewModels (Presentation Layer)
  sl.registerFactory(
    () => CalculatorViewModel(
      getCalculatorProblemsUseCase: sl(),
      clearCalculatorCacheUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => GameConfigViewModel(
      getGameConfigUseCase: sl(),
      updateGameConfigUseCase: sl(),
      toggleSoundUseCase: sl(),
      toggleVibrationUseCase: sl(),
      toggleDarkModeUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => GameScoreViewModel(
      saveGameScoreUseCase: sl(),
      getGameScoreUseCase: sl(),
      getHighScoreUseCase: sl(),
      manageCoinsUseCase: sl(),
    ),
  );
}
