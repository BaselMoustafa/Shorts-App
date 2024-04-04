import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key,required this.children});
  final List<Widget>children;
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      children:children,
    );
  }
}