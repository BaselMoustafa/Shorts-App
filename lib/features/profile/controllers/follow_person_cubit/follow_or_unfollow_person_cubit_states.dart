import 'package:shorts_app/dependancies/persons/domain/models/another_person.dart';

abstract class FollowOrUnfollowPersonStates{}

class FollowOrUnfollowPersonInitial extends FollowOrUnfollowPersonStates{}

class FollowOrUnfollowPersonLoading extends FollowOrUnfollowPersonStates{
  final AnotherPerson anotherPerson;
  FollowOrUnfollowPersonLoading({required this.anotherPerson});
}

class FollowOrUnfollowPersonFailed extends FollowOrUnfollowPersonStates{
  final AnotherPerson anotherPerson;
  final String message;
  FollowOrUnfollowPersonFailed({required this.message,required this.anotherPerson});
}

class FollowOrUnfollowPersonSuccess extends FollowOrUnfollowPersonStates{}