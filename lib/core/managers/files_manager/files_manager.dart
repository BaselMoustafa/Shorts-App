import 'dart:io';
import 'dart:math';
import '../path_provider_manager/path_provider_manager.dart';
import 'file_path.dart';


abstract class FilesManager{

  static Future<File>saveFile({required File file,String? fileName})async{
    return await _save(
      bytes: await file.readAsBytes(), 
      targetPath:FilePath(
        fileName: fileName, 
        extension: _getFileExtension(file), 
        path: await PathProviderManager.applicationDocumentsDirectory,
      ),
    );
  }

  static Future<File>saveBytes({required List<int>bytes,required String extension,String? fileName})async{
    return await _save(
      bytes: bytes, 
      targetPath:FilePath(
        fileName: fileName, 
        extension: extension, 
        path:await PathProviderManager.applicationDocumentsDirectory,
      ),
    );
  }

  static Future<File>saveFileToDownloads({required File file,String? fileName})async{
    return await _save(
      bytes: await file.readAsBytes(), 
      targetPath:FilePath(
        fileName: fileName, 
        extension: _getFileExtension(file), 
        path: await _androidDownloadsPath,
      ),
    );
  }

  static Future<File>saveBytesToDownloads({required List<int>bytes,required String extension,String? fileName})async{
    return await _save(
      bytes: bytes, 
      targetPath:FilePath(
        fileName: fileName, 
        extension: extension, 
        path: await _androidDownloadsPath,
      ),
    );
  }

  static Future<File>_save({
    required List<int>bytes,
    required FilePath targetPath,
  })async{
    targetPath.fileName=targetPath.fileName??"${Random().nextInt(4294967296)}${DateTime.now()}";

    if(await File("${targetPath.path}/${targetPath.fileName}.${targetPath.extension}").exists()){
      int counter=1;
      while (await File("${targetPath.path}/${targetPath.fileName}($counter).${targetPath.extension}").exists()) {
        counter++;
      }
      targetPath.fileName="${targetPath.fileName!}($counter)";
    }
    
    return await File(
      "${targetPath.path}/${targetPath.fileName}.${targetPath.extension}",
    ).writeAsBytes(bytes);
  }

  static _getFileExtension(File file){
    String extension="";
    int i=file.path.length-1;
    while (file.path[i]!=".") {
      extension=file.path[i]+extension;
      i--;
    }
    return extension;
  }

  static Future<String> get _androidDownloadsPath async{
    String? externalStorageDirectory=await PathProviderManager.externalStorageDirectory;
    for (var i = 0; i < externalStorageDirectory!.length; i++) {
      if(_thisIndexStartAndroidWord(i, externalStorageDirectory)){
        externalStorageDirectory= externalStorageDirectory.substring(0,i);
        break;
      }
    }
    externalStorageDirectory+="Download";
    return externalStorageDirectory;
  }

  static bool _thisIndexStartAndroidWord(int index,String s){
    if(s[index]!="A"){
      return false;
    }
    if(s[index+1]!="n"){
      return false;
    }
    if(s[index+2]!="d"){
      return false;
    }
    if(s[index+3]!="r"){
      return false;
    }
    if(s[index+4]!="o"){
      return false;
    }
    if(s[index+5]!="i"){
      return false;
    }
    if(s[index+6]!="d"){
      return false;
    }
    return true;
  }
}