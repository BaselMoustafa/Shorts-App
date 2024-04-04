import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/dependancies/shorts/domain/repo/shorts_repo.dart';
import '../models/comment.dart';

class AddShortCommentUsecase extends Equatable{
  final ShortsRepo shortsRepo;

  const AddShortCommentUsecase({required this.shortsRepo});

  Future<Either<Failure,UploadedComment>> excute({required Short short,required NewComment newComment})async{
    return await shortsRepo.addShortComment(short: short,newComment: newComment);
  }

  @override
  List<Object?> get props => [shortsRepo];
}