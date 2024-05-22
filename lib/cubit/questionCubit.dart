import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/models/question_model.dart';

List<String> mathOperators = ['+', '-'];

getMathQuestion1() {
  Random rnd = Random();
  int count = 2 + rnd.nextInt(4 - 2);
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

  List<String> answers = [answer.toString()];
  for (int i = 0; i < 5; i++) {
    if (rnd.nextBool()) {
      answers.add((answer + (1 + rnd.nextInt(1 + 20))).toString());
    } else {
      answers.add((answer - (1 + rnd.nextInt(1 + 20))).toString());
    }
  }
  answers.shuffle();

  return QuestionModel(
    question: result,
    answer: answer.toString(),
    answers: answers,
  );
}

class QuestionCubit extends Cubit<QuestionsModel> {
  QuestionCubit() : super(QuestionsModel(questions: []));

  void setQuestions() {
    List<QuestionModel> questions = [];
    for (int i = 0; i < 10; i++) {
      questions.add(getMathQuestion1());
    }
    emit(QuestionsModel(questions: questions, index: 0));
  }

  void answerQuestion(String answer) => {
        if (state.questions.length > state.index + 1)
          {
            emit(QuestionsModel(
                questions: state.questions, index: state.index + 1))
          }
      };
}
