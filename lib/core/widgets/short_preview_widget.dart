import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shorts_app/core/models/video_controller_info.dart';
import 'package:shorts_app/core/managers/box_decoration_manager.dart';
import 'package:shorts_app/core/managers/color_manager.dart';
import 'package:shorts_app/core/managers/video_thumbnail_helper/video_thumbnail_helper.dart';
import 'package:shorts_app/core/widgets/exception_widget.dart';
import 'package:shorts_app/core/widgets/shimer_widget.dart';

class ShortPreviewWidget extends StatefulWidget {
  const ShortPreviewWidget({super.key,required this.videoInfo,required this.onTap});
  final VideoInfo videoInfo;
  final VoidCallback onTap;
  @override
  State<ShortPreviewWidget> createState() => _ShortPreviewWidgetState();
}

class _ShortPreviewWidgetState extends State<ShortPreviewWidget> {
  late bool _failed;
  File? _thumbnailFile;

  @override
  void initState() {
    super.initState();
    _failed=false;
    _initializeThumbnail();
  }
  
  @override
  Widget build(BuildContext context) {
    return  AspectRatio(
      aspectRatio: 0.6,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecorationManager.solid.copyWith(color: ColorManager.transparent),
        child: Builder(
          builder: (context) {
            if(_failed){
              return const _ExceptionWidget();
            }
            if(_thumbnailFile==null){
              return const _LoadingWiget();
            }
            return _FileImageWidget(file: _thumbnailFile!,onTap: widget.onTap,);
          },
        ),
      ),
    );
  }

  void _initializeThumbnail(){
    final VideoInfo videoInfo=widget.videoInfo;
    if(videoInfo is FileVideoInfo){
      VideoThumbnailHelper().createFromFile(videoFile: videoInfo.file, whenComplete: _refresh,onError: _onError);
    }
    else if(videoInfo is UrlVideoInfo){
      VideoThumbnailHelper().createFromUrl(url: videoInfo.url, whenComplete: _refresh,onError:_onError);
    }
  }

  void _refresh(File thumbnailFile){
    _thumbnailFile=thumbnailFile;
    setState(() {});
  }

  void _onError(){
    _failed=true;
    setState(() {});
  }
}

class _LoadingWiget extends StatelessWidget {
  const _LoadingWiget();

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget.rectangle(
      baseColor: ColorManager.grey.withOpacity(0.5),
      highlightColor: ColorManager.white.withOpacity(0.5),
    );
  }
}

class _ExceptionWidget extends StatelessWidget {
  const _ExceptionWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorationManager.outlined,
      child:const Center(
        child: ExceptionWidget(
          widget: Icon(Icons.error) ,
          message: "failed to load",
        ),
      ),
    );
  }
}

class _FileImageWidget extends StatelessWidget {
  const _FileImageWidget({required this.file,required this.onTap});
  final File file;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.file(
        file,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}