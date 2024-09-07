import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/cubit/questionCubit.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/models/question_model.dart';
import 'package:quiz_defence/utils/colors.dart';
import 'package:quiz_defence/widget/infoWidgets/barWidget.dart';

class QuizWidget extends StatelessWidget {
  const QuizWidget({super.key});

  getAnswerTiles(BuildContext context, QuestionsModel qm) {
    var answers = qm.currentQuestions!.answers;
    var answer = qm.currentQuestions!.answer;
    var isTile = qm.currentQuestions!.isTile;
    var state = qm.state;
    var themeId = qm.theme?.id ?? 0;
    List<Widget> output = [];
    for (int i = 0; i < answers.length; i++) {
      output.add(OutlinedButton(
        onPressed: state == QuestionState.none
            ? () {
                if (answers[i] == answer) {
                  context.read<GameCubit>().addScore(1);
                } else {
                  context.read<GameCubit>().addScore(-1);
                }

                context.read<QuestionCubit>().answerQuestion(answers[i], () {
                  int epoch = context.read<GameCubit>().nextEpoch(true);
                  if (epoch < 5) {
                    context.read<QuestionCubit>().setQuestions(epoch, 0);
                  }
                });
                Future.delayed(const Duration(milliseconds: 500), () {
                  context.read<QuestionCubit>().nextQuestion();
                });
              }
            : null,
        child: SizedBox(
          child: isTile
              ? Image(
                  image: AssetImage(answers[i]),
                  width: 40,
                )
              : Text(answers[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: themeId == 2 ? 14 : 22,
                  )),
        ),
      ));
    }
    return output;
  }

  renderQuestion(QuestionsModel qm) {
    if (qm.currentQuestions!.isImg) {
      return Image(
        image: AssetImage(qm.currentQuestions!.question),
        width: 80,
      );
    }
    return Text(
      textAlign: TextAlign.center,
      qm.currentQuestions!.question,
      style: TextStyle(
          color: getStatusColor(qm.state),
          fontSize: qm.theme?.id == 2 ? 18 : 32,
          fontWeight: FontWeight.bold),
    );
  }

  getEmptyBlock() {
    return const Center(child: Text('No question found'));
  }

  getStatusColor(QuestionState status) {
    switch (status) {
      case QuestionState.correct:
        return Colors.green;
      case QuestionState.wrong:
        return Colors.red;
      default:
        return Colors.white60;
    }
  }

  @override
  Widget build(BuildContext context) {
    var availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    var widgetWidth = min<double>(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height / 2) -
        10;

    double widgetHeight = availableHeight / 2;
    double blockHeight = (widgetHeight - 38) / 3;
    return SizedBox(
      height: widgetHeight,
      width: min<double>(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height / 2),
      child: BlocBuilder<QuestionCubit, QuestionsModel>(
          builder: (context, qm) => qm.currentQuestions == null
              ? getEmptyBlock()
              : Column(
                  children: [
                    BlocBuilder<GameCubit, GameModel>(
                        builder: (context1, gm) => Container(
                              height: 32,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 28,
                                      ),
                                      Text(
                                        '+${gm.answerBoost}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 2),
                                    width: widgetWidth - 160,
                                    child: BarWidget(
                                      value: qm.correct,
                                      total: 20,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 28,
                                      ),
                                      Text(
                                        '-${gm.answerBoost}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                    Container(
                        height: blockHeight,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        child: Card(
                            color: AppColors.cardColor,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              width: double.infinity,
                              child: Center(child: renderQuestion(qm)),
                            ))),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        height: 2 * blockHeight,
                        child: GridView.count(
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 2,
                          crossAxisCount: 3,
                          children: getAnswerTiles(context, qm),
                        )),
                  ],
                )),
    );
  }
}
