/// A utility class that contains all the asset paths used in the application.
/// This class cannot be instantiated and only provides static access to asset paths.
class AppAssets {
  // Private constructor to prevent instantiation
  AppAssets._();

  // Base paths
  /// Base path for image assets
  static const String assetPath = "assets/images/";

  /// Base path for all assets
  static const String assetFolderPath = "assets/";

  // General UI elements
  /// Banner image for the app
  static const String imgBanner = assetPath + "banner.svg";

  /// Coin icon for rewards/points
  static const String icCoin = assetPath + "coin.svg";

  /// Trophy icon for achievements
  static const String icTrophy = assetPath + "ic_trophy.svg";

  // Theme and settings related
  /// Dark mode toggle icon
  static const String icDarkMode = assetPath + "ic_dark_mode.svg";

  /// Settings icon
  static const String setting = assetPath + "setting.svg";

  /// Light mode toggle icon
  static const String icLightMode = assetPath + "ic_light_mode.svg";

  // Navigation and control icons
  /// Close/dismiss icon
  static const String closeIcon = "ic_close.svg";

  /// Star icon (outline)
  static const String startIcon = assetPath + "star.png";

  /// Star icon (filled)
  static const String fillStartIcon = assetPath + "fill_star.png";

  /// Next navigation icon
  static const String nextIcon = "next_icon.svg";

  /// Background for score display
  static const String scoreBg = "score_bg.svg";

  // Game feedback icons
  /// Correct answer indicator
  static const String rightIcon = assetPath + "right.png";

  /// Wrong answer indicator
  static const String wrongIcon = assetPath + "wrong.png";

  /// Back navigation icon
  static const String backIcon = "back_icon.svg";

  /// Pause game icon
  static const String pauseIcon = "ic_pause.svg";

  /// Information icon
  static const String infoIcon = "info.svg";

  /// Play/start icon
  static const String playIcon = "ic_play.svg";

  // Home and navigation related
  /// Home navigation icon
  static const String homeIcon = "home_icon.svg";

  /// Background for home screen cells
  static const String homeCellBg = "home_cell_bg.svg";

  /// Background for sub-cells
  static const String subCellBg = "sub_cell_bg.svg";

  // Game control icons
  /// Restart game icon
  static const String restartIcon = "restart.svg";

  /// Home icon for score screen
  static const String scoreHomeIcon = "Home.svg";

  /// Splash screen icon
  static const String splashIcon = assetPath + "splash.svg";

  /// Share score icon
  static const String scoreShareIcon = assetPath + "Share.svg";

  // Brain training game icons
  /// Brain training icon (filled)
  static const String icTrainBrain = assetPath + "ic_train_brain.svg";

  /// Brain training icon (outline)
  static const String icTrainBrainOutline =
      assetPath + "ic_train_brain_outline.svg";

  /// Memory puzzle icon (filled)
  static const String icMemoryPuzzle = assetPath + "ic_memory_puzzle.svg";

  /// Memory puzzle icon (outline)
  static const String icMemoryPuzzleOutline =
      assetPath + "ic_memory_puzzle_outline.svg";

  /// Math puzzle icon (filled)
  static const String icMathPuzzle = assetPath + "ic_math_puzzle.svg";

  /// Math puzzle icon (outline)
  static const String icMathPuzzleOutline =
      assetPath + "ic_math_puzzle_outline.svg";

  // UI elements and backgrounds
  /// Button shape background
  static const String icButtonShape = assetPath + "ic_button_shape.svg";

  /// Play circle icon (filled)
  static const String icPlayCircleFilled =
      assetPath + "ic_play_circle_filled.svg";

  /// Home screen background
  static const String icHomeBg = assetPath + "ic_home_bg.svg";

  // Math game specific icons
  /// Root symbol icon
  static const String icRoot = assetPath + "ic_root.svg";

  /// Cube root icon
  static const String icCubeRootIcon = assetPath + "root.png";

  /// Calculator icon
  static const String icCalculator = assetPath + "ic_calculator.svg";

  /// Guess the sign game icon
  static const String icGuessTheSign = assetPath + "ic_guess_the_sign.svg";

  /// Correct answer icon
  static const String icCorrectAnswer = assetPath + "ic_correct_answer.svg";

  /// Quick calculation game icon
  static const String icQuickCalculation =
      assetPath + "ic_quick_calculation.svg";

  /// Find missing number game icon
  static const String icFindMissing = assetPath + "find_missing.svg";

  /// True/False game icon
  static const String icTrueFalse = assetPath + "true_false.svg";

  /// Dual game icon
  static const String icDualGame = assetPath + "dual.svg";

  /// Complex calculation game icon
  static const String icComplexCalculation = assetPath + "complex.svg";

  // Additional math game icons
  /// Mental arithmetic game icon
  static const String icMentalArithmetic =
      assetPath + "ic_mental_arithmetic.svg";

  /// Square root game icon
  static const String icSquareRoot = assetPath + "ic_square_root.svg";

  /// Math grid game icon
  static const String icMathGrid = assetPath + "ic_math_grid.svg";

  /// Mathematical pairs game icon
  static const String icMathematicalPairs =
      assetPath + "ic_mathematical_pairs.svg";

  /// Cube root game icon
  static const String icCubeRoot = assetPath + "cube_root.svg";

  /// Concentration game icon
  static const String icConcentration = assetPath + "concentration.svg";

  // Puzzle game icons
  /// Magic triangle game icon
  static const String icMagicTriangle = assetPath + "ic_magic_triangle.svg";

  /// Picture puzzle game icon
  static const String icPicturePuzzle = assetPath + "ic_picture_puzzle.svg";

  /// Number pyramid game icon
  static const String icNumberPyramid = assetPath + "ic_number_pyramid.svg";

  /// Numeric memory game icon
  static const String icNumericMemory = assetPath + "numeric_memory.svg";

  // Button backgrounds
  /// Large button background
  static const String bgLargeButton = assetPath + "bg_large_button.png";

  /// Large button background for dark theme
  static const String bgLargeDarkButton =
      assetPath + "bg_large_button_dark.png";

  /// Small button background
  static const String bgSmallButton = assetPath + "bg_small_button.png";

  /// Small button background for dark theme
  static const String bgSmallDarkButton =
      assetPath + "bg_small_button_dark.png";
}
