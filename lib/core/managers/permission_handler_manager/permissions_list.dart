import 'package:permission_handler/permission_handler.dart';

class PermissionsList {
  final List<Permission>permissions;

  const PermissionsList({required this.permissions});

  Future<bool> get isGranted async{
    for (var i = 0; i < permissions.length; i++) {
      if( ! await permissions[i].isGranted){
        return false;
      }
    }
    return true;
  } 

  Future<bool> get isPermanentlyDenied async{
    for (var i = 0; i < permissions.length; i++) {
      if( await permissions[i].isPermanentlyDenied){
        return true;
      }
    }
    return false;
  } 

  Future<void> request() async{
    await permissions.request();
  }
}