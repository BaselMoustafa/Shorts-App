import 'package:flutter/material.dart';

import '../managers/color_manager.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key,required this.onTap,required this.text});
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap, 
      child: Text(
        text,
        style:const TextStyle(
          color: ColorManager.primary,
          fontSize: 14,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}