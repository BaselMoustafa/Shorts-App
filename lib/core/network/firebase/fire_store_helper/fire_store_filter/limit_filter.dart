import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts_app/core/network/firebase/fire_store_helper/fire_store_filter/fire_store_filter.dart';

class LimitFilter extends FireStoreFilter{
  final int limit;

  const LimitFilter({required this.limit});

  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference
  )=>collectionReference.limit(limit);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query)=>query.limit(limit);

  @override
  List<Object?> get props =>[limit];
  
}