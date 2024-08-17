import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/models/question_model.dart';
import 'package:quiz_td/utils/math.dart';

class QuestionCubit extends Cubit<QuestionsModel> {
  QuestionCubit() : super(QuestionsModel(questions: []));

  void setQuestions(int epoch, int c) {
    List<QuestionModel> questions = [];
    switch (epoch) {
      case 4:
        for (int i = 0; i < 20; i++) {
          questions.add(getMathQuestion4());
        }
        break;
      case 3:
        for (int i = 0; i < 20; i++) {
          questions.add(getMathQuestion3());
        }
        break;
      case 2:
        for (int i = 0; i < 20; i++) {
          questions.add(getMathQuestion2());
        }
        break;
      default:
        for (int i = 0; i < 20; i++) {
          questions.add(getMathQuestion1());
        }
    }
    emit(QuestionsModel(
        questions: questions,
        index: 0,
        correct: c,
        diff: epoch,
        state: QuestionState.none));
  }

  void answerQuestion(String answer, Function nextEpoch) {
    bool isCorrect = answer == state.questions[state.index].answer;
    int c1 = state.correct + (isCorrect ? 1 : 0);
    if (c1 < 0) {
      c1 = 0;
    }
    if (c1 == 20) {
      nextEpoch();
    } else {
      if (state.questions.length <= state.index + 1) {
        setQuestions(state.diff, c1);
      } else {
        emit(QuestionsModel(
            questions: state.questions,
            index: state.index,
            state: isCorrect ? QuestionState.correct : QuestionState.wrong,
            correct: c1,
            diff: state.diff));
      }
    }
  }

  void nextQuestion() {
    return emit(QuestionsModel(
        questions: state.questions,
        index: state.index + 1,
        state: QuestionState.none,
        correct: state.correct,
        diff: state.diff));
  }
}
