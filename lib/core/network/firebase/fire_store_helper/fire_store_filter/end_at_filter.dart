import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts_app/core/network/firebase/fire_store_helper/fire_store_filter/fire_store_filter.dart';

class EndAtFilter extends FireStoreFilter{
  final List values;

  const EndAtFilter({required this.values});
  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference
  )=>collectionReference.endAt(values);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query) =>query.endAt(values);

  @override
  List<Object?> get props => [values];

}