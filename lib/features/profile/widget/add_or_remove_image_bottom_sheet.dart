import 'package:flutter/material.dart';
import 'package:shorts_app/core/widgets/custom_bottom_sheet.dart';
import 'package:shorts_app/core/widgets/custom_button.dart';
import 'package:shorts_app/features/profile/widget/pick_image_options_bottom_sheet.dart';
import '../../../core/managers/navigator_manager.dart';
import '../../../core/models/image_details.dart';

class AddOrRemoveImageBottomSheet extends StatelessWidget {
  const AddOrRemoveImageBottomSheet({super.key,required this.imageDetailsValueNotifier});
  final ValueNotifier<ImageDetails?>imageDetailsValueNotifier;
  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      children:[
        _AddOrRemoveButton(
          isForAdd: true,
          imageDetailsValueNotifier: imageDetailsValueNotifier, 
        ),
        const SizedBox(height: 10,),
        _AddOrRemoveButton(
          isForAdd: false,
          imageDetailsValueNotifier: imageDetailsValueNotifier, 
        ),
      ],
    );
  }
}

class _AddOrRemoveButton extends StatelessWidget {
  final bool isForAdd;
  final ValueNotifier<ImageDetails?>imageDetailsValueNotifier;
  const _AddOrRemoveButton({
    required this.imageDetailsValueNotifier,
    required this.isForAdd,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: ()=>_onTap(context),
      child: Text(
        isForAdd?"Add Image":"Remove Image"
      ), 
    );
  }

  void _onTap(BuildContext context) {
    NavigatorManager.pop(context: context);
    if(isForAdd==false){
      imageDetailsValueNotifier.value=null;
      return ;
    }
    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return PickImageOptionsBottomSheet(
          imageDetailsValueNotifier: imageDetailsValueNotifier,
        );
      },
    );
  }
}