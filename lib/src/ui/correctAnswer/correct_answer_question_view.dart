import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/correct_answer.dart';
import 'package:mathsgames/src/utility/Constants.dart';

class CorrectAnswerQuestionView extends StatelessWidget {
  final Question question;
  final Widget questionView;

  const CorrectAnswerQuestionView({
    Key? key,
    required this.question,
    required this.questionView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);

    Widget getSpace = SizedBox(
      width: getWidthPercentSize(context, 2),
    );
    return Row(
      children: [
        question.firstOperand.isQuestionMark
            ? questionView
            : getTextWidget(
                Theme.of(context).textTheme.titleSmall!,
                question.firstOperand.value,
                TextAlign.center,
                getPercentSize(remainHeight, 4)),
        question.firstOperand.isQuestionMark ? Container() : getSpace,
        getTextWidget(
            Theme.of(context).textTheme.titleSmall!,
            question.firstOperator,
            TextAlign.center,
            getPercentSize(remainHeight, 4)),
        question.secondOperand.isQuestionMark ? Container() : getSpace,
        question.secondOperand.isQuestionMark
            ? questionView
            : getTextWidget(
                Theme.of(context).textTheme.titleSmall!,
                question.secondOperand.value,
                TextAlign.center,
                getPercentSize(remainHeight, 4)),
        if (question.secondOperator != null)
          Row(
            children: [
              getSpace,
              getTextWidget(
                  Theme.of(context).textTheme.titleSmall!,
                  question.secondOperator!,
                  TextAlign.center,
                  getPercentSize(remainHeight, 4)),
              question.thirdOperand!.isQuestionMark ? Container() : getSpace,
              question.thirdOperand!.isQuestionMark
                  ? questionView
                  : getTextWidget(
                      Theme.of(context).textTheme.titleSmall!,
                      question.thirdOperand!.value,
                      TextAlign.center,
                      getPercentSize(remainHeight, 4))
            ],
          ),
        getSpace,
        getTextWidget(Theme.of(context).textTheme.titleSmall!, '=',
            TextAlign.center, getPercentSize(remainHeight, 4)),
        getSpace,
        getTextWidget(
            Theme.of(context).textTheme.titleSmall!,
            question.answer.toString(),
            TextAlign.center,
            getPercentSize(remainHeight, 4)),
      ],
    );
  }
}
