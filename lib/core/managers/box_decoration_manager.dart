import 'package:flutter/material.dart';
import 'color_manager.dart';

abstract class BoxDecorationManager{

  static BoxDecoration  solidRoundedTopOnly=const BoxDecoration(
    color: ColorManager.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  );

  static BoxDecoration  solid=BoxDecoration(
    color: ColorManager.white,
    borderRadius: BorderRadius.circular(10),
  );

  static BoxDecoration  outlined=BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      width: 2,
      color: ColorManager.white,
    ),
  );

  static BoxDecoration  solidWithBlur(Color color)=>BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    gradient:LinearGradient(
      begin:const Alignment(-1.00, -0.03),
      end: const Alignment(1, 0.03),
      colors:[color, color.withOpacity(0.8)],
    ),
    boxShadow: [
      BoxShadow(
        color: color,
        blurRadius: 5,
        offset:const Offset(0, 0),
        spreadRadius: 0,
      ),
    ],
  );

  static BoxDecoration solidCircle = const BoxDecoration(
    shape: BoxShape.circle,
    color: ColorManager.white,
  );

  static BoxDecoration outlinedCircle({Color borderColor=ColorManager.white,double borderWidth=2})=>BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(width: borderWidth,color: borderColor),
  );

  static BoxDecoration  solidcCircleWithBlur(Color color)=>BoxDecoration(
    shape: BoxShape.circle,
    gradient:LinearGradient(
      begin: const Alignment(-1.00, -0.03),
      end: const Alignment(1, 0.03),
      colors:[color, color],
    ),
    boxShadow:[
      BoxShadow(
        color: color,
        blurRadius: 5,
        offset:const Offset(0, 0),
        spreadRadius: 0,
      ),
    ],
  );
}