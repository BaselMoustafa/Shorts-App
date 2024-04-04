import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FireStoreReference extends Equatable{
  final List<String>path;
  final FirebaseFirestore fireStore;
  const FireStoreReference({
    required this.fireStore,
    required this.path,
  });

  DocumentReference getDocumentReference(){
    if(path.length%2 !=0){
      throw Exception("Not Valid Path To Document");
    }
    return fireStore.doc(_addSlashesToPath());
  }

  CollectionReference getCollectionReference(){
    if(path.length%2 ==0){
      throw Exception("Not Valid Path To Collection");
    }
    return fireStore.collection(_addSlashesToPath());
  }

  String _addSlashesToPath(){
    String toReturn="";
    for (var i = 0; i < path.length; i++) {
      toReturn+=path[i];
      if(i!=path.length-1){
        toReturn+="/";
      }
    }
    return toReturn;
  }

  @override
  List<Object?> get props => [
    fireStore,
    path,
  ];

}