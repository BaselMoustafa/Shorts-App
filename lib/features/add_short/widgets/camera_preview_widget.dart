import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shorts_app/features/add_short/screens/short_preview_screen.dart';
import 'package:shorts_app/core/camera/camera_initialization_states.dart';
import 'package:shorts_app/core/camera/camera_recording_states.dart';
import 'package:shorts_app/core/camera/custom_camera_controller.dart';
import 'package:shorts_app/core/managers/permission_handler_manager/permission_handler_manager.dart';
import 'package:shorts_app/core/managers/permission_handler_manager/permissions_list.dart';
import 'package:shorts_app/core/managers/navigator_manager.dart';
import 'package:shorts_app/core/widgets/custom_button.dart';
import 'package:shorts_app/core/widgets/exception_widget.dart';
import 'package:shorts_app/core/widgets/loading_widget.dart';

class CameraPreviewWidget extends StatefulWidget {
  const CameraPreviewWidget({super.key});

  @override
  State<CameraPreviewWidget> createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    CustomCameraController.instance.initCameraController();
    CustomCameraController.instance.addListener(() async{
      if(!mounted){
        return;
      }
      CameraRecordingStates state= CustomCameraController.instance.recordingState;
      if(state is RecordingStopped){
        NavigatorManager.push(context: context, widget: ShortPreviewScreen(videoFile:state.videoFile));
        return;
      }
      setState(() {
        
      });
    });
  }

  @override
  void dispose() {
    CustomCameraController.instance.disposeCameraController();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    CustomCameraController.instance.onChangeAppState(state);
  }
  @override
  Widget build(BuildContext context) {
    CameraInitializationStates state=CustomCameraController.instance.initializationState;
    return FittedBox(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      fit: BoxFit.cover,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Builder(
          builder: (context) {
            if(state is CameraInitializationLoading)
            return  LoadingWidget();
            if(state is CameraInitializationSuccess)
            return CameraPreview(CustomCameraController.instance.cameraController);
            if(state is CameraInitializationFailed)
            return _ExceptionWidget(cameraInitializationFailed: state);
            return SizedBox();
          },
        ),
      ),
    );
  }
}

class _ExceptionWidget extends StatelessWidget {
  final CameraInitializationFailed cameraInitializationFailed;
  const _ExceptionWidget({required this.cameraInitializationFailed});

  @override
  Widget build(BuildContext context) {
    return ExceptionWidget(
      message: cameraInitializationFailed.message,
      actionWidget: cameraInitializationFailed.dueToPermissions?const _RequestPermissionsButton():const _TryAgainButton(),
    );
  }
}

class _RequestPermissionsButton extends StatelessWidget {
  const _RequestPermissionsButton();
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: ()=>PermissionHandlerManager.excuteAfterCheckPermission(
        toExcute: ()=>CustomCameraController.instance.initCameraController(),
        permissionsList:const PermissionsList(permissions: [Permission.microphone,Permission.camera]), 
      ),
      child:const Text("Give Us The Permissions"), 
    );
  }
}

class _TryAgainButton extends StatelessWidget {
  const _TryAgainButton();
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: ()=>CustomCameraController.instance.initCameraController(),
      child:const Text("Try Again"), 
    );
  }
}
