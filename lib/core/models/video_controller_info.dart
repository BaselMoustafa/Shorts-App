import 'dart:io';
import 'package:video_player/video_player.dart';


abstract class VideoInfo {

  const VideoInfo();

  VideoPlayerController createVideoController();
}

class FileVideoInfo implements VideoInfo{
  final File file;
  const FileVideoInfo({required this.file});
  
  @override
  VideoPlayerController createVideoController()=>VideoPlayerController.file(file);
}

class UrlVideoInfo implements VideoInfo{
  final String url;
  const UrlVideoInfo({required this.url});
  
  @override
  VideoPlayerController createVideoController()=>VideoPlayerController.networkUrl(Uri.parse(url));
}

class AssetVideoInfo implements VideoInfo{
  final String path;
  const AssetVideoInfo({required this.path});
  
  @override
  VideoPlayerController createVideoController()=>VideoPlayerController.asset(path);
}


