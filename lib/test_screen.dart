import 'package:flutter/material.dart';
import 'package:shorts_app/core/managers/color_manager.dart';
import 'package:shorts_app/core/widgets/comments_bottom_sheet/short_comments_bottom_sheet.dart';
import 'package:shorts_app/core/widgets/screens_with_navigation_bar.dart';
import 'package:shorts_app/dummy_short.dart';

import 'core/managers/navigator_manager.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {


  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      body:ScreensWithNavigationBar(
        navigationBarItemsInfo: [
          NavigationBarItemInfo(
            name: "Home", 
            iconData: Icons.home, 
            screen: Column(
              children: [
                const SizedBox(height: 100,),
                Builder(
                  builder: (context) {
                    return ElevatedButton(onPressed: (){
                      showBottomSheet(context: context, builder: (context)=>_BottomSheet());
                    }, child: Text("dsadhajbd"));
                  }
                )
              ],
            ),
          ),
          NavigationBarItemInfo(
            name: "Home", 
            iconData: Icons.home, 
            screen: Column(
              children: [
                const SizedBox(height: 100,),
                Builder(
                  builder: (context) {
                    return ElevatedButton(onPressed: (){
                      showBottomSheet(context: context, builder: (context)=>_BottomSheet());
                    }, child: Text("dsadhajbd"));
                  }
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context){
    showBottomSheet(
      backgroundColor: ColorManager.transparent,
      context: context, 
      builder: (context) =>const _BottomSheet(),
    );
  }

  
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => NavigatorManager.pop(context: context),
          child: Container(
            color: ColorManager.red,
            height:0.2* MediaQuery.of(context).size.height,
          ),
        ),
        const Spacer(),
        Container(height: 100,color: ColorManager.white,)
      ],
    );
  }
}