enum QuestionState { none, correct, wrong }

class QuestionModel {
  String question;
  bool isImg;
  bool isTile;
  List<String> answers;
  String answer;

  QuestionModel(
      {required this.question,
      required this.answer,
      this.isImg = false,
      this.isTile = false,
      required this.answers});
}

class QuestionsModel {
  List<QuestionModel> questions;
  int index;
  int correct;
  int diff;
  QuestionState state;

  QuestionsModel(
      {required this.questions,
      this.index = 0,
      this.state = QuestionState.none,
      this.correct = 0,
      this.diff = 1});

  QuestionModel? get currentQuestions {
    if (questions.isEmpty) {
      return null;
    }
    return questions[index];
  }
}
