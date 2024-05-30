import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BarWidget extends StatelessWidget {
  final int value;
  final int total;
  final IconData? icon;
  const BarWidget(
      {super.key, required this.value, required this.total, this.icon});

  @override
  Widget build(BuildContext context) {
    double width = value / total;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(icon == null ? 2 : 32, 2, 2, 2),
          height: 34,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(14))),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: width,
            heightFactor: 1,
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(14)))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              icon != null
                  ? Icon(
                      icon,
                      color: Theme.of(context).primaryColor,
                    )
                  : const SizedBox(
                      width: 10,
                    ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Text(
                  '$value/$total',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        )
      ],
    );
  }
}
