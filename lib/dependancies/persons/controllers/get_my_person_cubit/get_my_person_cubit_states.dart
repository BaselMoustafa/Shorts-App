abstract class GetMyPersonCubitStates {}

class GetMyPersonInitialState extends GetMyPersonCubitStates{}

class GetMyPersonLoadingState extends GetMyPersonCubitStates{}

class GetMyPersonSuccessState extends GetMyPersonCubitStates{}

class GetMyPersonFailedState extends GetMyPersonCubitStates{
  final String message;
  GetMyPersonFailedState({required this.message});
}