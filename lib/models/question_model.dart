class QuestionModel {
  String question;
  bool isImg;
  bool isTile;
  List<String> answers;
  String answer;
  int diff;

  QuestionModel(
      {required this.question,
      required this.answer,
      this.isImg = false,
      this.isTile = false,
      required this.answers,
      this.diff = 0});
}

class QuestionsModel {
  List<QuestionModel> questions;
  int index;
  String theme;

  QuestionsModel(
      {required this.questions, this.index = 0, this.theme = 'Math'});

  QuestionModel? get currentQuestions {
    if (questions.isEmpty) {
      return null;
    }
    return questions[index];
  }
}
