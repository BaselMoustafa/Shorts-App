import 'package:permission_handler/permission_handler.dart';
import 'package:shorts_app/core/managers/permission_handler_manager/permissions_list.dart';

abstract class PermissionHandlerManager{
  static Future<void>excuteAfterCheckPermission({
    required PermissionsList permissionsList,
    required Function() toExcute,
  })async{
    
    if(await permissionsList.isGranted){
      await toExcute();
    }

    else if(await permissionsList.isPermanentlyDenied){
      openAppSettings();
    }

    else{
      await permissionsList.request();
      if(await permissionsList.isGranted){
        await toExcute();
      }
    }

  }
}