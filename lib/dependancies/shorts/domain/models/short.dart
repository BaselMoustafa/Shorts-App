import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/constants/constants.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short_Info.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person.dart';

class Short extends Equatable{
  final String id;
  final String url;
  final String? caption;
  final DateTime date;
  final Person from;
  final bool likedByMyPerson;
  final int likesCount;
  final int commentsCount;
  final int viewsCount;

  const Short({
    required this.id,
    required this.caption,
    required this.commentsCount,
    required this.date,
    required this.from,
    required this.likedByMyPerson,
    required this.likesCount,
    required this.url,
    required this.viewsCount,
  });

  factory Short.fromFireStore({
    required Person from,
    required Map<String,dynamic>map,
  }){
    return Short(
      id: map[KConst.id], 
      caption: map[KConst.caption], 
      commentsCount: map[KConst.commentsCount], 
      date: map[KConst.date].toDate(), 
      from: from, 
      likedByMyPerson: map[KConst.likedByMyPerson], 
      likesCount: map[KConst.likesCount], 
      url: map[KConst.url], 
      viewsCount: map[KConst.viewsCount],
    );
  }

  factory Short.fromUploadedShortInfo({
    required UploadedShortInfo uploadedShortInfo,
  }){
    return Short(
      id: uploadedShortInfo.id, 
      caption: uploadedShortInfo.caption, 
      date: uploadedShortInfo.date, 
      from: uploadedShortInfo.from, 
      url: uploadedShortInfo.url,
      likedByMyPerson: false, 
      commentsCount:0, 
      likesCount: 0, 
      viewsCount: 0,
    );
  }

  Short addLike()=>Short(
    id: id, 
    caption: caption, 
    commentsCount: commentsCount, 
    date: date, 
    from: from, 
    likedByMyPerson: true, 
    likesCount: likesCount+1, 
    url: url, 
    viewsCount: viewsCount,
  );

  Short removeLike()=>Short(
    id: id, 
    caption: caption, 
    commentsCount: commentsCount, 
    date: date, 
    from: from, 
    likedByMyPerson: false, 
    likesCount: likesCount-1, 
    url: url, 
    viewsCount: viewsCount,
  );

  Short increamentComments()=>Short(
    id: id, 
    caption: caption, 
    commentsCount: commentsCount+1, 
    date: date, 
    from: from, 
    likedByMyPerson: likedByMyPerson, 
    likesCount: likesCount, 
    url: url, 
    viewsCount: viewsCount,
  );

  Short decreamentComments()=>Short(
    id: id, 
    caption: caption, 
    commentsCount: commentsCount-1, 
    date: date, 
    from: from, 
    likedByMyPerson: likedByMyPerson, 
    likesCount: likesCount, 
    url: url, 
    viewsCount: viewsCount,
  );

  Short replaceThePerson(Person person)=>Short(
    id: id,
    from: person,  
    caption: caption, 
    commentsCount: commentsCount, 
    date: date, 
    likedByMyPerson: likedByMyPerson, 
    likesCount: likesCount, 
    url: url, 
    viewsCount: viewsCount,
  );

  @override
  List<Object?> get props => [
    id,
    caption,
    commentsCount,
    date,
    from,
    likedByMyPerson,
    likesCount,
    url,
    viewsCount,
  ];

}