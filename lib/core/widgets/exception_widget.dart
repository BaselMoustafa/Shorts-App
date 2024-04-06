import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shorts_app/core/managers/color_manager.dart';
import '../managers/assets_manager.dart';
import 'custom_button.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget({super.key,this.onTryAgain,required this.message,this.actionWidget,this.widget,this.color=ColorManager.white});
  final Color color;
  final Widget? widget;
  final String message;
  final VoidCallback? onTryAgain;
  final Widget?actionWidget;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget??SizedBox(
            height: 100,
            width: 100,
            child: Lottie.asset(AssetsManager.errorAnimation),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: color),
            ),
          ),
          const SizedBox(height: 20,),
          if(actionWidget!=null)
          actionWidget!,
          if(onTryAgain!=null)
          CustomButton(
            width: 150,
            height: 40,
            onTap:onTryAgain!, 
            child:const Text("Try Again"),
          )
        ],
      ),
    );
  }
}