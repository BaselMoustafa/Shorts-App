import 'package:flutter/material.dart';
import 'package:shorts_app/core/functions/functions.dart';
import 'package:shorts_app/core/widgets/custom_text_form_filed.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField({super.key,required this.emailController});
  final TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      textFormFieldProperties: TextFormFieldProperties(
        labelText: "Email",
        controller: emailController,
        validator:hasNotToBeEmpty,
      ),
    );
  }
}