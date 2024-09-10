import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quiz_defence/models/question_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

getGeoQuestions(int level, bool onlyFlags, AppLocalizations? local) async {
  final String doc = await rootBundle.loadString(
      'assets/docs/${local != null ? local.geoFile : 'geography'}.json');
  final List<dynamic> data = await json.decode(doc);
  List<QuestionModel> res = data.where((d) => d['level'] == level).map((item) {
    List<String> questions = List<String>.from(item['answers'] as List);
    String question = item['isImg'] ?? false
        ? 'assets/img/flags/${item['question']}'
        : item['question'];
    return QuestionModel(
        question: question,
        answer: item['answer'],
        answers: questions,
        isTile: item['isTile'] ?? false,
        isImg: item['isImg'] ?? false);
  }).toList();
  if (onlyFlags) {
    res = res.where((q) => q.isImg || q.isTile).toList();
  }
  res.shuffle();
  res = res.sublist(0, 20);
  for (var q in res) {
    if (q.isTile) {
      q.answer = 'assets/img/flags/${q.answer}';
      q.answers = q.answers.map((item) => 'assets/img/flags/$item').toList();
    }
    q.answers.shuffle();
  }
  return res;
}
