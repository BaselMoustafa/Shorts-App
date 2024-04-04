import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';

abstract class AddOrRemoveShortLikeStates{}

class AddOrRemoveShortLikeInitial extends AddOrRemoveShortLikeStates{}

class AddOrRemoveShortLikeLoading extends AddOrRemoveShortLikeStates{
  final Short short;
  AddOrRemoveShortLikeLoading({required this.short});
}

class AddOrRemoveShortLikeFailed extends AddOrRemoveShortLikeStates{
  final String message;
  final Short short;
  AddOrRemoveShortLikeFailed({required this.message,required this.short});
}

class AddOrRemoveShortLikeSuccess extends AddOrRemoveShortLikeStates{
  AddOrRemoveShortLikeSuccess();
}