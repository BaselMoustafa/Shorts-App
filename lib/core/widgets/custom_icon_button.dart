import 'package:flutter/material.dart';
import 'package:shorts_app/core/managers/box_decoration_manager.dart';
import 'package:shorts_app/core/managers/color_manager.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key,this.size,this.iconColor,required this.onTap,required this.iconData,this.buttonDecoration,this.iconSize});
  final IconData iconData;
  final VoidCallback onTap;
  final double? iconSize;
  final BoxDecoration? buttonDecoration;
  final Color? iconColor;
  final double?size;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        height: size??40,
        width: size??40,
        decoration: buttonDecoration??BoxDecorationManager.solidWithBlur(ColorManager.primary),
        child: Center(
          child: Icon(
            iconData,
            color: iconColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}