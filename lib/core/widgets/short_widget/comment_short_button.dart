import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/functions/functions.dart';
import 'package:shorts_app/core/managers/color_manager.dart';
import 'package:shorts_app/core/widgets/comments_bottom_sheet/short_comments_bottom_sheet.dart';
import 'package:shorts_app/core/widgets/short_widget/base_short_action_button.dart';
import 'package:shorts_app/dependancies/shorts/controllers/add_short_comment_cubit/add_short_comment_cubit.dart';
import 'package:shorts_app/dependancies/shorts/controllers/add_short_comment_cubit/add_short_comment_cubit_states.dart';
import 'package:shorts_app/dependancies/shorts/controllers/get_short_comments_cubit/get_short_comments_cubit.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';

class CommentShortButton extends StatefulWidget {
  const CommentShortButton({super.key,required this.short});
  final Short short;

  @override
  State<CommentShortButton> createState() => _CommentShortButtonState();
}

class _CommentShortButtonState extends State<CommentShortButton> {
  late Short _short;

  @override
  void initState() {
    super.initState();
    _short=widget.short;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddShortCommentCubit,AddShortCommentStates>(
      listener: _addShortCommentBlocListener,
      child: BaseShortActionButton(
        onTap: _onTap, 
        text: fromCounterToString(_short.commentsCount), 
        icon: const Icon(Icons.comment,size: 40,),
      ),
    );
  }

  void _addShortCommentBlocListener(context, state) {
    if(state is AddShortCommentLoading && state.short.id==_short.id){
      _refreshTheScreen(state.short);
    }else if(state is AddShortCommentFailed && state.short.id==_short.id){
      _refreshTheScreen(state.short);
    }
  }

  void _refreshTheScreen(Short short){
    setState(() {
      _short=short;
    });
  }

  void _onTap(){
    GetShortCommentsCubit.get(context).getShortComments(shortId: _short.id);
    showBottomSheet(
      backgroundColor: ColorManager.transparent,
      context: context, 
      builder: (context)=>ShortCommentsBottomSheet(short: _short,),
    );
  }
}