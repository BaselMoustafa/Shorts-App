import '../../domain/models/comment.dart';

abstract class GetShortCommentsStates {}

class GetShortCommentsInitial extends GetShortCommentsStates{}
class GetShortCommentsLoading extends GetShortCommentsStates{}
class GetShortCommentsFailed extends GetShortCommentsStates{
  final String message;
  GetShortCommentsFailed({required this.message});
}
class GetShortCommentsSuccess extends GetShortCommentsStates{
  final List<Comment>comments;

  GetShortCommentsSuccess({required this.comments});
}