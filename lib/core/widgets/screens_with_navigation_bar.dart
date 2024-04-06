import 'package:flutter/material.dart';

import '../managers/color_manager.dart';

class NavigationBarItemInfo {
  final String name;
  final IconData iconData;
  final Widget screen;
  final bool extendBodyBehindNavigationBar;

  const NavigationBarItemInfo({
    required this.name,
    required this.iconData,
    required this.screen,
    this.extendBodyBehindNavigationBar=false,
  });
} 

class ScreensWithNavigationBar extends StatefulWidget {
  const ScreensWithNavigationBar({
    super.key,
    this.height=55,
    this.backgroundColor=ColorManager.red,
    this.activeIconColor=ColorManager.white,
    this.deactiveIconColor=ColorManager.grey,
    this.onChangeSelectedIndex,
    required this.navigationBarItemsInfo,
  });
  final double height;
  final Color backgroundColor;
  final Color activeIconColor;
  final Color deactiveIconColor;
  final void Function(int selectedIndex)?onChangeSelectedIndex;
  final List<NavigationBarItemInfo>navigationBarItemsInfo;

  @override
  State<ScreensWithNavigationBar> createState() => _ScreensWithNavigationBarState();
}

class _ScreensWithNavigationBarState extends State<ScreensWithNavigationBar> {

  int _selectedIndex=0;

  List<Widget> get _screens{
    List<Widget> screens=[];
    for (var i = 0; i < widget.navigationBarItemsInfo.length; i++) {
      screens.add(widget.navigationBarItemsInfo[i].screen);
    }
    return screens;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _screens[_selectedIndex],
        ),
        _NavigationBarWidget(
          parentWidget: widget,
          state: this,
        ),
      ],
    );
  }

  void _onChangeSelectedIndex(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  
}

class _NavigationBarWidget extends StatefulWidget {
  const _NavigationBarWidget({required this.parentWidget,required this.state});
  final ScreensWithNavigationBar parentWidget;
  final _ScreensWithNavigationBarState state;
  @override
  State<_NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<_NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for(int i=0;i<widget.parentWidget.navigationBarItemsInfo.length;i++)
          GestureDetector(
            onTap:()=>widget.state._onChangeSelectedIndex(i),
            child: _NavigationBarItemWidget(
              parentWidget: widget.parentWidget,
              isSelected: i==widget.state._selectedIndex, 
              navigationBarItemInfo: widget.parentWidget.navigationBarItemsInfo[i], 
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationBarItemWidget extends StatelessWidget {
  
  final bool isSelected;
  final NavigationBarItemInfo navigationBarItemInfo;
  final ScreensWithNavigationBar parentWidget;
  
  const _NavigationBarItemWidget({
    required this.navigationBarItemInfo,
    required this.isSelected,
    required this.parentWidget,
  });
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              navigationBarItemInfo.iconData,
              color:isSelected?parentWidget.activeIconColor: parentWidget.deactiveIconColor,
            ),
            const SizedBox(height: 2,),
            Text(
              navigationBarItemInfo.name,
              style: TextStyle(
                fontSize: 12,
                color:isSelected?parentWidget.activeIconColor: parentWidget.deactiveIconColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
