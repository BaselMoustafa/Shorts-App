import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/comment.dart';
import 'package:shorts_app/dependancies/shorts/domain/repo/shorts_repo.dart';

class GetShortCommentsUsecase extends Equatable{
  final ShortsRepo shortsRepo;
  const GetShortCommentsUsecase({
    required this.shortsRepo,
  });

  Future<Either<Failure,List<UploadedComment>>>excute(String shortId)async{
    return await shortsRepo.getShortComments(shortId: shortId);
  }

  @override
  List<Object?> get props => [shortsRepo];
}