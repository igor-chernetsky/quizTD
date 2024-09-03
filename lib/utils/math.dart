import 'dart:math';

import 'package:quiz_defence/models/question_model.dart';

List<String> mathOperators = ['+', '-', '*'];

getArifmetick(int count, bool simple) {
  Random rnd = Random();
  String result = '';
  int answer = 0;
  for (int i = 0; i < count; i++) {
    int operand = rnd.nextInt(simple ? 10 : 100);
    if (i != 0) {
      String operator = mathOperators[rnd.nextInt(simple ? 1 : 2)];
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

getSubSimple(bool simple) {
  Random rnd = Random();
  String result = '';
  int answer = rnd.nextInt(simple ? 20 : 100);
  int operand = rnd.nextInt(simple ? 20 : 100);
  if (answer > operand) {
    result = '$answer - $operand';
    answer = answer - operand;
  } else {
    result = '$operand - $answer';
    answer = operand - answer;
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

getMathEasyQuestion1() {
  return getArifmetick(2, true);
}

getMathEasyQuestion2() {
  return getSubSimple(true);
}

getMathEasyQuestion3() {
  return getArifmetick(3, true);
}

getMathEasyQuestion4() {
  return getSubSimple(false);
}

getMathQuestion1() {
  return getArifmetick(3, false);
}

getMathQuestion2() {
  Random rnd = Random();
  if (rnd.nextBool()) {
    return getMultiplyQuestion();
  }
  return getArifmetick(4, false);
}

getMathQuestion3() {
  Random rnd = Random();
  QuestionModel res = getMultiply();
  QuestionModel res1;
  bool isMultiply = rnd.nextBool();
  if (isMultiply) {
    res1 = getMultiplyQuestion();
  } else {
    res1 = getArifmetick(2, false);
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
  List<String> answers = [answer.toString()];
  for (int i = 0; i < 5; i++) {
    int variant = getVariant(answer);
    int cc = 0;
    do {
      variant = getVariant(answer);
    } while (answers.contains(variant.toString()) && cc++ < 30);
    answers.add(variant.toString());
  }
  answers.shuffle();
  return answers;
}

getVariant(value) {
  int variant = 0;
  Random rnd = Random();
  if (rnd.nextBool()) {
    variant = value + (1 + rnd.nextInt(1 + 20));
  } else {
    variant = value - (1 + rnd.nextInt(1 + 20));
  }
  if ((value >= 0 && variant < 0) || (value < 0 && variant >= 0)) {
    variant *= -1;
  }
  return variant;
}
