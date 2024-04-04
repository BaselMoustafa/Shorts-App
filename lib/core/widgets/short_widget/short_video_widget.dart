import 'package:flutter/material.dart';
import 'package:shorts_app/core/widgets/custom_button.dart';
import 'package:shorts_app/core/widgets/exception_widget.dart';
import 'package:video_player/video_player.dart';

class ShortVideoWidget extends StatefulWidget {
  const ShortVideoWidget({super.key,required this.videoController,this.playIt=true});
  final bool playIt;
  final VideoPlayerController videoController;
  @override
  State<ShortVideoWidget> createState() => _ShortVideoWidgetState();
}

class _ShortVideoWidgetState extends State<ShortVideoWidget> {

  bool _initializationFailed=false;

  @override
  void initState() {
    super.initState();
    _initializeVideoController();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child:_initializationFailed?
        _ExceptionWidget(reInitializeVideoController: _initializeVideoController,)
        :_VideoWidget(widget: widget),
    );
  }

  void _onTap() {
    if(_initializationFailed==false){
      widget.videoController.value.isPlaying?widget.videoController.pause():widget.videoController.play();
    }
  }

  void _initializeVideoController()async{
    
    widget.videoController.initialize()
    .onError((error, stackTrace) {
      setState(() {
        _initializationFailed=true;
      });
    })
    .then((value) {
      setState(() {});
    });

    if(widget.playIt){
      widget.videoController..setLooping(true);
    }
  }

}

class _VideoWidget extends StatelessWidget {
  const _VideoWidget({
    required this.widget,
  });

  final ShortVideoWidget widget;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:VideoPlayer(widget.videoController)
      ),
    );
  }
}

class _ExceptionWidget extends StatelessWidget {
  final VoidCallback reInitializeVideoController;
  const _ExceptionWidget({required this.reInitializeVideoController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ExceptionWidget(
        message: "Failed To Load This Story",
        actionWidget: CustomButton(
          onTap: reInitializeVideoController,
          child: const Text("Try Again"), 
        ),
      ),
    );
  }
}

