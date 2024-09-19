
class QuizModel {
  String? sign;
  String? rem;
  int? id;
  String? firstDigit;
  String? secondDigit, question;
  String? answer;
  String? op_1;
  String? op_2;
  String? op_3;

  List<String> optionList = [];

   QuizModel(String answer, {this.firstDigit,this.secondDigit,this.question,this.op_1,this.op_2,this.op_3}) {
    this.firstDigit = firstDigit;
    this.secondDigit = secondDigit;
    this.question = question;
    this.answer = answer;
    this.op_1 = op_1;
    this.op_2 = op_2;
    this.op_3 = op_3;
  }



}
