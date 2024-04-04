abstract class FollowPersonStates{}

class FollowPersonInitial extends FollowPersonStates{}

class FollowPersonLoading extends FollowPersonStates{}

class FollowPersonFailed extends FollowPersonStates{
  final String message;
  FollowPersonFailed({required this.message});
}

class FollowPersonSuccess extends FollowPersonStates{}