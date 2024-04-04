import 'package:flutter/material.dart';
import 'package:shorts_app/core/models/image_details.dart';
import 'package:shorts_app/core/widgets/profile_image_widget.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/features/profile/screens/profile_screen.dart';

import '../../managers/navigator_manager.dart';

class ShortInfoWidget extends StatelessWidget {
  const ShortInfoWidget({super.key,required this.short});
  final Short short;
  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      start: 10,
      bottom: 30,
      child:_WidgetDesign(short: short,),
    );
  }
}

class _WidgetDesign extends StatelessWidget {
  const _WidgetDesign({
    required this.short,
  });
  final Short short;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigatorManager.push(context: context, widget:ProfileScreen(person: short.from,asScaffold: true,),),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _ShortOwnerInfo(short: short,),
          
          if(short.caption!=null)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: _ShortDescribtion(short: short,),
          ),
        ],
      ),
    );
  }
}

class _ShortOwnerInfo extends StatelessWidget {
  const _ShortOwnerInfo({required this.short});
  final Short short;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileImageWidget(
          imageDetails: short.from.image==null?null:NetworkImageDetails(url: short.from.image!),
        ),
        const SizedBox(width: 8,),
        Text(short.from.name,style: Theme.of(context).textTheme.headlineLarge,),
      ],
    );
  }
}

class _ShortDescribtion extends StatelessWidget {
  const _ShortDescribtion({required this.short});
  final Short short;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width-40,
      child: Text(
        short.caption??"",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}



