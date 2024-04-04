import 'package:flutter/material.dart';

import '../../../core/functions/functions.dart';
import '../../../core/managers/color_manager.dart';

class CounterWithLabelWidget extends StatelessWidget {
  final int counter;
  final String label;
  const CounterWithLabelWidget({super.key,required this.counter,required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CounterValueWidget(counter: counter),
        const SizedBox(height: 3,),
        _LabelWidget(label: label),
      ],
    );
  }
}

class _LabelWidget extends StatelessWidget {
  const _LabelWidget({required this.label,});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style:const TextStyle(
        color: ColorManager.white,
        fontSize: 14,
      ),
    );
  }
}

class _CounterValueWidget extends StatelessWidget {
  const _CounterValueWidget({required this.counter,});
  
  final int counter;

  @override
  Widget build(BuildContext context) {
    return Text(
      fromCounterToString(counter),
      style:const TextStyle(
        color: ColorManager.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}