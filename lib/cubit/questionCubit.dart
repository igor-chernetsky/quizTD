import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/models/fame_model.dart';
import 'package:quiz_defence/models/question_model.dart';
import 'package:quiz_defence/utils/geography.dart';
import 'package:quiz_defence/utils/history.dart';
import 'package:quiz_defence/utils/math.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestionCubit extends Cubit<QuestionsModel> {
  QuestionCubit() : super(QuestionsModel(questions: []));

  void setQuestions(int epoch, int c,
      {ThemeItem? theme, AppLocalizations? local}) async {
    theme = theme ?? state.theme ?? themeItems[0];
    List<QuestionModel> questions = [];
    switch (theme.id) {
      case 0:
        questions = getElMath1(epoch);
        break;
      case 1:
        questions = getElMath2(epoch);
        break;
      case 2:
        questions = await getGeoQuestions(epoch, false, local);
        break;
      case 3:
        questions = await getMath2Questions(epoch);
        break;
      case 4:
        questions = await getGeoQuestions(epoch, true, local);
        break;
      case 5:
        questions = await getHistoryQuestions(epoch, local);
        break;
    }
    emit(QuestionsModel(
        questions: questions,
        theme: theme,
        index: 0,
        correct: c,
        diff: epoch,
        state: QuestionState.none));
  }

  void answerQuestion(String answer, Function nextEpoch) {
    bool isCorrect = answer == state.questions[state.index].answer;
    Vibrate.feedback(isCorrect ? FeedbackType.success : FeedbackType.light);
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
            theme: state.theme,
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
        theme: state.theme,
        questions: state.questions,
        index: state.index + 1,
        state: QuestionState.none,
        correct: state.correct,
        diff: state.diff));
  }
}
