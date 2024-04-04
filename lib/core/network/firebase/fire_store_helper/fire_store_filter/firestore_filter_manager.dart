import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'fire_store_filter.dart';

class FireStoreFilterManager extends Equatable{
  final CollectionReference collectionReference;
  final List<FireStoreFilter>fireStoreFilters;

  const FireStoreFilterManager({
    required this.collectionReference,
    required this.fireStoreFilters,
  });

  Query? get query{
    if(fireStoreFilters.isEmpty){
      return null;
    }
    Query toReturn=fireStoreFilters[0].applyOnCollectionRef(collectionReference);
    for (var i = 1; i < fireStoreFilters.length; i++) {
      toReturn=fireStoreFilters[i].applyOnQuery(toReturn);
    }
    return toReturn;
  }

  @override
  List<Object?> get props => [
    collectionReference,
    fireStoreFilters,
  ];
}