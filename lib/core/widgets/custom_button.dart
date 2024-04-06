import 'package:flutter/material.dart';
import '../managers/box_decoration_manager.dart';
import '../managers/color_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.child,
    required this.onTap,
    this.height=50,
    this.width,
    this.boxDecoration,
    this.disabled=false,
    this.color=ColorManager.primary,
    this.animatationDuration=const Duration(milliseconds: 500),
  });
  final VoidCallback onTap;
  final Widget child;
  final BoxDecoration? boxDecoration;
  final double? height;
  final double? width;
  final bool disabled;
  final Duration animatationDuration;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:disabled?null:onTap,
      child: DefaultTextStyle(
        style:Theme.of(context).textTheme.labelMedium!,
        child: AnimatedContainer(
          duration:animatationDuration,
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: _getBoxDecoration(),
          child:child,
        ),
      ),
    );
  }

  BoxDecoration _getBoxDecoration(){
    if(disabled){
      return BoxDecorationManager.solidWithBlur(ColorManager.grey.withOpacity(0.5));
    }
    return boxDecoration??BoxDecorationManager.solidWithBlur(color);
  }

}