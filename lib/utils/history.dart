import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quiz_defence/models/question_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

getHistoryQuestions(int level, AppLocalizations? local) async {
  final String doc = await rootBundle.loadString(
      'assets/docs/${local != null ? local.historyFile : 'history'}.json');
  final List<dynamic> data = await json.decode(doc);
  List<QuestionModel> res = data
      .where((d) => int.parse(d['level'].toString()) == level)
      .toList()
      .map((item) {
    List<String> questions = List<String>.from(item['answers'] as List);
    String question = item['isImg'] ?? false
        ? 'assets/img/history/${item['question']}'
        : item['question'];
    return QuestionModel(
        question: question,
        answer: item['answer'],
        answers: questions,
        isTile: item['isTile'] ?? false,
        isImg: item['isImg'] ?? false);
  }).toList();
  res.shuffle();
  res = res.sublist(0, 20);
  for (var q in res) {
    if (q.isTile) {
      q.answer = 'assets/img/history/${q.answer}';
      q.answers = q.answers.map((item) => 'assets/img/history/$item').toList();
    }
    q.answers.shuffle();
  }
  return res;
}
