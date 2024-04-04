import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shorts_app/core/image_picker_helper/image_picker_helper.dart';
import 'package:shorts_app/core/managers/box_decoration_manager.dart';
import 'package:shorts_app/core/managers/color_manager.dart';
import 'package:shorts_app/core/widgets/show_my_snackbar.dart';

class RecordVideoButton extends StatelessWidget {
  const RecordVideoButton({super.key,required this.maxDurationValueNotifier,required this.onVideoPicked});
  final void Function(File videoFile)onVideoPicked;
  final ValueNotifier<Duration>maxDurationValueNotifier;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: 75,
      child: InkWell(
        onTap: ()=>_onTap(context),
        child: const _ButtonDesign(),
      ),
    );
  }

  void _onTap(BuildContext context) {
    ImagePickerHelper().pickVideo(
      maxDuration: maxDurationValueNotifier.value,
      source: ImageSource.camera, 
      onVideoPicked: onVideoPicked,
      onError: (message){
        showMySnackBar(context: context, content: Text(message));
      }, 
    );
  }
}

class _ButtonDesign extends StatelessWidget {
  const _ButtonDesign();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecorationManager.outlinedCircle(borderWidth: 4,borderColor: ColorManager.red),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecorationManager.solidCircle.copyWith(color: ColorManager.red),
      ),
    );
  }
}