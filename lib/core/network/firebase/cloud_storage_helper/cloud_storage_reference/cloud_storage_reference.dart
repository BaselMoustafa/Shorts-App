import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageReference extends Equatable{
  final List<String>path;
  final String imageName;

  const CloudStorageReference({
    required this.imageName,
    required this.path,
  });

  Reference getReference(){
    String ref="";
    for (var i = 0; i < path.length; i++) {
      ref+=path[i];
      ref+="/";
    }
    ref+="${Random().nextInt(10000000)}${baseName(imageName)}";
    return FirebaseStorage.instance.ref(ref);
  }

  String baseName(String imageName){
    String baseName="";
    int i=imageName.length-1;
    while (imageName[i]!="/") {
      baseName= imageName[i]+baseName;
      i--;
    }
    return baseName;
  }

  @override
  List<Object?> get props => [
    imageName,
    path,
  ];

}