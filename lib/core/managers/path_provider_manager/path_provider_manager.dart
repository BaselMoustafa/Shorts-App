import 'dart:io';
import 'package:path_provider/path_provider.dart';

abstract class PathProviderManager{
  
  static Future<String> get temporaryDirectory async{
    Directory directory= await getTemporaryDirectory();
    return directory.path;
  }

  static Future<String> get applicationDocumentsDirectory async{
    Directory directory= await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> get applicationSupportDirectory async{
    Directory directory= await getApplicationSupportDirectory();
    return directory.path;
  }

  static Future<String> get applicationCacheDirectory async{
    Directory directory= await getApplicationCacheDirectory();
    return directory.path;
  }

  static Future<String?> get externalStorageDirectory async{
    if(Platform.isAndroid){
      Directory? directory= await getExternalStorageDirectory();
      return directory!=null?directory.path:null;
    }
    return null;
  }

  static Future<List<String>?> get externalStorageDirectories async{
    if(Platform.isAndroid){
      List<Directory>? directories= await getExternalStorageDirectories();
      if(directories==null){
        return null;
      }
      List<String>toReturn=[];
      for (var i = 0; i < directories.length; i++) {
        toReturn.add(directories[i].path);
      }
      return toReturn;
    }
    return null;
  }

  static Future<List<String>?> get externalCacheDirectories async{
    if(Platform.isAndroid){
      List<Directory>? directories= await getExternalCacheDirectories();
      if(directories==null){
        return null;
      }
      List<String>toReturn=[];
      for (var i = 0; i < directories.length; i++) {
        toReturn.add(directories[i].path);
      }
      return toReturn;
    }
    return null;
  }

  static Future<String?> get downloadsDirectory async{
    if(Platform.isAndroid){
      return null;
    }
    Directory? directory= await getDownloadsDirectory();
    return directory!=null?directory.path:null;
  }

}