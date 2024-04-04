import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shorts_app/core/image_picker_helper/image_picker_helper.dart';
import 'package:shorts_app/core/widgets/show_my_snackbar.dart';

class PickVideoButton extends StatelessWidget {
  const PickVideoButton({super.key,required this.maxDurationValueNotifier,required this.onVideoPicked});
  final void Function(File videoFile)onVideoPicked;
  final ValueNotifier<Duration>maxDurationValueNotifier;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.image,size: 35,),
      onPressed: ()=>_onTap(context), 
    );
  }

  void _onTap(BuildContext context) {
    ImagePickerHelper().pickVideo(
      maxDuration: maxDurationValueNotifier.value,
      source: ImageSource.gallery, 
      onVideoPicked:onVideoPicked,
      onError: (message){
        showMySnackBar(context: context, content: Text(message));
      }, 
    );
  }
}