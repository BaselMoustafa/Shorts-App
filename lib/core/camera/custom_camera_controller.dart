import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shorts_app/core/camera/camera_initialization_states.dart';
import 'package:shorts_app/core/camera/camera_recording_states.dart';
import 'package:shorts_app/core/managers/files_manager/files_manager.dart';

class CustomCameraController extends ChangeNotifier{

  static final CustomCameraController instance =CustomCameraController._private();
  CustomCameraController._private();

  late CameraController _cameraController;

  late final List<CameraDescription> cameras;
  late CameraDescription _selectedCamera=cameras[0];

  late Timer _videoTimer;
  ValueNotifier<Duration> recordedDuration =ValueNotifier(Duration.zero);

  CameraInitializationStates initializationState=const CameraInitializationInitialState();
  CameraRecordingStates recordingState =const IsNotRecording();

  Future<void>initAvailableCameras()async {
    cameras= await availableCameras();
  }

  CameraController get cameraController=>_cameraController;
  
  void initCameraController([CameraDescription? cameraDescription]){
    initializationState=const CameraInitializationLoading();
    notifyListeners();
    _cameraController=CameraController(cameraDescription??cameras[0],ResolutionPreset.high)
    ..initialize().then((_) {
      initializationState= const CameraInitializationSuccess();
      notifyListeners();
    }).catchError((Object e) {
      initializationState=CameraInitializationFailed(
        message: e is CameraException?e.description??"Failed To Access Camera":"Failed To Access Camera",
        dueToPermissions: e is CameraException && e.code=='CameraAccessDenied',
      );
      notifyListeners();
    });
  }

  void disposeCameraController(){
    _cameraController.dispose();
  }

  void onChangeAppState(AppLifecycleState state){
    if(! cameraController.value.isInitialized){
      return ;
    }
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCameraController(_selectedCamera);
    }
  }

  void startRecord({int? maxSeconds }){
    _cameraController.startVideoRecording().then((value){
      _startVideoTimer();
      recordingState=const RecordingStarted();
      notifyListeners();
    }).catchError((Object e) {
      recordingState=RecordingFailed(
        message: e is CameraException?e.description??"Failed To Record Video":"Failed To Record Video",
        dueToPermissions: e is CameraException && e.code=='CameraAccessDenied',
      );
      notifyListeners();
    });
  }

  Future<void> stopRecord()async{
    _stopVideoTimer();
    XFile xFile= await _cameraController.stopVideoRecording();
    await FilesManager.saveFile(file: File(xFile.path),fileName: "video");
    recordingState=RecordingStopped(videoFile: File(xFile.path));
    
    notifyListeners();
    recordingState=const IsNotRecording();
    notifyListeners();
  }

  void _startVideoTimer({int? maxSeconds}){
    _videoTimer = Timer.periodic(
      const Duration(seconds: 1), 
      (timer) {
        recordedDuration.value=Duration(seconds: timer.tick);
        if(maxSeconds!=null && maxSeconds==timer.tick){
          stopRecord();
        }
      },
    );
  }

  void _stopVideoTimer(){
    _videoTimer.cancel();
    recordedDuration.value=Duration.zero;
  }
}