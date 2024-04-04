import 'package:flutter/material.dart';
import 'package:shorts_app/core/widgets/custom_button.dart';
import 'package:shorts_app/features/authantication/presentation/widgets/email_form_filed.dart';
import 'package:shorts_app/features/authantication/presentation/widgets/password_form_field.dart';
import '../../../../core/managers/navigator_manager.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../controllers/email_authantication_cubit/email_authantication_cubit.dart';
import '../widgets/authantication_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthanticationScreen(
      formKey: _formKey, 
      primaryText: "Sign In Now", 
      secondaryText: "Save Soul",
      textButton: const _DontHaveAccountButton(), 
      authanticationButton: _SignInButton(state: this), 
      textFormFields: [
        EmailFormField(emailController: _emailController),
        PasswordFormField(passwordController: _passwordController)
      ],
    ); 
    
  }
}

class _DontHaveAccountButton extends StatelessWidget {
  const _DontHaveAccountButton();

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      text: "Dont't Have An Account?",
      onTap: ()=>NavigatorManager.pop(context: context), 
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({required this.state});
  final _SignInScreenState state;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap:()=>_onTap(context),
      child: const Text("Sign In"),
    );
  }

  void _onTap (BuildContext context){
    FocusScope.of(context).unfocus();
    if(state._formKey.currentState!.validate()){
      EmailAuthanticationCubit.get(context).signIn(
        email: state._emailController.text, 
        password: state._passwordController.text
      );
    }
  }
}