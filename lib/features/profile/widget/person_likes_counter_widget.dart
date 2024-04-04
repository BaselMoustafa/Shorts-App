import 'package:flutter/material.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person.dart';
import 'package:shorts_app/features/profile/widget/counter_with_label_widget.dart';

class PersonLikesCounterWidget extends StatelessWidget {
  const PersonLikesCounterWidget({super.key,required this.person});
  final Person person;
  @override
  Widget build(BuildContext context) {
    return CounterWithLabelWidget(
      label: "likes",
      counter: person.likesCount, 
    );
  }
}