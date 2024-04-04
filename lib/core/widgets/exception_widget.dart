import 'package:flutter/material.dart';
import 'package:shorts_app/core/managers/color_manager.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget({super.key,required this.message,this.widget,this.actionWidget,this.color=ColorManager.white});
  final Color color;
  final Widget? widget;
  final String message;
  final Widget? actionWidget;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20,),
        widget??SizedBox(
          height: 150,
          width: 150,
          child: Icon(Icons.error,size: 140,color: color,),
        ),
        const SizedBox(height: 25,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: color),
          ),
        ),
        const SizedBox(height: 10,),
        actionWidget??const SizedBox(),
      ],
    );
  }
}