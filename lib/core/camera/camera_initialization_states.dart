abstract class CameraInitializationStates{
  const CameraInitializationStates();
}

class CameraInitializationInitialState extends CameraInitializationStates{
  const CameraInitializationInitialState();
}

class CameraInitializationSuccess extends CameraInitializationStates{
  const CameraInitializationSuccess();
}

class CameraInitializationLoading extends CameraInitializationStates{
  const CameraInitializationLoading();
}

class CameraInitializationFailed extends CameraInitializationStates{
  final bool dueToPermissions;
  final String message;
  const CameraInitializationFailed({required this.dueToPermissions,required this.message});
}