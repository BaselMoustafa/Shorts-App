import 'package:flutter/cupertino.dart';
import 'package:shorts_app/dependancies/persons/domain/models/another_person.dart';

import '../../../core/managers/navigator_manager.dart';
import '../../../core/widgets/custom_button.dart';
import '../screens/edit_profile_screen.dart';

class FollowOrUnfollowPersonButton extends StatelessWidget {
  const FollowOrUnfollowPersonButton({super.key,required this.anotherPerson});
  final AnotherPerson anotherPerson;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      height: 40,
      onTap: ()=>_onTap(context),
      child:Text(
        anotherPerson.followedByMyPerson?"unfollow":"follow",
      ), 
      
    );
  }

  void _onTap(BuildContext context){
    NavigatorManager.push(context: context, widget: const EditProfileScreen());
  }
}