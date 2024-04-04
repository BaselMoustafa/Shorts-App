import 'package:flutter/material.dart';

import '../../../../core/managers/color_manager.dart';

class OrLineWidget extends StatelessWidget {
  const OrLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: 1,
          color: ColorManager.grey,
        )),
        const Text(
          "OR",
          style: TextStyle(fontSize: 18, color: ColorManager.grey),
        ),
        Expanded(
            child: Container(
          height: 1,
          color: ColorManager.grey,
        )),
      ],
    );
  }
}