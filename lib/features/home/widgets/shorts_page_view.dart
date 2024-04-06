import 'package:flutter/material.dart';

class ShortsPageView extends StatefulWidget  {
  const ShortsPageView({super.key,required this.pageController,required this.children,});
  final PageController pageController;
  final List<Widget>children;
  @override
  State<ShortsPageView> createState() => _ShortsPageViewState();
}

class _ShortsPageViewState extends State<ShortsPageView> {

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget.pageController,
      scrollDirection: Axis.vertical,
      children: widget.children,
    );
  }
}