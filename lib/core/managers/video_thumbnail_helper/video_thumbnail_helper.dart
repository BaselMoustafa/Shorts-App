import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:shorts_app/core/managers/files_manager/files_manager.dart';
import 'package:shorts_app/core/managers/path_provider_manager/path_provider_manager.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoThumbnailHelper{

  Future<void>createFromUrl({
    required String url,
    required VoidCallback onError,
    required void Function(File thumbnailFile) whenComplete,
  })async{
    try {
      final String? filePath = await VideoThumbnail.thumbnailFile(
        video: url,
        imageFormat: ImageFormat.JPEG,
        thumbnailPath:"${await PathProviderManager.temporaryDirectory}/${Random().nextInt(999999999)}.jpg",
        quality: 100,
      );
      if(filePath==null){
        onError();
        return ;
      }
      whenComplete.call(File(filePath));
    } catch (e) {
      onError();
    }    
  }

  Future<void> createFromFile({
    required File videoFile,
    required VoidCallback onError,
    required void Function(File thumbnailFile) whenComplete,
  })async{
    try {
      final Uint8List? uint8list = await VideoThumbnail.thumbnailData(
        video: videoFile.path,
        imageFormat: ImageFormat.JPEG,
        quality: 100,
      );
      if(uint8list==null){
        onError();
        return;
      }
      File imageFile=await FilesManager.saveBytes(bytes: uint8list.toList(),extension: "jpg");
      whenComplete.call(imageFile);
    } catch (e) {
      onError();
    }
  }

}