import 'package:flutter/material.dart';
import 'package:shorts_app/core/widgets/short_widget/comment_short_button.dart';
import 'package:shorts_app/core/widgets/short_widget/like_short_button.dart';
import 'package:shorts_app/core/widgets/short_widget/share_short_button.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';

class ShortActionsWidget extends StatelessWidget {
  const ShortActionsWidget({super.key,required this.short});
  final Short short;
  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      end: 10,
      bottom: 100,
      child:_WidgetDesign(short: short,),
    );
  }
}

class _WidgetDesign extends StatelessWidget {
  const _WidgetDesign({required this.short});
  final Short short;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LikeShortButton(short: short,),
        CommentShortButton(short: short,),
        ShareShortButton(short: short,),
      ],
    );
  }
}

