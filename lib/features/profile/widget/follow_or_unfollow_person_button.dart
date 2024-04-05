import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/dependancies/persons/domain/models/another_person.dart';
import 'package:shorts_app/features/profile/controllers/follow_person_cubit/follow_or_unfollow_person_cubit.dart';
import 'package:shorts_app/features/profile/controllers/follow_person_cubit/follow_or_unfollow_person_cubit_states.dart';
import '../../../core/widgets/custom_button.dart';

class FollowOrUnfollowPersonButton extends StatefulWidget {
  const FollowOrUnfollowPersonButton({super.key,required this.anotherPerson});
  final AnotherPerson anotherPerson;

  @override
  State<FollowOrUnfollowPersonButton> createState() => _FollowOrUnfollowPersonButtonState();
}

class _FollowOrUnfollowPersonButtonState extends State<FollowOrUnfollowPersonButton> {
  late AnotherPerson _anotherPerson;

  @override
  void initState() {
    super.initState();
    _anotherPerson=widget.anotherPerson;
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<FollowOrUnfollowPersonCubit,FollowOrUnfollowPersonStates>(
      listener: (context, state) {
        if(state is FollowOrUnfollowPersonLoading && state.anotherPerson.id==_anotherPerson.id){
          setState(() {
            _anotherPerson=state.anotherPerson;
          });
        }
        else if(state is FollowOrUnfollowPersonFailed && state.anotherPerson.id==_anotherPerson.id){
          setState(() {
            _anotherPerson=state.anotherPerson;
          });
        }
      },
      child: CustomButton(
        height: 40,
        onTap: ()=>_onTap(context),
        child:Text(
          _anotherPerson.followedByMyPerson?"unfollow":"follow",
        ), 
        
      ),
    );
  }

  void _onTap(BuildContext context){
    FollowOrUnfollowPersonCubit.get(context).followOrUnfollowPerson(_anotherPerson);
  }
}