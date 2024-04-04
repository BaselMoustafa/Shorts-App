import 'package:flutter/material.dart';
import 'package:shorts_app/core/models/image_details.dart';

import '../managers/color_manager.dart';

class DisplayImageScreen extends StatefulWidget {
  const DisplayImageScreen({super.key,required this.imageDetails});
  final ImageDetails imageDetails;
  @override
  State<DisplayImageScreen> createState() => _DisplayImageScreenState();
}

class _DisplayImageScreenState extends State<DisplayImageScreen> with SingleTickerProviderStateMixin{
  
  late final AnimationController _animationController;
  late Animation<Matrix4> _animation;
  late final TransformationController _transformationController;
  late TapDownDetails  _tapDownDetails;

  @override
  void initState() {
    super.initState();
    _transformationController=TransformationController();
    _animationController=AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() {
      _transformationController.value=_animation.value;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorManager.transparent,
        elevation: 0,
      ),
      body: GestureDetector(
        onDoubleTapDown: (details)=>_tapDownDetails=details,
        onDoubleTap:_onDoubleTap,
        child: InteractiveViewer(
          maxScale: 4,
          transformationController: _transformationController,
          child: Image(
            image: widget.imageDetails.imageProvider,
            height: double.infinity,
          ),
        ),
      ),
    );
  }

  void _onDoubleTap() {
    double scale=3;
    Matrix4 begin=_transformationController.value;
    if(_transformationController.value.isIdentity()){
      Matrix4 end= Matrix4.copy(_transformationController.value)
      ..translate(-_tapDownDetails.localPosition.dx*(scale-1),-_tapDownDetails.localPosition.dy*(scale-1))
      ..scale(scale);
      _animation=Matrix4Tween(begin: begin,end: end).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn)
      );
      _animationController.forward(from: 0);
    }else{
      Matrix4 end=Matrix4.identity();
      _animation=Matrix4Tween(begin: begin,end: end).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn)
      );
      _animationController.forward(from: 0);
    }
  }
}