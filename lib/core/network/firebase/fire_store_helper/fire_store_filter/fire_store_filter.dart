import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class FireStoreFilter extends Equatable{
  const FireStoreFilter();

  Query applyOnQuery(Query query);
  
  Query applyOnCollectionRef(CollectionReference collectionReference);

}