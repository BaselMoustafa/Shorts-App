import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'cloud_storage_reference/cloud_storage_reference.dart';

class CloudStorageHelper {

  Future<String> uploadFile({required File file, required List<String> path}) async{
    Reference reference = CloudStorageReference(imageName: file.path, path: path).getReference();
    await reference.putFile(file);
    return await reference.getDownloadURL();
  }

  Future<List<String>> uploadListOfFiles({required List<File> files, required List<String> path}) async{
    final List<String>downloadUrls=[];
    for (var i = 0; i < files.length; i++) {
      downloadUrls.add( await uploadFile(file: files[i], path: path));
    }
    return downloadUrls;
  }

  Future<void> deleteFile({required String fileUrl}) async{
    await FirebaseStorage.instance.refFromURL(fileUrl).delete();
  }

  Future<void> deleteListOfFiles({required List<String> filesUrls}) async{
    for (var i = 0; i < filesUrls.length; i++) {
      await deleteFile(fileUrl: filesUrls[i]);
    }
  }

} 