abstract class GoogleAuthanticationCubitStates{}

class GoogleAuthanticationInitialState extends GoogleAuthanticationCubitStates{}
class GoogleAuthanticationLoadingState extends GoogleAuthanticationCubitStates{}
class GoogleAuthanticationSuccessState extends GoogleAuthanticationCubitStates{}
class GoogleAuthanticationFailedState extends GoogleAuthanticationCubitStates{
  final String message;
  GoogleAuthanticationFailedState({required this.message});
}