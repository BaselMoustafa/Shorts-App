import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts_app/core/network/firebase/fire_store_helper/fire_store_filter/fire_store_filter.dart';

class StartAtDocumentFilter extends FireStoreFilter{
  final DocumentSnapshot documentSnapshot;

  const StartAtDocumentFilter({required this.documentSnapshot});

  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference,
  )=>collectionReference.startAtDocument(documentSnapshot);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query)=>query.startAtDocument(documentSnapshot);

  @override
  List<Object?> get props =>[documentSnapshot];
  
}