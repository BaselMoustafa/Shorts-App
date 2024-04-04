import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../managers/color_manager.dart';

class ShimmerWidget extends StatelessWidget{

  final double _height;
  final double _width;
  final ShapeBorder _shape;
  final Color baseColor;
  final Color highlightColor;

  const ShimmerWidget.circular({
    super.key,
    double radius=20,
    this.baseColor=ColorManager.grey,
    this.highlightColor=ColorManager.white,
  }):_height=2*radius,_width=2*radius,_shape=const CircleBorder();

  ShimmerWidget.rectangle({
    super.key,
    double height=10,
    double width=double.infinity,
    this.baseColor=ColorManager.grey,
    this.highlightColor=ColorManager.white,
    BorderRadius borderRadius=BorderRadius.zero,
  }):_height=height,_width=width,_shape=RoundedRectangleBorder(borderRadius: borderRadius);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor, 
      highlightColor: highlightColor,
      child: Container(
        height: _height,
        width: _width,
        decoration: ShapeDecoration(
          shape: _shape,
          color: ColorManager.grey
        ),
      ), 
    );
  }
} 