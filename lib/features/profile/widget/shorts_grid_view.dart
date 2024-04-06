import 'package:flutter/cupertino.dart';
import 'package:shorts_app/core/models/video_controller_info.dart';
import 'package:shorts_app/core/widgets/short_preview_widget.dart';
import 'package:shorts_app/core/widgets/there_are_no_widget.dart';
import '../../../core/managers/navigator_manager.dart';
import '../../../dependancies/shorts/domain/models/short.dart';
import '../screens/short_screen.dart';

class ShortsGridView extends StatelessWidget {
  const ShortsGridView({super.key,required this.shorts});
  final List<Short>shorts;
  @override
  Widget build(BuildContext context) {
    if(shorts.isEmpty){
      return const ThereAreNoWidget(label: "Shorts",);
    }
    return GridView.builder(
      shrinkWrap: true,
      itemCount: shorts.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.6,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index){
        return GestureDetector(
          onTap: () => _onTap(context,index),
          child: ShortPreviewWidget(
            videoInfo: UrlVideoInfo(url: shorts[index].url),
            onTap: ()=>_onTap(context,index),
          )
        );
      },
    );
  }

  void _onTap(BuildContext context,int index) {
    NavigatorManager.push(
      context: context, 
      widget:ShortScreen(short: shorts[index]),
    );        
  }
}