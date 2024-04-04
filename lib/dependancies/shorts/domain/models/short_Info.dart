import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/constants/constants.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person.dart';

abstract class ShortInfo extends Equatable{
  final Person from;
  final String? caption;

  const ShortInfo({
    required this.caption,
    required this.from,
  });

  @override
  List<Object?> get props => [
    caption,
    from,
  ];
}

class NewShortInfo extends ShortInfo{
  final File videoFile;
  const NewShortInfo({
    required this.videoFile,
    required super.caption, 
    required super.from,
  });

  Map<String ,dynamic>toFireStore({
    required DateTime date,
    required String videoUrl,
  }){
    return {
      KConst.from:from.id,
      KConst.caption:caption,
      KConst.url:videoUrl,
      KConst.date:DateTime.now(),
    };
  }
}

class UploadedShortInfo extends ShortInfo{
  final DateTime date;
  final String url;
  final String id;

  const UploadedShortInfo({
    required super.caption, 
    required super.from,
    required this.date,
    required this.id,
    required this.url,
  });
  
  factory UploadedShortInfo.fromNewShortInfo({
    required NewShortInfo newShortInfo,
    required String id,
    required String url,
    required DateTime date,
  }){
    return UploadedShortInfo(
      id: id, 
      url: url,
      date: date, 
      caption: newShortInfo.caption, 
      from: newShortInfo.from, 
    );
  }
}