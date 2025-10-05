import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathsgames/src/data/models/number_pyramid.dart';
import 'package:mathsgames/src/core/app_constant.dart';

import 'package:mathsgames/src/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class NumberPyramidProvider extends GameProvider<NumberPyramid> {
  int? level;

  NumberPyramidProvider({
    required TickerProvider vsync,
    required int level,
    required BuildContext context,
  }) : super(
          vsync: vsync,
          gameCategoryType: GameCategoryType.NUMBER_PYRAMID,
          context: context,
        ) {
    this.level = level;

    startGame(level: level);
  }

  void pyramidBoxSelection(NumPyramidCellModel model) {
    if (model.isHint) {
      // you can't select/edit hint cell
      return;
    }
    //first find previously selected index
    var previouslySelectedCell =
        currentState.list.indexWhere((cell) => cell.isActive == true);
    if (!previouslySelectedCell.isNegative) {
      currentState.list[previouslySelectedCell].isActive = false;
    }
    currentState.list[model.id - 1].isActive = true;

    notifyListeners();
  }

  void pyramidBoxInputValue(String value) {
    var currentActiveCellIndex =
        currentState.list.indexWhere((cell) => cell.isActive == true);
    if (value == "Back") {
      // if clear is pressed then empty existing text value and return
      currentState.list[currentActiveCellIndex].text = "";
      notifyListeners();
      return;
    }
    var listOfCellWithValues =
        currentState.list.where((cell) => cell.text.isNotEmpty);

    if (value == "Done") {
      if (listOfCellWithValues.length == currentState.remainingCell) {
        checkCorrectValues();
        return;
      } else {
        return;
      }
    }

    var currentCellValue = currentState.list[currentActiveCellIndex].text;
    if (currentCellValue.isNotEmpty) {
      // check if already have value, then append
      var length = currentState.list[currentActiveCellIndex].text.length;
      if (length == 3) {
        // can't have more then 3 digits
        return;
      }
      currentState.list[currentActiveCellIndex].text = currentCellValue + value;
    } else {
      // fresh value
      currentState.list[currentActiveCellIndex].text = value;
    }

    notifyListeners();
  }

  Future<void> checkCorrectValues() async {
    AudioPlayer audioPlayer = new AudioPlayer(context!);

    for (int i = 0; i < currentState.list.length; i++) {
      if (!currentState.list[i].isHint) {
        if (!(currentState.list[i].numberOnCell ==
            int.parse(currentState.list[i].text))) {
          currentState.list[i].isCorrect = false;
          currentState.list[i].isDone = true;
        } else {
          currentState.list[i].isCorrect = true;
          currentState.list[i].isDone = true;
        }
      }
    }
    var correctVal = currentState.list.where((cell) => cell.isCorrect == true);

    if (correctVal.length == currentState.remainingCell) {
      audioPlayer.playRightSound();
      rightAnswer(); // Use standardized method from base class

      await Future.delayed(Duration(milliseconds: 300));
      loadNewDataIfRequired(level: level == null ? null : level);
      if (timerStatus != TimerStatus.pause) {
        restartTimer();
      }
      notifyListeners();
    } else {
      audioPlayer.playWrongSound();
      wrongAnswer(); // Use standardized method from base class
    }
  }
}
