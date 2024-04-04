import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ImagePickerHelper{
  Future<void>pickImage({
    required ImageSource source,
    required void Function(File imageFile) onImagePicked,
  })async{
    XFile? xFile=await ImagePicker().pickImage(source: source);
    if(xFile==null){
      return ;
    }
    onImagePicked.call(File(xFile.path));
  }

  Future<void>pickVideo({
    Duration? maxDuration,
    required void Function(String message)onError,
    required ImageSource source,
    required void Function(File videoFile) onVideoPicked,
  })async{
    XFile? xFile=await ImagePicker().pickVideo(
      source: source,
      maxDuration:maxDuration,
    );
    if(xFile==null){
      return ;
    }
    File videoFile=File(xFile.path);
    if(maxDuration!=null &&source==ImageSource.gallery&&await _exccededMaxDuration(videoFile, maxDuration,onError)){
      return ;
    }
    onVideoPicked.call(videoFile);
  }

  Future<bool> _exccededMaxDuration(File videoFile, Duration maxDuration, void Function(String message) onError)async {
    VideoPlayerController controller= VideoPlayerController.file(videoFile);
    try {
      await controller.initialize();
      if(controller.value.duration.inSeconds>maxDuration.inSeconds){
        controller.dispose();
        onError("Video Exceeded Max Limit");
        return true;
      }
    } catch (e) {
      controller.dispose();
      return true;
    }  
    controller.dispose();  
    return false;
  }
}