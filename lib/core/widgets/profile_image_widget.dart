import 'package:flutter/material.dart';
import 'package:shorts_app/core/widgets/shimer_widget.dart';
import '../managers/color_manager.dart';
import '../models/image_details.dart';

class ProfileImageWidget extends StatelessWidget {
  final double radius;
  final ImageDetails? imageDetails;
  const ProfileImageWidget({super.key,this.imageDetails,this.radius=22});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2*radius,
      width: 2*radius,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration:const BoxDecoration(
        color: ColorManager.primary,
        shape: BoxShape.circle,
      ),
      child: _ImageWidget(radius: radius,imageDetails:imageDetails),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    required this.radius,
    required this.imageDetails,
  });
  final ImageDetails? imageDetails;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Center(
      child:  AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child:imageDetails==null?
          _PlaceHolder(iconSize: radius,)
          :Image(
            image: imageDetails!.imageProvider,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              return child;
              },
            loadingBuilder: (context, child, loadingProgress) {
              if(loadingProgress==null){
                return child;
              }
              return ShimmerWidget.circular(
                radius: radius,
              );
            }
          ),
    ),
    );
  }
}

class _PlaceHolder extends StatelessWidget {
  const _PlaceHolder({
    required this.iconSize,
  });
  final double iconSize; 

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.person,
      size: iconSize,
    );
  }
}