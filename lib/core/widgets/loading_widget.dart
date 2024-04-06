
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../managers/assets_manager.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   Center(
      child: SizedBox(
        height: 75,
        width: 75,
        child: Lottie.asset(AssetsManager.loading),
      ),
    );
  }
}