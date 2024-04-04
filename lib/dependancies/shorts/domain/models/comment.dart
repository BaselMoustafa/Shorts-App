import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/constants/constants.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person.dart';

abstract class Comment extends Equatable{
  final String content;
  final Person from;
  final Person to;
  final String shortId;
  final DateTime date;

  const Comment({
    required this.content,
    required this.date,
    required this.from,
    required this.to,
    required this.shortId,
  });
}

class NewComment extends Comment{

  const NewComment({
    required super.content,
    required super.date,
    required super.from,
    required super.shortId,
    required super.to,
  });

  @override
  List<Object?> get props =>[
    super.content,
    super.date,
    super.from,
    super.to,
    super.shortId,
  ];

  Map<String,dynamic>toMap()=>{
    KConst.from:from.id,
    KConst.to:to.id,
    KConst.short:shortId,
    KConst.date:date,
    KConst.content:content,
  };

}

class UploadedComment extends Comment{
  final String id;

  const UploadedComment({
    required this.id,
    required super.content,
    required super.date,
    required super.from,
    required super.to,
    required super.shortId,
  });

  factory UploadedComment.fromNewComment({
    required String id,
    required NewComment newComment,
  }){
    return UploadedComment(
      id: id, 
      content: newComment.content, 
      date: newComment.date, 
      from: newComment.from, 
      shortId: newComment.shortId,
      to: newComment.to,
    );
  }

  factory UploadedComment.fromFireStore({
    required Person from,
    required Person to,
    required Map<String,dynamic> map,
  }){
    return UploadedComment(
      to: to,
      from: from,
      id: map[KConst.id], 
      content: map[KConst.content], 
      date: map[KConst.date].toDate(), 
      shortId:map[KConst.short] ,
    );
  }

  @override
  List<Object?> get props =>[
    id,
    super.content,
    super.date,
    super.from,
    super.to,
    super.shortId,
  ];
}