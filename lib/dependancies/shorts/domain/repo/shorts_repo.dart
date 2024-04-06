import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/comment.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short_Info.dart';

abstract class ShortsRepo extends Equatable{
  const ShortsRepo();
  Future<Either<Failure,List<Short>>> getHomeShorts({required bool isFirstGet,required int limit});
  Future<Either<Failure,List<Short>>> getProfileShorts(String userId);
  Future<Either<AddShortFailure, Short>> addShort({required NewShortInfo newShortInfo});
  Future<Either<Failure,UploadedComment>> addShortComment({required Short short,required NewComment newComment});
  Future<Either<Failure,Unit>> addOrRemoveShortLike({required Short short});
  Future<Either<Failure,Unit>> addShortView({required Short short});
  Future<Either<Failure,List<UploadedComment>>> getShortComments({required String shortId});
}