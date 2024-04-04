import 'package:shorts_app/dependancies/shorts/domain/models/comment.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';

abstract class AddShortCommentStates{}

class AddShortCommentInitial extends AddShortCommentStates{}

class AddShortCommentLoading extends AddShortCommentStates{
  final Short short;
  final NewComment newComment;
  AddShortCommentLoading({required this.short,required this.newComment});
}

class AddShortCommentFailed extends AddShortCommentStates{
  final String message;
  final Short short;
  final NewComment newComment;
  AddShortCommentFailed({required this.message,required this.short,required this.newComment});
}

class AddShortCommentSuccess extends AddShortCommentStates{}