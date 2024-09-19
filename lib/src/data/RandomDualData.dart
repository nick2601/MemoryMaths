import 'dart:math';

import 'RandomFindMissingData.dart';
import 'models/quiz_model.dart';


class RandomDualData{


  int levelNo = 0;
  int firstDigit = 0;
  int secondDigit = 0;
  int answer = 0;
  double doubleAnswer = 0;
  String? question, tableName;
  String? multiplicationSign,
      space,
      additionSign,
      subtractionSign,
      divisionSign;
  int? dataTypeNumber = 1;

  double firstDoubleDigit = 0;
  double secondDoubleDigit = 0;

  int helpTag = 0;
  double digit_1 = 0, digit_2 = 0, digit_3 = 0, digit_4 = 0;

  String currentSign="+";
  String equalSign="=";
  RandomDualData(int levelNo) {

    this.levelNo = levelNo;
    dataTypeNumber = levelNo;
    // if (levelNo > 10 && levelNo <= 20) {
    //   dataTypeNumber = 2;
    // } else if (levelNo > 20 && levelNo <= 30) {
    //   dataTypeNumber = 3;
    // }

    additionSign = "+";
    multiplicationSign = "*";
    divisionSign = "/";
    subtractionSign = "-";
    space = "\u0020";
  }

  int getFirstMinNumber() {
    int number = 30;
    if(dataTypeNumber == 1){
      number = 10;
    }else if(dataTypeNumber==2){
      number = 150;
    }

    return number;
  }
  int getFirstMaxNumber() {
    int number = 50;


    if(dataTypeNumber == 1){
      number = 50;
    }else if(dataTypeNumber==2){
      number = 200;
    }

    return number;
  }
  int getSecondMaxNumber() {
    int number = 150;


    if(dataTypeNumber == 1){
      number = 100;
    }else if(dataTypeNumber==2){
      number = 250;
    }

    return number;
  }

  int getSecondMinNumber() {
    int number = 150;


    if(dataTypeNumber == 1){
      number = 50;
    }else if(dataTypeNumber==2){
      number = 200;
    }
    return number;
  }
  QuizModel getMethods() {

    int i = new Random().nextInt((4 - 1) + 1) + 1;
    currentSign=additionSign!;
    if (i ==1 ) {
      currentSign=additionSign!;
      return getAddition();
    } else if (i==2) {
      currentSign=subtractionSign!;
      return getSubtraction();
    } else if (i==3) {
      currentSign=multiplicationSign!;
      return getMultiplication();
    } else if (i == 4) {
      currentSign=divisionSign!;
      return getDivision();
    }
    return getAddition();
  }


  QuizModel getAddition() {

    int firstMin = getFirstMinNumber();
    int secondMin = getSecondMinNumber();
    int firstMax = getFirstMaxNumber();
    int secondMax = getSecondMaxNumber();


    firstDigit = new Random().nextInt((firstMax - firstMin) + 1) + firstMin;
    secondDigit = new Random().nextInt((secondMax - secondMin) + 1) + secondMin;


    answer = firstDigit + secondDigit;


    question = firstDigit.toString() + space! + currentSign + space! + secondDigit.toString() + space! + equalSign + space! + "?";

    return addModel();
  }

   QuizModel getSubtraction() {
     if (dataTypeNumber == 1) {
       firstDigit = new Random().nextInt(50) + 10;
       secondDigit = new Random().nextInt(30) + 3;
     } else if (dataTypeNumber == 2) {
       firstDigit = new Random().nextInt((100 - 50) + 1) + 50;
       secondDigit = new Random().nextInt((50 - 10) + 1) + 10;
     } else {
       firstDigit = new Random().nextInt((500 - 200) + 1) + 200;
       secondDigit = new Random().nextInt((200 - 100) + 1) + 100;
     }


     answer = firstDigit - secondDigit;

    question = firstDigit.toString() + space! + currentSign + space! + secondDigit.toString() + space! + equalSign + space! + "?";

    return addModel();
  }

   QuizModel getMultiplication() {
     if (dataTypeNumber == 1) {
       firstDigit = new Random().nextInt(5) + 1;
       secondDigit = new Random().nextInt(5) + 1;
     } else if (dataTypeNumber == 2) {
       firstDigit = new Random().nextInt(30) + 1;
       secondDigit = new Random().nextInt(30) + 1;
     } else {
       firstDigit = new Random().nextInt(80) + 5;
       secondDigit = new Random().nextInt(30) + 5;
     }

    answer = firstDigit * secondDigit;
    question = firstDigit.toString() + space! + currentSign + space! + secondDigit.toString() + space! 
        + equalSign + space! + "?";
    return addModel();
  }

   QuizModel getDivision() {
    double n1, n2;

    if (dataTypeNumber == 1) {
      n1 = new Random().nextInt((40 - 10) + 1) + 5;
      n2 = new Random().nextInt((10 - 5) + 1) + 5;
    } else if (dataTypeNumber == 2) {
      n1 = new Random().nextInt((100 - 50) + 1) + 50;
      n2 = new Random().nextInt((10 - 5) + 1) + 5;
    } else {
      n1 = new Random().nextInt((200 - 100) + 1) + 100;
      n2 = new Random().nextInt((100 - 50) + 1) + 50;
    }

    doubleAnswer = n1 / n2;



    print("double===$doubleAnswer");

    firstDigit =  n1.toInt();
    secondDigit =  n2.toInt();

    question = firstDigit.toString() + space! + currentSign + space! + secondDigit.toString() + space! + equalSign + space! + "?";
    return addDoubleModel();
  }


   QuizModel getSquareData() {
    Random random = new Random();

    if (dataTypeNumber == 1) {
      firstDigit = random.nextInt(20) + 1;
    } else if (dataTypeNumber == 2) {
      firstDigit = random.nextInt(40) + 10;
    } else {
      firstDigit = random.nextInt(80) + 20;
    }

    answer = firstDigit * firstDigit;
    question = firstDigit.toString() +  currentSign + space! + equalSign + space! + "?";
    return addModel();


  }


   QuizModel getSquareRootData() {
    Random random = new Random();

    double firstDigit;

    if (dataTypeNumber == 1) {
      firstDigit = random.nextInt(20) + 1;
    } else if (dataTypeNumber == 2) {
      firstDigit = random.nextInt(40) + 10;
    } else {
      firstDigit = random.nextInt(80) + 20;
    }



    doubleAnswer = sqrt(firstDigit);

    question = currentSign +   firstDigit.toInt().toString() + space! + equalSign + space! + "?";

    return addDoubleModel();
  }


   QuizModel getCubeData() {
    Random random = new Random();
    double firstDigit;

    if (dataTypeNumber == 1) {
      firstDigit = random.nextInt(10) + 1;
    } else if (dataTypeNumber == 2) {
      firstDigit = random.nextInt(50) + 10;
    } else {
      firstDigit = random.nextInt(200) + 100;
    }


    doubleAnswer = pow(firstDigit, 3).toDouble();

    question =  firstDigit.toInt().toString() +  currentSign + space! + equalSign + space! + "?";

    return addDoubleModel();

  }

 

  

 
   QuizModel addModel() {
    int op_1 = answer + 10;
    int op_2 = answer - 10;
    if (op_2 < 0) {
      op_2 = answer + 15;
    }

    int op_3 = answer + 20;
    List<String> stringList = [];
    stringList.add(op_1.toString());
    stringList.add(op_2.toString());
    stringList.add(op_3.toString());
    stringList.add(answer.toString());






    QuizModel  quizModel = new QuizModel(answer.toString(),question: question);



    shuffle(stringList);
    quizModel.optionList = (stringList);
    return quizModel;
  }


   QuizModel addDoubleModel() {
    double opDouble1 = doubleAnswer + 10;
    double opDouble2 = doubleAnswer - 10;

    if (opDouble2 < 0) {
      opDouble2 = doubleAnswer + 15;
    }
    double opDouble3 = doubleAnswer + 20;
    List<String> stringList = [];

    print("double==12===${getFormattedString(doubleAnswer)}");
    stringList.add(getFormattedString(opDouble1));
    stringList.add(getFormattedString(opDouble2));
    stringList.add(getFormattedString(opDouble3));
    stringList.add(getFormattedString(doubleAnswer));


    QuizModel quizModel;





    quizModel = new QuizModel(getFormattedString(doubleAnswer),question: question);


    shuffle(stringList);
    quizModel.optionList=(stringList);
    return quizModel;
  }



}