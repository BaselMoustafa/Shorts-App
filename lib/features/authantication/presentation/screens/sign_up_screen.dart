import 'package:flutter/material.dart';
import 'package:shorts_app/core/widgets/custom_button.dart';
import 'package:shorts_app/core/widgets/user_name_form_field.dart';
import 'package:shorts_app/features/authantication/presentation/controllers/email_authantication_cubit/email_authantication_cubit.dart';
import 'package:shorts_app/features/authantication/presentation/screens/sign_in_screen.dart';
import 'package:shorts_app/features/authantication/presentation/widgets/email_form_filed.dart';
import 'package:shorts_app/features/authantication/presentation/widgets/password_form_field.dart';
import '../../../../core/managers/navigator_manager.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../widgets/authantication_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
  final TextEditingController _userNameController= TextEditingController();
  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthanticationScreen(
      formKey: _formKey, 
      primaryText: "Sign Up Now", 
      secondaryText: "Save Soul",
      textButton: const _AlreadyHaveAnAccount(), 
      authanticationButton: _SignUpButton(state: this), 
      textFormFields: [
        UserNameFormFiled(userNameController: _userNameController),
        EmailFormField(emailController: _emailController),
        PasswordFormField(passwordController: _passwordController)
      ],
    ); 
    
  }
}

class _AlreadyHaveAnAccount extends StatelessWidget {
  const _AlreadyHaveAnAccount();

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      text: "Already Have An Account",
      onTap: ()=>NavigatorManager.push(context: context,widget:const SignInScreen()), 
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({required this.state});
  final _SignUpScreenState state;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap:()=>_onTap(context),
      child: const Text("Sign Up"),
    );
  }

  void _onTap (BuildContext context){
    FocusScope.of(context).unfocus();
    if(state._formKey.currentState!.validate()){
      EmailAuthanticationCubit.get(context).signUp(
        name: state._userNameController.text, 
        email: state._emailController.text, 
        password: state._passwordController.text
      );
    }
  }
}