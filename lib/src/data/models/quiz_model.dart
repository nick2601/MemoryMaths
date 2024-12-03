/// Model class representing a quiz question in the game.
/// Contains all the information needed to display and evaluate a math quiz question.
class QuizModel {
  /// Mathematical operator or sign for the question
  String? sign;
  
  /// Remainder value for division questions
  String? rem;
  
  /// Unique identifier for the quiz question
  int? id;
  
  /// First number in the mathematical expression
  String? firstDigit;
  
  /// Second number in the mathematical expression
  String? secondDigit;
  
  /// The complete question text
  String? question;
  
  /// The correct answer to the question
  String? answer;
  
  /// First multiple choice option
  String? op_1;
  
  /// Second multiple choice option
  String? op_2;
  
  /// Third multiple choice option
  String? op_3;

  /// List of all available options for the question
  List<String> optionList = [];

  /// Creates a new QuizModel instance.
  /// 
  /// Parameters:
  /// - [answer]: The correct answer to the question
  /// - [firstDigit]: First number in the expression
  /// - [secondDigit]: Second number in the expression
  /// - [question]: Complete question text
  /// - [op_1]: First option
  /// - [op_2]: Second option
  /// - [op_3]: Third option
   QuizModel(String answer, {
     this.firstDigit,
     this.secondDigit,
     this.question,
     this.op_1,
     this.op_2,
     this.op_3
   }) {
    this.firstDigit = firstDigit;
    this.secondDigit = secondDigit;
    this.question = question;
    this.answer = answer;
    this.op_1 = op_1;
    this.op_2 = op_2;
    this.op_3 = op_3;
  }
}
