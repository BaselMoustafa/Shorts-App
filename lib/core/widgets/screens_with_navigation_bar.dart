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
  late final PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController=PageController();
    
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: _screens,
          ),
        ),
        _NavigationBarWidget(
          height: widget.height,
          widget: widget,
          pageController: _pageController,
        ),
      ],
    );
  }

  
}

class _NavigationBarWidget extends StatefulWidget {
  const _NavigationBarWidget({required this.height,required this.pageController,required this.widget});
  final double height;
  final PageController pageController;
  final ScreensWithNavigationBar widget;
  @override
  State<_NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<_NavigationBarWidget> {
  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for(int i=0;i<widget.widget.navigationBarItemsInfo.length;i++)
          InkWell(
            onTap:()=>_onTap(i),
            child: _NavigationBarItemWidget(
              widget: widget.widget,
              isSelected: i==_selectedIndex, 
              navigationBarItemInfo: widget.widget.navigationBarItemsInfo[i], 
            ),
          ),
        ],
      ),
    );
  }

  void _onTap(int index){
    widget.widget.onChangeSelectedIndex?.call(index);
    _selectedIndex=index;
    widget.pageController.animateToPage(
      _selectedIndex, 
      duration: const Duration(milliseconds: 750), 
      curve: Curves.ease,
    );
    setState(() {});
  }
}

class _NavigationBarItemWidget extends StatelessWidget {
  
  final bool isSelected;
  final NavigationBarItemInfo navigationBarItemInfo;
  final ScreensWithNavigationBar widget;
  
  const _NavigationBarItemWidget({
    required this.navigationBarItemInfo,
    required this.isSelected,
    required this.widget,
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
              color:isSelected?widget.activeIconColor: widget.deactiveIconColor,
            ),
            const SizedBox(height: 2,),
            Text(
              navigationBarItemInfo.name,
              style: TextStyle(
                fontSize: 12,
                color:isSelected?widget.activeIconColor: widget.deactiveIconColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
