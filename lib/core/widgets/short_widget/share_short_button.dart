import 'package:flutter/material.dart';
import 'package:shorts_app/core/widgets/short_widget/base_short_action_button.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';

class ShareShortButton extends StatelessWidget {
  const ShareShortButton({super.key,required this.short});
  final Short short;
  @override
  Widget build(BuildContext context) {
    return BaseShortActionButton(
      onTap: _onTap, 
      text: "Share", 
      icon: Icon(Icons.share,size: 35,),
    );
  }

  void _onTap(){}
}