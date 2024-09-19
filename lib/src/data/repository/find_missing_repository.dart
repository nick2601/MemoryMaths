import 'package:mathsgames/src/data/models/find_missing_model.dart';

import '../RandomFindMissingData.dart';

class FindMissingRepository {
  static List<int> listHasCode = <int>[];

  static getFindMissingDataList(int level) {
    if (level == 1) {
      listHasCode.clear();
    }

    List<FindMissingQuizModel> list = <FindMissingQuizModel>[];

    RandomFindMissingData learnData = new RandomFindMissingData(level);
    while (list.length < 5) {
      list.add(learnData.getMethods());
    }

    //
    // while (list.length < 5) {
    //   MathUtil.generate(level, 5 - list.length)
    //       .forEach((Expression expression) {
    //     List<int> x = <int>[];
    //     int val;
    //     if (expression.operator2 == null) {
    //       val = (list.length % 2 == 0)
    //           ? int.parse(expression.firstOperand)
    //           : int.parse(expression.secondOperand);
    //       x.add(val);
    //     } else {
    //       val = (list.length % 3 == 0)
    //           ? int.parse(expression.firstOperand)
    //           : (list.length % 3 == 1
    //           ? int.parse(expression.secondOperand)
    //           : int.parse(expression.thirdOperand));
    //       x.add(val);
    //     }
    //     while (x.length < 4) {
    //       int x4 = int.parse(MathUtil.generateRandomNumber(
    //           (val - 5) < 0 ? 1 : val - 5, val + 5, 1)
    //           .first);
    //       if (!x.contains(x4)) x.add(x4);
    //     }
    //
    //     x.shuffle();
    //     CorrectAnswer correctAnswerQandS;
    //     if (expression.operator2 == null) {
    //       correctAnswerQandS = CorrectAnswer(
    //           question: Question(
    //             firstOperand: Operand(
    //                 value: expression.firstOperand,
    //                 isQuestionMark: list.length % 2 == 0),
    //             firstOperator: expression.operator1,
    //             secondOperand: Operand(
    //               value: expression.secondOperand,
    //               isQuestionMark: list.length % 2 == 1,
    //             ),
    //             secondOperator: null,
    //             thirdOperand: null,
    //             answer: expression.answer,
    //           ),
    //           firstAns: x[0].toString(),
    //           secondAns: x[1].toString(),
    //           thirdAns: x[2].toString(),
    //           fourthAns: x[3].toString(),
    //           answer: (list.length % 2 == 0)
    //               ? int.parse(expression.firstOperand)
    //               : int.parse(expression.secondOperand));
    //     } else {
    //       correctAnswerQandS = CorrectAnswer(
    //           question: Question(
    //             firstOperand: Operand(
    //                 value: expression.firstOperand,
    //                 isQuestionMark: list.length % 3 == 0),
    //             firstOperator: expression.operator1,
    //             secondOperand: Operand(
    //               value: expression.secondOperand,
    //               isQuestionMark: list.length % 3 == 1,
    //             ),
    //             secondOperator: expression.operator2,
    //             thirdOperand: Operand(
    //               value: expression.thirdOperand,
    //               isQuestionMark: list.length % 3 == 2,
    //             ),
    //             answer: expression.answer,
    //           ),
    //           firstAns: x[0].toString(),
    //           secondAns: x[1].toString(),
    //           thirdAns: x[2].toString(),
    //           fourthAns: x[3].toString(),
    //           answer: (list.length % 3 == 0)
    //               ? int.parse(expression.firstOperand)
    //               : (list.length % 3 == 1
    //               ? int.parse(expression.secondOperand)
    //               : int.parse(expression.thirdOperand)));
    //     }
    //     if (!listHasCode.contains(correctAnswerQandS.hashCode)) {
    //       listHasCode.add(correctAnswerQandS.hashCode);
    //       list.add(correctAnswerQandS);
    //     }
    //   });
    // }

    return list;
  }
}

void main() {
  for (int i = 1; i < 5; i++) {
    FindMissingRepository.getFindMissingDataList(i);
  }
}

//
//   static getFindMissingDataList(int level) {
//     List<Sign> list = <Sign>[];
//
//     if (level == 1) {
//       listHasCode.clear();
//     }
//     while (list.length < 5) {
//       MathUtil.generate(level, 5 - list.length)
//           .forEach((Expression expression) {
//         Sign? signQandS;
//
//
//         print("expression==${expression.operator1}===${expression.operator2}===${expression.secondOperand}===${expression.firstOperand}");
//         if (expression.operator2 == null) {
//           if (expression.operator1 == "+") {
//             if (MathUtil.evaluate(int.parse(expression.firstOperand), "+",
//                     int.parse(expression.secondOperand)) !=
//                 MathUtil.evaluate(int.parse(expression.firstOperand), "*",
//                     int.parse(expression.secondOperand))) {
//
//               signQandS = Sign(
//                 firstDigit: expression.firstOperand,
//                 sign: expression.operator1,
//                 secondDigit: expression.secondOperand,
//                 answer: expression.answer.toString(),
//               );
//
//             }
//           } else if (expression.operator1 == "/") {
//             if (MathUtil.evaluate(int.parse(expression.firstOperand), "/",
//                     int.parse(expression.secondOperand)) !=
//                 MathUtil.evaluate(int.parse(expression.firstOperand), "-",
//                     int.parse(expression.secondOperand))) {
//               signQandS = Sign(
//                 firstDigit: expression.firstOperand,
//                 sign: expression.operator1,
//                 secondDigit: expression.secondOperand,
//                 answer: expression.answer.toString(),
//               );
//             }
//           } else {
//             signQandS = Sign(
//               firstDigit: expression.firstOperand,
//               sign: expression.operator1,
//               secondDigit: expression.secondOperand,
//               answer: expression.answer.toString(),
//             );
//           }
//         } else {
//           signQandS = Sign(
//             firstDigit: list.length % 2 == 0
//                 ? ("${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}")
//                 : (expression.firstOperand),
//             sign: list.length % 2 == 0
//                 ? expression.operator2!
//                 : expression.operator1,
//             secondDigit: list.length % 2 == 0
//                 ? expression.thirdOperand
//                 : ("${expression.secondOperand} ${expression.operator2} ${expression.thirdOperand}"),
//             answer: expression.answer.toString(),
//           );
//         }
//         if (signQandS != null) {
//           if (!listHasCode.contains(signQandS.hashCode)) {
//             listHasCode.add(signQandS.hashCode);
//             list.add(signQandS);
//           }
//         }
//       });
//     }
//     return list;
//   }
// }
//
// void main() {
//   for (int i = 1; i <= 5; i++) {
//     print(FindMissingRepository.getFindMissingDataList(i));
//   }
// }
