import 'package:flutter/material.dart';

class ShortCommentFormField extends StatelessWidget {
  const ShortCommentFormField({super.key,required this.commentController});
  final TextEditingController commentController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 3,
      controller: commentController,
      textInputAction: TextInputAction.done,
      decoration:const InputDecoration(
        hintText: "Add New Comment",
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}