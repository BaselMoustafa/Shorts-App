

abstract class EmailAuthanticationCubitStates{}

class EmailAuthanticationInitialState extends EmailAuthanticationCubitStates{}
class EmailAuthanticationLoadingState extends EmailAuthanticationCubitStates{}
class EmailAuthanticationWaitingVerificationState extends EmailAuthanticationCubitStates{}
class EmailAuthanticationSuccessState extends EmailAuthanticationCubitStates{}
class EmailAuthanticationFailedState extends EmailAuthanticationCubitStates{
  final String message;
  EmailAuthanticationFailedState({required this.message});
}