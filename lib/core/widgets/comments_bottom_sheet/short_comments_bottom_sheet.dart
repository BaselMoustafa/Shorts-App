import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shorts_app/core/widgets/comments_bottom_sheet/add_short_comment_button.dart';
import 'package:shorts_app/core/widgets/comments_bottom_sheet/short_comment_form_filed.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import '../../managers/box_decoration_manager.dart';
import '../../managers/color_manager.dart';
import '../../managers/navigator_manager.dart';
import 'short_comments_list_view.dart';

class ShortCommentsBottomSheet extends StatelessWidget {
  const ShortCommentsBottomSheet({super.key,required this.short});
  final Short short;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 0.2*MediaQuery.of(context).size.height,
          child: GestureDetector(
            onTap: () => NavigatorManager.pop(context: context),
            child: Container(
              color: ColorManager.red,
              height:0.2* MediaQuery.of(context).size.height,
            ),
          ),
        ),
        _CommentsCountWidget(),
        
        Expanded(
          child: Container(
            width: double.infinity,
            color: ColorManager.darkWhite,
            child: ShortCommentsListView()
          ),
        ),
        _AddCommentWigdet(short: short,)
      ],
    );
  }
}


class _CommentsCountWidget extends StatelessWidget {
  const _CommentsCountWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecorationManager.solidRoundedTopOnly,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Text("Comments"),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: ()=>NavigatorManager.pop(context: context), 
              icon: const Icon(Icons.close,color: ColorManager.black,),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddCommentWigdet extends StatefulWidget {
  const _AddCommentWigdet({required this.short});
  final Short short;
  @override
  State<_AddCommentWigdet> createState() => _AddCommentWigdetState();
}

class _AddCommentWigdetState extends State<_AddCommentWigdet> {
  late final TextEditingController commentController;

  @override
  void initState() {
    super.initState();
    commentController=TextEditingController();
  }
  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.white,
      child: Row(
        children: [
          const SizedBox(width: 10,),
          Expanded(
            child: ShortCommentFormField(commentController: commentController),
          ),
          AddShortCommentButton(commentController: commentController,short: widget.short,)
        ],
      ),
    );
  }
}