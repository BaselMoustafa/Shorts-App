import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shorts_app/core/managers/assets_manager.dart';
import 'package:shorts_app/core/managers/color_manager.dart';
import 'package:shorts_app/core/widgets/exception_widget.dart';

class ThereAreNoWidget extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onTryAgain;
  const ThereAreNoWidget({super.key,required this.label,this.color=ColorManager.white,this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return ExceptionWidget(
      onTryAgain: onTryAgain,
      color: color,
      message:"Threre Are No $label" ,
      widget: SizedBox(
        height: 150,
        width: 150,
        child: Lottie.asset(AssetsManager.emptyAnimation),
        
      ),
    );
  }
}