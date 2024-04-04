import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shorts_app/core/camera/custom_camera_controller.dart';
import 'package:shorts_app/core/constants/constants.dart';
import 'package:shorts_app/core/network/hive/hive_helper.dart';
import 'package:shorts_app/core/service_locator/service_locator.dart';
import 'package:shorts_app/core/widgets/get_my_person_bloc_builder.dart';
import 'package:shorts_app/features/authantication/presentation/screens/sign_in_screen.dart';
import 'package:shorts_app/firebase_options.dart';

import '../../../../core/managers/navigator_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initializeAppServices();
    _timer=Timer(
      const Duration(seconds: 3), 
      _onTimerFinished,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("SPLASH"),
      ),
    );
  }

  

  void _onTimerFinished(){
    NavigatorManager.pushAndRemoveUntil(
      context: context, 
      widget: getIt<HiveHelper>().get(boxName: KConst.dataBoxName, key: KConst.myPerson)==null?
        const SignInScreen():const GetMtPersonBlocBuilder(),
    );
  }

  Future<void> _initializeAppServices()async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await CustomCameraController.instance.initAvailableCameras();
    ServiceLocator().init();
    HiveHelper.init();
  }
}