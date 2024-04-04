import 'package:flutter/material.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person.dart';
import 'package:shorts_app/features/profile/widget/counter_with_label_widget.dart';

class PersonFollowersCounterWidget extends StatelessWidget {
  const PersonFollowersCounterWidget({super.key,required this.person});
  final Person person;
  @override
  Widget build(BuildContext context) {
    return CounterWithLabelWidget(
      label: "followers",
      counter: person.followersCount, 
    );
  }
}