import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/correct_answer.dart';
import 'package:mathsgames/src/utility/Constants.dart';

/// Widget to render a CorrectAnswer [Question] with blanks ("?") replaced
/// by [questionView].
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
    final remainHeight = getRemainHeight(context: context);
    final textStyle = Theme.of(context).textTheme.titleSmall!;
    final textSize = getPercentSize(remainHeight, 4);

    Widget space() => SizedBox(width: getWidthPercentSize(context, 2));

    Widget operandWidget(Operand operand) {
      return operand.isQuestionMark
          ? questionView
          : getTextWidget(textStyle, operand.value, TextAlign.center, textSize);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        operandWidget(question.firstOperand),
        space(),
        getTextWidget(textStyle, question.firstOperator, TextAlign.center, textSize),
        space(),
        operandWidget(question.secondOperand),

        // Handle optional second operator + third operand
        if (question.secondOperator != null && question.thirdOperand != null) ...[
          space(),
          getTextWidget(
              textStyle, question.secondOperator!, TextAlign.center, textSize),
          space(),
          operandWidget(question.thirdOperand!),
        ],

        space(),
        getTextWidget(textStyle, '=', TextAlign.center, textSize),
        space(),
        getTextWidget(
            textStyle, question.answer.toString(), TextAlign.center, textSize),
      ],
    );
  }
}