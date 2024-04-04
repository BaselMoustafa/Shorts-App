import 'dart:io';

abstract class CameraRecordingStates{
  const CameraRecordingStates();
}

class IsNotRecording extends CameraRecordingStates{
  const IsNotRecording();
}

class RecordingStarted extends CameraRecordingStates{
  const RecordingStarted();
}

class RecordingFailed extends CameraRecordingStates{
  final bool dueToPermissions;
  final String message;
  const RecordingFailed({required this.message,required this.dueToPermissions});
}

class RecordingStopped extends CameraRecordingStates{
  final File videoFile;
  const RecordingStopped({required this.videoFile});
}