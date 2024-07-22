import 'dart:math';

import 'package:quiz_td/models/question_model.dart';

List<String> mathOperators = ['+', '-', '*'];

getArifmetick(int count) {
  Random rnd = Random();
  String result = '';
  int answer = 0;
  for (int i = 0; i < count; i++) {
    int operand = rnd.nextInt(100);
    if (i != 0) {
      String operator = mathOperators[rnd.nextInt(2)];
      result += ' $operator $operand';
      switch (operator) {
        case '+':
          answer += operand;
          break;
        case '-':
          answer -= operand;
          break;
      }
    } else {
      result = operand.toString();
      answer = operand;
    }
  }

  List<String> answers = _generateAnswers(answer);

  return QuestionModel(
    question: result,
    answer: answer.toString(),
    answers: answers,
  );
}

getMultiply() {
  Random rnd = Random();
  String result = '';
  int answer = 0;
  for (int i = 0; i < 2; i++) {
    int operand1 = rnd.nextInt(40);
    int operand2 = rnd.nextInt(15);
    result = '$operand1 * $operand2';
    answer = operand1 * operand2;
  }
  return QuestionModel(
    question: result,
    answer: answer.toString(),
    answers: [],
  );
}

getMultiplyQuestion() {
  QuestionModel res = getMultiply();
  res.answers = _generateAnswers(int.tryParse(res.answer)!);
  return res;
}

getMathQuestion1() {
  return getArifmetick(2);
}

getMathQuestion2() {
  Random rnd = Random();
  if (rnd.nextBool()) {
    return getMultiplyQuestion();
  }
  return getArifmetick(3);
}

getMathQuestion3() {
  Random rnd = Random();
  QuestionModel res = getMultiply();
  QuestionModel res1;
  bool isMultiply = rnd.nextBool();
  if (isMultiply) {
    res1 = getMultiplyQuestion();
  } else {
    res1 = getArifmetick(2);
  }
  String operator = mathOperators[rnd.nextInt(3)];
  int ans = int.tryParse(res.answer)!;
  switch (operator) {
    case '+':
      res.answer = (ans + int.tryParse(res1.answer)!).toString();
      res.question += ' + ${res1.question}';
      break;
    case '-':
      res.answer = (ans - int.tryParse(res1.answer)!).toString();
      res.question += ' - ${res1.question}';
      break;
    case '*':
      res.answer = (ans * int.tryParse(res1.answer)!).toString();
      if (isMultiply) {
        res.question += ' * ${res1.question}';
      } else {
        res.question += ' * (${res1.question})';
      }
      break;
  }

  res.answers = _generateAnswers(int.tryParse(res.answer)!);
  return res;
}

getMathQuestion4() {
  QuestionModel res = getMathQuestion3();
  List<String> numbers =
      res.question.split(' ').where((t) => !mathOperators.contains(t)).toList();
  res.question += ' = ${res.answer}';

  Random rnd = Random();
  res.answer = numbers[rnd.nextInt(numbers.length - 1)];
  res.question = res.question.replaceFirst(res.answer, '__');

  res.answers = _generateAnswers(int.tryParse(res.answer)!);

  return res;
}

List<String> _generateAnswers(int answer) {
  Random rnd = Random();
  List<String> answers = [answer.toString()];
  for (int i = 0; i < 5; i++) {
    if (rnd.nextBool()) {
      answers.add((answer + (1 + rnd.nextInt(1 + 20))).toString());
    } else {
      answers.add((answer - (1 + rnd.nextInt(1 + 20))).toString());
    }
  }
  answers.shuffle();
  return answers;
}
