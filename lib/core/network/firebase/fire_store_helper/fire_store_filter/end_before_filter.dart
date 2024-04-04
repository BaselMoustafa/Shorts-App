import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts_app/core/network/firebase/fire_store_helper/fire_store_filter/fire_store_filter.dart';

class EndBeforeFilter extends FireStoreFilter{
  final List values;

  const EndBeforeFilter({required this.values});
  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference
  )=>collectionReference.endBefore(values);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query) =>query.endBefore(values);

  @override
  List<Object?> get props => [values];

}