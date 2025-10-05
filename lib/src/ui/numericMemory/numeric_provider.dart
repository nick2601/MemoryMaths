import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/core/app_constant.dart';
import 'package:mathsgames/src/data/models/numeric_memory_pair.dart';
import 'package:mathsgames/src/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class NumericMemoryProvider extends GameProvider<NumericMemoryPair> {
  int first = -1;
  int second = -1;
  int? level;
  BuildContext? context;
  bool isTimer = true;
  Function? nextQuiz;

  NumericMemoryProvider(
      {required TickerProvider vsync,
      required int level,
      required BuildContext context,
      required Function nextQuiz,
      bool? isTimer})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
            isTimer: isTimer,
            c: context) {
    this.level = level;
    this.isTimer = (isTimer == null) ? true : isTimer;
    this.context = context;
    this.nextQuiz = nextQuiz;

    // Override timer behavior for numeric memory
    if (!this.isTimer) {
      // Stop any running timer and prevent game over from timer
      pauseTimer();
      dialogType = DialogType.non;
    }

    startGame(level: this.level == null ? null : level, isTimer: isTimer);
  }

  Future<void> checkResult(String mathPair, int index) async {
    AudioPlayer audioPlayer = new AudioPlayer(context!);

    print("mathPair===$mathPair===${currentState.answer}");

    if (mathPair == currentState.answer) {
      audioPlayer.playRightSound();
      // Match old logic exactly: direct score increase like old currentScore.value
      currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);
      print("Correct! Score is now: $currentScore");
    } else {
      // Match old logic exactly: just call wrongAnswer() like the old code
      wrongAnswer();
      audioPlayer.playWrongSound();
      first = -1;
      print("Wrong! Score is now: $currentScore");
    }

    await Future.delayed(Duration(seconds: 1));

    // Use parent class method exactly like old code
    loadNewDataIfRequired(level: level == null ? 1 : level, isScoreAdd: false);

    if (nextQuiz != null) {
      nextQuiz!();
    }
    notifyListeners();
  }

  @override
  void loadNewDataIfRequired({int? level, bool? isScoreAdd}) {
    // Custom implementation for numeric memory to remove 20-question limit
    isFirstClick = false;
    isSecondClick = false;
    print("NumericMemory list length: ${list.length}, current index: $index");

    // Calculate new level based on progress (every 5 questions = new level)
    int newLevel = (index ~/ 5) + 1;

    // Update levelNo property for display on game screen
    if (newLevel != levelNo) {
      levelNo = newLevel;
      print("Level progression! New level: $levelNo");
    }

    // Load more data if needed (no question limit for numeric memory)
    if (list.length - 2 <= index) {
      print("Loading more questions for level: $newLevel");
      list.addAll(getList(level == null ? newLevel : level));
    }

    result = "";
    index = index + 1;

    if (index < list.length) {
      currentState = list[index];
      print("Next question: ${currentState.question}, Answer: ${currentState.answer}, Current Level: $levelNo");
    } else {
      print("Error: No more questions available");
    }
  }

  @override
  void startGame({int? level, bool? isTimer}) async {
    isTimer = (isTimer == null) ? true : isTimer;
    result = "";

    // Initialize statistics tracking
    gameStartTime = DateTime.now();
    totalCorrectAnswers = 0;
    totalWrongAnswers = 0;
    highestLevel = level ?? 1;

    list = [];
    list = getList(level == null ? 1 : level);

    print("NumericMemory list--${list.length}====");
    index = 0;
    currentScore = 0;
    oldScore = 0;
    currentState = list[index];

    // For numeric memory, NEVER start timer regardless of isTimer setting
    print("NumericMemory - Timer disabled, isTimer: $isTimer");
    if (homeViewModel.isFirstTime(gameCategoryType)) {
      await Future.delayed(Duration(milliseconds: 100));
      showInfoDialog();
    }
    // Do NOT start timer for numeric memory - this was causing the issue

    // Defer coin loading until after build phase to prevent setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCoin();
    });

    WidgetsBinding.instance.addObserver(this);
    notifyListeners();
  }
}
