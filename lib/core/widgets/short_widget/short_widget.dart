import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shorts_app/core/models/video_controller_info.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/core/widgets/short_widget/short_actions_widget.dart';
import 'package:shorts_app/core/widgets/short_widget/short_info_widget.dart';
import 'package:shorts_app/core/widgets/short_widget/short_video_indicator.dart';
import 'package:shorts_app/core/widgets/short_widget/short_video_widget.dart';
import 'package:video_player/video_player.dart';

class ShortWidget extends StatefulWidget {
  const ShortWidget({super.key,required this.short});
  final Short short;

  @override
  State<ShortWidget> createState() => _ShortWidgetState();
}

class _ShortWidgetState extends State<ShortWidget> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController=UrlVideoInfo(url: widget.short.url).createVideoController();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ShortVideoWidget(videoController:_videoController),
        ),
        ShortInfoWidget(short:widget.short),
        ShortActionsWidget(short:widget.short),
        Align(
          alignment: Alignment.bottomCenter,
          child: ShortVideoIndicator(videoController: _videoController)
        ),
      ],
    );
  }
  
}


