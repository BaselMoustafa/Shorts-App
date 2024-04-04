import 'package:flutter/material.dart';
import 'package:shorts_app/core/widgets/custom_text_form_filed.dart';

class BioTextField extends StatelessWidget {
  const BioTextField({super.key,required this.bioTextController});
  final TextEditingController bioTextController;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      textFormFieldProperties: TextFormFieldProperties(
        maxLength: 100,
        controller: bioTextController,
        minLines: 1,
        maxLines: 10,
        labelText: "Bio"
      ),
    );
  }
}