import 'package:cloud_firestore/cloud_firestore.dart';

import 'update_method.dart';
import 'update_method_type.dart';

class FireStoreUpdate{
  final String key;
  final List<String>nestedKeys;
  final UpdateMethod updateMethod;
  
  const FireStoreUpdate({
    required this.key,
    required this.updateMethod,
    this.nestedKeys=const [],
  }); 

  void addThisUpdateToMap(Map<String,dynamic>map){
    map[_determineKey()]=_determineValue();
  }

  String _determineKey(){
    String finalKey=key;
    if(nestedKeys.length!=0){
      finalKey+=".";
    }
    for (var i = 0; i < nestedKeys.length; i++) {
      finalKey+=nestedKeys[i];
      if(i!=nestedKeys.length-1){
        finalKey+=".";
      }
    }
    return finalKey;
  }

  dynamic _determineValue(){
    if(updateMethod.updateMethodType==UpdateMethodType.set){
      return updateMethod.value;
    }
    if(updateMethod.updateMethodType==UpdateMethodType.increment){
      return FieldValue.increment(updateMethod.value);
    }
    if(updateMethod.updateMethodType==UpdateMethodType.delete){
      return FieldValue.delete();
    }
    if(updateMethod.updateMethodType==UpdateMethodType.arrayUnion){
      return FieldValue.arrayUnion(updateMethod.value);
    }
    return FieldValue.arrayRemove(updateMethod.value);
  }
}