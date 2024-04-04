import 'package:flutter/material.dart';
import 'package:shorts_app/core/widgets/display_image_screen.dart';
import 'package:shorts_app/features/profile/widget/edit_profile_image_button.dart';
import '../../../../core/Widgets/profile_image_widget.dart';
import '../../../core/managers/navigator_manager.dart';
import '../../../core/models/image_details.dart';

class EditableProfileImageWidget extends StatefulWidget {
  const EditableProfileImageWidget({super.key,required this.imageDetailsValueNotifier});
  final ValueNotifier<ImageDetails?>imageDetailsValueNotifier;
  @override
  State<EditableProfileImageWidget> createState() => _EditableProfileImageWidgetState();
}

class _EditableProfileImageWidgetState extends State<EditableProfileImageWidget> {
 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          _ProfileImageWidget(imageDetailsValueNotifier:widget.imageDetailsValueNotifier ,),
          PositionedDirectional(
            bottom:0,
            end: 0,
            child: EditProfileImageButton(
              imageDetailsValueNotifier:widget.imageDetailsValueNotifier ,
            ),
          )
        ],
      ),
    );
  }
}

class _ProfileImageWidget extends StatelessWidget {
  const _ProfileImageWidget({required this.imageDetailsValueNotifier});
  final ValueNotifier<ImageDetails?> imageDetailsValueNotifier;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: imageDetailsValueNotifier, 
      builder: (context, value, child) {
        return GestureDetector(
          onTap: ()=>_onTap(context),
          child: ProfileImageWidget(
            radius: 75,
            imageDetails: imageDetailsValueNotifier.value,
          ),
        );
      },
    );
  }

  void _onTap(BuildContext context) {
    if(imageDetailsValueNotifier.value!=null){
      NavigatorManager.push(
        context: context, 
        widget: DisplayImageScreen(imageDetails: imageDetailsValueNotifier.value!)
      );
    }     
  }
}

