import 'package:flutter/material.dart';
import 'package:shorts_app/features/profile/widget/person_followers_counter_widget.dart';
import 'package:shorts_app/features/profile/widget/person_followings_counters_widget.dart';
import 'package:shorts_app/features/profile/widget/person_likes_counter_widget.dart';
import '../../../dependancies/persons/domain/models/person.dart';

class PersonCountersWidget extends StatelessWidget {
  final Person person;
  const PersonCountersWidget({super.key,required this.person});
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: PersonFollowingCounterWidget(person: person),
        ),
        Expanded(
          child: PersonFollowersCounterWidget(person: person),
        ),
        Expanded(
          child: PersonLikesCounterWidget(person: person),
        ),
      ],
    );
  }
}



