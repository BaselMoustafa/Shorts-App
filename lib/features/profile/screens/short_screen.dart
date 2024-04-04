import 'package:flutter/material.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/core/widgets/short_widget/short_widget.dart';
import 'package:shorts_app/core/managers/color_manager.dart';

class ShortScreen extends StatelessWidget {
  const ShortScreen({super.key,required this.short});
  final Short short;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: ColorManager.transparent,),
      body:ShortWidget(
        short: short,
      ),
    );
  }
}