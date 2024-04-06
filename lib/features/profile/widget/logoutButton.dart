import 'package:flutter/cupertino.dart';
import 'package:shorts_app/core/managers/color_manager.dart';
import 'package:shorts_app/features/profile/controllers/signout_cubit/sign_out_cubit.dart';
import '../../../core/widgets/custom_button.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      height: 40,
      color: ColorManager.red,
      onTap: ()=>_onTap(context),
      child: const Text("Logout"), 
    );
  }

  void _onTap(BuildContext context){
    SignOutCubit.get(context).signOut();
  }
}