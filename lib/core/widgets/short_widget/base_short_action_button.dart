import 'package:flutter/material.dart';

class BaseShortActionButton extends StatelessWidget {
  const BaseShortActionButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon, 
  });
  final VoidCallback onTap;
  final Icon icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: GestureDetector(
        onTap:onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(height: 4,),
            Text(text,style: Theme.of(context).textTheme.headlineSmall,),
          ],
        ),
      ),
    );
  }
}
