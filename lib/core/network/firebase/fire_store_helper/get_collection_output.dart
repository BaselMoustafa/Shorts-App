import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GetCollectionOutput extends Equatable{
  final List<Map<String,dynamic>>data;
  final List<QueryDocumentSnapshot>docs;

  const GetCollectionOutput({required this.data,required this.docs});

  @override
  List<Object?> get props => [data,docs];
}