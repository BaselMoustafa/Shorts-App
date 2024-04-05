import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person.dart';
import 'package:shorts_app/features/profile/widget/counter_with_label_widget.dart';
import '../controllers/follow_person_cubit/follow_or_unfollow_person_cubit.dart';
import '../controllers/follow_person_cubit/follow_or_unfollow_person_cubit_states.dart';

class PersonFollowersCounterWidget extends StatefulWidget {
  const PersonFollowersCounterWidget({super.key,required this.person});
  final Person person;

  @override
  State<PersonFollowersCounterWidget> createState() => _PersonFollowersCounterWidgetState();
}

class _PersonFollowersCounterWidgetState extends State<PersonFollowersCounterWidget> {
late Person _person;

  @override
  void initState() {
    super.initState();
    _person=widget.person;
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<FollowOrUnfollowPersonCubit,FollowOrUnfollowPersonStates>(
      listener: (context, state) {
        if(state is FollowOrUnfollowPersonLoading && state.anotherPerson.id==_person.id){
          setState(() {
            _person=state.anotherPerson;
          });
        }
        else if(state is FollowOrUnfollowPersonFailed && state.anotherPerson.id==_person.id){
          setState(() {
            _person=state.anotherPerson;
          });
        }
      },
      child:CounterWithLabelWidget(counter: _person.followersCount, label: "followers"),
    );
  }

}