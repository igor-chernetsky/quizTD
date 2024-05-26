import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/cubit/questionCubit.dart';
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
        child: Text(answers[i],
            style: const TextStyle(
              fontSize: 22,
            )),
      ));
    }
    return output;
  }

  getEmptyBlock() {
    return const Center(child: Text('No question found'));
  }

  @override
  Widget build(BuildContext context) {
    double widgetHeight = MediaQuery.of(context).size.height / 3;
    double blockHeight = widgetHeight / 3;
    return SizedBox(
      height: widgetHeight,
      child: BlocBuilder<QuestionCubit, QuestionsModel>(
          builder: (context, qm) => qm.currentQuestions == null
              ? getEmptyBlock()
              : Column(
                  children: [
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
                                  fontSize: 30,
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
