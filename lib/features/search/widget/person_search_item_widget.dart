import 'package:flutter/material.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person.dart';
import '../../../core/managers/color_manager.dart';
import '../../../core/managers/navigator_manager.dart';
import '../../../core/models/image_details.dart';
import '../../../core/widgets/profile_image_widget.dart';
import '../../profile/screens/profile_screen.dart';

class PersonSearchItemWidget extends StatelessWidget {
  const PersonSearchItemWidget({super.key,required this.person});
  final Person person;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>_onTap(context),
      child: _WidgetDesign(person: person),
    );
  }

  void _onTap(BuildContext context){
    NavigatorManager.push(
      context: context, 
      widget: ProfileScreen(
        asScaffold: true,
        person: person,
      ),
    );
  }
}

class _WidgetDesign extends StatelessWidget {
  const _WidgetDesign({required this.person});

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileImageWidget(
          radius: 25,
          imageDetails: person.image==null?null:NetworkImageDetails(url: person.image!),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Text(
            person.name,
            style: const TextStyle(
              fontSize: 16,
              color: ColorManager.white
            ),
          ),
        ),
      ],
    );
  }
}