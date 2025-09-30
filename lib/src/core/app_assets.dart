/// A utility class that contains all the asset paths used in the application.
/// This class cannot be instantiated and only provides static access to asset paths.
class AppAssets {
  AppAssets._(); // prevent instantiation

  // ======================
  // 📂 Base Paths
  // ======================
  static const String assetPath = "assets/images/";
  static const String assetFolderPath = "assets/";

  // Themed folders
  static const String yellowTheme = "${assetPath}imgYellow/";
  static const String greenTheme = "${assetPath}imgGreen/";
  static const String blueTheme = "${assetPath}imgBlue/";

  static const String yellowDarkTheme = "${assetPath}imgYellowDark/";
  static const String greenDarkTheme = "${assetPath}imgGreenDark/";
  static const String blueDarkTheme = "${assetPath}imgBlueDark/";

  // ======================
  // 🌐 General UI elements
  // ======================
  static const String imgBanner = "${assetPath}banner.svg";
  static const String icCoin = "${assetPath}coin.svg";
  static const String icTrophy = "${assetPath}ic_trophy.svg";

  // ======================
  // 🎨 Theme & Settings
  // ======================
  static const String icDarkMode = "${assetPath}ic_dark_mode.svg";
  static const String icLightMode = "${assetPath}ic_light_mode.svg";
  static const String setting = "${assetPath}setting.svg";

  // ======================
  // 🔄 Navigation & Control
  // ======================
  static const String closeIcon = "${assetPath}ic_close.svg";
  static const String nextIcon = "${assetPath}next_icon.svg";
  static const String scoreBg = "${assetPath}score_bg.svg";
  static const String backIcon = "${assetPath}back_icon.svg";
  static const String pauseIcon = "${assetPath}ic_pause.svg";
  static const String infoIcon = "${assetPath}info.svg";
  static const String playIcon = "${assetPath}ic_play.svg";
  static const String homeIcon = "${assetPath}home_icon.svg";

  // ======================
  // 🏠 Home & Backgrounds
  // ======================
  static const String homeCellBg = "${assetPath}home_cell_bg.svg";
  static const String subCellBg = "${assetPath}sub_cell_bg.svg";
  static const String icHomeBg = "${assetPath}ic_home_bg.svg";

  // ======================
  // ⭐ Feedback & Rating
  // ======================
  static const String startIcon = "${assetPath}star.png";
  static const String fillStartIcon = "${assetPath}fill_star.png";
  static const String rightIcon = "${assetPath}right.png";
  static const String wrongIcon = "${assetPath}wrong.png";

  // ======================
  // 🧮 Math Games
  // ======================
  static const String icRoot = "${assetPath}ic_root.svg";
  static const String icCubeRootIcon = "${assetPath}root.png";
  static const String icCalculator = "${assetPath}ic_calculator.svg";
  static const String icGuessTheSign = "${assetPath}ic_guess_the_sign.svg";
  static const String icCorrectAnswer = "${assetPath}ic_correct_answer.svg";
  static const String icQuickCalculation = "${assetPath}ic_quick_calculation.svg";
  static const String icFindMissing = "${assetPath}find_missing.svg";
  static const String icTrueFalse = "${assetPath}true_false.svg";
  static const String icDualGame = "${assetPath}dual.svg";
  static const String icComplexCalculation = "${assetPath}complex.svg";
  static const String icMentalArithmetic = "${assetPath}ic_mental_arithmetic.svg";
  static const String icSquareRoot = "${assetPath}ic_square_root.svg";
  static const String icMathGrid = "${assetPath}ic_math_grid.svg";
  static const String icMathematicalPairs = "${assetPath}ic_mathematical_pairs.svg";
  static const String icCubeRoot = "${assetPath}cube_root.svg";
  static const String icConcentration = "${assetPath}concentration.svg";
  static const String icMagicTriangle = "${assetPath}ic_magic_triangle.svg";
  static const String icPicturePuzzle = "${assetPath}ic_picture_puzzle.svg";
  static const String icNumberPyramid = "${assetPath}ic_number_pyramid.svg";
  static const String icNumericMemory = "${assetPath}numeric_memory.svg";

  // ======================
  // 🧠 Brain Training
  // ======================
  static const String icTrainBrain = "${assetPath}ic_train_brain.svg";
  static const String icTrainBrainOutline = "${assetPath}ic_train_brain_outline.svg";
  static const String icMemoryPuzzle = "${assetPath}ic_memory_puzzle.svg";
  static const String icMemoryPuzzleOutline = "${assetPath}ic_memory_puzzle_outline.svg";
  static const String icMathPuzzle = "${assetPath}ic_math_puzzle.svg";
  static const String icMathPuzzleOutline = "${assetPath}ic_math_puzzle_outline.svg";

  // ======================
  // 🎮 UI Elements & Buttons
  // ======================
  static const String icButtonShape = "${assetPath}ic_button_shape.svg";
  static const String icPlayCircleFilled = "${assetPath}ic_play_circle_filled.svg";

  static const String bgLargeButton = "${assetPath}bg_large_button.png";
  static const String bgLargeDarkButton = "${assetPath}bg_large_button_dark.png";
  static const String bgSmallButton = "${assetPath}bg_small_button.png";
  static const String bgSmallDarkButton = "${assetPath}bg_small_button_dark.png";

  // ======================
  // 🎬 Misc
  // ======================
  static const String splashIcon = "${assetPath}splash.svg";
  static const String scoreShareIcon = "${assetPath}Share.svg";
  static const String restartIcon = "${assetPath}restart.svg";
  static const String scoreHomeIcon = "${assetPath}Home.svg";

  // ======================
  // 🎨 Themed Assets Examples
  // ======================
  static const String yellowBackIcon = "${yellowTheme}back_icon.svg";
  static const String yellowHomeBg = "${yellowTheme}home_cell_bg.svg";

  static const String greenBackIcon = "${greenTheme}back_icon.svg";
  static const String blueBackIcon = "${blueTheme}back_icon.svg";

  static const String yellowDarkBackIcon = "${yellowDarkTheme}back_icon.svg";
  static const String greenDarkBackIcon = "${greenDarkTheme}back_icon.svg";
  static const String blueDarkBackIcon = "${blueDarkTheme}back_icon.svg";
}