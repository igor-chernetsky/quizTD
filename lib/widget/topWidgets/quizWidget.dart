import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/cubit/questionCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/question_model.dart';

class QuizWidget extends StatelessWidget {
  const QuizWidget({super.key});

  getAnswerTiles(BuildContext context, List<String> answers, String answer) {
    List<Widget> output = [];
    for (int i = 0; i < answers.length; i++) {
      output.add(OutlinedButton(
        onPressed: () {
          context.read<QuestionCubit>().answerQuestion(answers[i]);
          if (answers[i] == answer) {
            context.read<GameCubit>().addScore(1);
          } else {
            context.read<GameCubit>().addScore(-1);
          }
        },
        child: SizedBox(
          child: Text(answers[i],
              style: const TextStyle(
                fontSize: 22,
              )),
        ),
      ));
    }
    return output;
  }

  getEmptyBlock() {
    return const Center(child: Text('No question found'));
  }

  @override
  Widget build(BuildContext context) {
    var availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    double widgetHeight = availableHeight / 2;
    double blockHeight = (widgetHeight - 38) / 3;
    return SizedBox(
      height: widgetHeight,
      child: BlocBuilder<QuestionCubit, QuestionsModel>(
          builder: (context, qm) => qm.currentQuestions == null
              ? getEmptyBlock()
              : Column(
                  children: [
                    BlocBuilder<GameCubit, GameModel>(
                        builder: (context1, gm) => Container(
                              height: 30,
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
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: Card(
                            child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              qm.currentQuestions!.question,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ))),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        height: 2 * blockHeight,
                        child: GridView.count(
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 2,
                          crossAxisCount: 3,
                          children: getAnswerTiles(
                              context,
                              qm.currentQuestions!.answers,
                              qm.currentQuestions!.answer),
                        )),
                  ],
                )),
    );
  }
}
