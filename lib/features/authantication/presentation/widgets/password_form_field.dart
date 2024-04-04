import 'package:flutter/material.dart';
import 'package:shorts_app/core/functions/functions.dart';
import 'package:shorts_app/core/widgets/custom_text_form_filed.dart';

import '../../../../core/managers/color_manager.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({super.key,required this.passwordController});
  final TextEditingController passwordController;
  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _isVisible=false;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      textFormFieldProperties: TextFormFieldProperties(
        validator: hasNotToBeEmpty,
        obscureText: ! _isVisible,
        controller: widget.passwordController,
        labelText: "Password",
        suffixIcon: IconButton(
          icon:  Icon(_isVisible?Icons.visibility_off:Icons.visibility,color: ColorManager.white,),
          onPressed: () {
            setState(() {
              _isVisible=!_isVisible;
            });
          },
        ),
      ),
    );
  }
}