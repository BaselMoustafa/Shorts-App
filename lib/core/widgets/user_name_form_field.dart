import 'package:flutter/material.dart';
import 'package:shorts_app/core/functions/functions.dart';
import 'package:shorts_app/core/managers/color_manager.dart';
import 'package:shorts_app/core/widgets/custom_text_form_filed.dart';

class UserNameFormFiled extends StatelessWidget {
  const UserNameFormFiled({super.key,required this.userNameController});
  final TextEditingController userNameController;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      textFormFieldProperties: TextFormFieldProperties(
        prefixIcon:const Icon(Icons.person,color: ColorManager.white,),
        maxLength: 20,
        labelText: "User Name",
        controller: userNameController,
        validator: hasNotToBeEmpty,
      ),
    );
  }
}