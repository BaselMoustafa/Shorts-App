import 'package:flutter/cupertino.dart';
import 'package:shorts_app/features/profile/widget/update_my_person_bloc_consumer.dart';
import '../../../core/managers/navigator_manager.dart';
import '../../../core/widgets/custom_button.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      height: 40,
      onTap: ()=>_onTap(context),
      child: const Text("Edit Profile"), 
    );
  }

  void _onTap(BuildContext context){
    NavigatorManager.push(context: context, widget: const UpdateMyPersonBlocConsumer());
  }
}