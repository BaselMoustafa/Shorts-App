import 'package:flutter/material.dart';
import 'package:shorts_app/core/managers/color_manager.dart';
import 'package:video_player/video_player.dart';

class ShortVideoIndicator extends StatelessWidget {
  const ShortVideoIndicator({super.key,required this.videoController});
  final VideoPlayerController videoController;
  @override
  Widget build(BuildContext context) {
    return VideoProgressIndicator(
      videoController, 
      allowScrubbing: true,
      padding:const EdgeInsets.only(bottom: 10),
      colors:VideoProgressColors(
        playedColor: ColorManager.white,
        bufferedColor: Colors.grey.withOpacity(0.5),
        backgroundColor: ColorManager.grey,
      ),
    );
  }
}