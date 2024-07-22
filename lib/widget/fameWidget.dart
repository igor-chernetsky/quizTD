import 'package:flutter/material.dart';
import 'package:quiz_td/models/fame_model.dart';

class FameWidget extends StatelessWidget {
  const FameWidget({super.key});

  fameItem(FameModel record) {
    return const Row(
      children: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: ListView.builder(
          itemBuilder: (context, index) => Text(index.toString()),
        ));
  }
}
