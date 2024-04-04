import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shorts_app/core/widgets/short_widget/short_video_indicator.dart';
import 'package:shorts_app/core/widgets/short_widget/short_video_widget.dart';
import 'package:shorts_app/core/managers/color_manager.dart';
import 'package:video_player/video_player.dart';

class ShortPreviewScreen extends StatefulWidget {
  const ShortPreviewScreen({super.key,required this.videoFile});
  final File videoFile ;

  @override
  State<ShortPreviewScreen> createState() => _ShortPreviewScreenState();
}

class _ShortPreviewScreenState extends State<ShortPreviewScreen> {
  late final VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController=VideoPlayerController.file(widget.videoFile);
    
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorManager.transparent,
      ),
      body: Stack(
        children: [
          ShortVideoWidget(
            videoController: _videoController,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ShortVideoIndicator(videoController: _videoController),
          )
        ],
      ),
    );
  }
}