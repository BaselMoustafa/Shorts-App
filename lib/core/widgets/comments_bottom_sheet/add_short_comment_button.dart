import 'package:flutter/material.dart';
import 'package:shorts_app/dependancies/persons/controllers/get_my_person_cubit/get_my_person_cubit.dart';
import 'package:shorts_app/dependancies/shorts/controllers/add_short_comment_cubit/add_short_comment_cubit.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/comment.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import '../../managers/color_manager.dart';

class AddShortCommentButton extends StatelessWidget {
  const AddShortCommentButton({super.key,required this.commentController,required this.short});
  final Short short;
  final TextEditingController commentController;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: ()=>_onTap(context), 
      icon:const Icon(
        Icons.send,
        color: ColorManager.black,
      ),
    );
  }

  void _onTap(BuildContext context){
    if(commentController.text.isEmpty){
      return ;
    }
    AddShortCommentCubit.get(context).addShortComment(
      short: short, 
      newComment: NewComment(
        content: commentController.text, 
        date: DateTime.now(), 
        from: GetMyPersonCubit.myPerson, 
        shortId: short.id, 
        to: short.from,
      ),
    );
    commentController.clear();
    FocusScope.of(context).unfocus();
  }
}