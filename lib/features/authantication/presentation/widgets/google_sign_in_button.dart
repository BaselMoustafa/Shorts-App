import 'package:flutter/material.dart';
import 'package:shorts_app/core/widgets/custom_button.dart';
import '../../../../core/managers/color_manager.dart';
import '../controllers/google_authantication_cubit/google_authantication_cubit.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap:()=>_onTap(context),
      child: const _ButtonDesign(),
      
    );
  }
  
  void _onTap(BuildContext context) {
    FocusScope.of(context).unfocus();
    GoogleAuthanticationCubit.get(context).signInWithGoogle();
  }
}

class _ButtonDesign extends StatelessWidget {
  const _ButtonDesign();
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 35,
          width: 35,
          child: Icon(Icons.person),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "Use Google Account",
          style: TextStyle(
            color: ColorManager.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
