import 'package:flutter/material.dart';
import 'package:shorts_app/core/models/image_details.dart';
import 'package:shorts_app/features/profile/widget/add_or_remove_image_bottom_sheet.dart';
import 'package:shorts_app/features/profile/widget/pick_image_options_bottom_sheet.dart';
import '../../../core/managers/color_manager.dart';

class EditProfileImageButton extends StatelessWidget {
  const EditProfileImageButton({super.key,required this.imageDetailsValueNotifier});
  final ValueNotifier<ImageDetails?>imageDetailsValueNotifier;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>_onTap(context),
      child:const CircleAvatar(
        radius: 23,
        backgroundColor: ColorManager.white,
        child: Center(
          child: CircleAvatar(
            radius: 21,
            backgroundColor: ColorManager.primary,
            child: Icon(Icons.edit,color: ColorManager.white,),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context){
    showModalBottomSheet(
      context: context, 
      builder: (context)=>imageDetailsValueNotifier.value!=null?
        AddOrRemoveImageBottomSheet(imageDetailsValueNotifier: imageDetailsValueNotifier)
        :PickImageOptionsBottomSheet(imageDetailsValueNotifier: imageDetailsValueNotifier),
    );
  }
}