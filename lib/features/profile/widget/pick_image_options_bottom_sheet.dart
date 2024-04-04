import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shorts_app/core/image_picker_helper/image_picker_helper.dart';
import 'package:shorts_app/core/widgets/custom_bottom_sheet.dart';
import 'package:shorts_app/core/widgets/custom_button.dart';
import '../../../core/managers/navigator_manager.dart';
import '../../../core/models/image_details.dart';

class PickImageOptionsBottomSheet extends StatelessWidget {
  const PickImageOptionsBottomSheet({super.key,required this.imageDetailsValueNotifier});
  final ValueNotifier<ImageDetails?>imageDetailsValueNotifier;
  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      children:[
        _ImageSourceButton(
          isFromCamera: true,
          imageDetailsValueNotifier: imageDetailsValueNotifier, 
        ),
        const SizedBox(height: 10,),
        _ImageSourceButton(
          isFromCamera: false,
          imageDetailsValueNotifier: imageDetailsValueNotifier, 
        ),
      ],
    );
  }
}

class _ImageSourceButton extends StatelessWidget {
  final bool isFromCamera;
  final ValueNotifier<ImageDetails?>imageDetailsValueNotifier;
  const _ImageSourceButton({
    required this.imageDetailsValueNotifier,
    required this.isFromCamera,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: ()=>_onTap(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isFromCamera?Icons.camera:Icons.image,
          ),
          const SizedBox(width: 10,),
          Text(
            isFromCamera?"Pick From Camera":"Pick From Gallery"
          ),
        ],
      ), 
    );
  }

  void _onTap(BuildContext context) {
    NavigatorManager.pop(context: context);
    ImagePickerHelper().pickImage(
      source: isFromCamera?ImageSource.camera:ImageSource.gallery, 
      onImagePicked: (imageFile) {
        imageDetailsValueNotifier.value=FileImageDetails(imageFile: imageFile);
      },
    );
  }
}