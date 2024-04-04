import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shorts_app/core/widgets/loading_widget.dart';

import '../managers/color_manager.dart';

class BlockInteractionLoadingWidget extends StatelessWidget {
  const BlockInteractionLoadingWidget({super.key,required this.widget,required this.isLoading});
  final Widget widget;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(child: widget),
        if(isLoading)
        Container(
          color: ColorManager.grey.withOpacity(0.2),
          child:const LoadingWidget(),
        ),
      ],
    );
  }
}