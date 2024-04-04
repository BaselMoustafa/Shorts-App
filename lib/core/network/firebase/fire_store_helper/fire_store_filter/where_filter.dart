import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts_app/core/network/firebase/fire_store_helper/fire_store_filter/fire_store_filter.dart';

abstract class WhereFilter<T> extends FireStoreFilter{
  final String fieldName;
  final T value;
  const WhereFilter({
    required this.fieldName,
    required this.value,
  });
}

class WhereIsNull extends WhereFilter<bool>{

  const WhereIsNull({
    required super.fieldName,
    required bool isNull,
  }):super(value:isNull);

  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference
  )=>collectionReference.where(super.fieldName,isNull: super.value);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query)=>query.where(super.fieldName,isNull: super.value);

  @override
  List<Object?> get props =>[
    super.fieldName,
    super.value,
  ];
}

class WhereIsEqualTo extends WhereFilter{

  const WhereIsEqualTo({
    required super.fieldName,
    required super.value,
  });

  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference
  )=>collectionReference.where(super.fieldName,isEqualTo: super.value);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query)=>query.where(super.fieldName,isEqualTo: super.value);

  @override
  List<Object?> get props =>[
    super.fieldName,
    super.value,
  ];
}

class WhereIsNotEqualTo extends WhereFilter{

  const WhereIsNotEqualTo({
    required super.fieldName,
    required super.value,
  });

  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference
  )=>collectionReference.where(super.fieldName,isNotEqualTo: super.value);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query)=>query.where(super.fieldName,isNotEqualTo: super.value);

  @override
  List<Object?> get props =>[
    super.fieldName,
    super.value,
  ];
}


class WhereIsLessThan extends WhereFilter{

  const WhereIsLessThan({
    required super.fieldName,
    required super.value,
  });

  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference
  )=>collectionReference.where(super.fieldName,isLessThan: super.value);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query)=>query.where(super.fieldName,isLessThan: super.value);

  @override
  List<Object?> get props =>[
    super.fieldName,
    super.value,
  ];
}

class WhereIsLessThanOrEqualTo extends WhereFilter{

  const WhereIsLessThanOrEqualTo({
    required super.fieldName,
    required super.value,
  });

  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference
  )=>collectionReference.where(super.fieldName,isLessThanOrEqualTo: super.value);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query)=>query.where(super.fieldName,isLessThanOrEqualTo: super.value);

  @override
  List<Object?> get props =>[
    super.fieldName,
    super.value,
  ];
}

class WhereIsGreaterThan extends WhereFilter{

  const WhereIsGreaterThan({
    required super.fieldName,
    required super.value,
  });

  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference
  )=>collectionReference.where(super.fieldName,isGreaterThan: super.value);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query)=>query.where(super.fieldName,isGreaterThan: super.value);

  @override
  List<Object?> get props =>[
    super.fieldName,
    super.value,
  ];
}

class WhereIsGreaterThanOrEqualTo extends WhereFilter{

  const WhereIsGreaterThanOrEqualTo({
    required super.fieldName,
    required super.value,
  });

  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference
  )=>collectionReference.where(super.fieldName,isGreaterThanOrEqualTo: super.value);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query)=>query.where(super.fieldName,isGreaterThanOrEqualTo: super.value);

  @override
  List<Object?> get props =>[
    super.fieldName,
    super.value,
  ];
}

class WhereArrayContains extends WhereFilter{

  const WhereArrayContains({
    required super.fieldName,
    required super.value,
  });

  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference
  )=>collectionReference.where(super.fieldName,arrayContains: super.value);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query)=>query.where(super.fieldName,arrayContains: super.value);

  @override
  List<Object?> get props =>[
    super.fieldName,
    super.value,
  ];
}

class WhereArrayContainsAny extends WhereFilter<List>{

  const WhereArrayContainsAny({
    required super.fieldName,
    required List values,
  }):super(value: values);

  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference
  )=>collectionReference.where(super.fieldName,arrayContainsAny: super.value);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query)=>query.where(super.fieldName,arrayContainsAny: super.value);

  @override
  List<Object?> get props =>[
    super.fieldName,
    super.value,
  ];
}

class WhereIn extends WhereFilter<List>{

  const WhereIn({
    required super.fieldName,
    required List values,
  }):super(value: values);

  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference
  )=>collectionReference.where(super.fieldName,whereIn: super.value);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query)=>query.where(super.fieldName,whereIn: super.value);

  @override
  List<Object?> get props =>[
    super.fieldName,
    super.value,
  ];
}

class WhereNotIn extends WhereFilter<List>{

  const WhereNotIn({
    required super.fieldName,
    required List values,
  }):super(value: values);

  @override
  Query<Object?> applyOnCollectionRef(
    CollectionReference<Object?> collectionReference
  )=>collectionReference.where(super.fieldName,whereNotIn: super.value);

  @override
  Query<Object?> applyOnQuery(Query<Object?> query)=>query.where(super.fieldName,whereNotIn: super.value);

  @override
  List<Object?> get props =>[
    super.fieldName,
    super.value,
  ];
}