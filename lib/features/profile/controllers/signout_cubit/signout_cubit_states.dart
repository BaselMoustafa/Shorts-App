abstract class SignOutCubitStates{}

class SignOutInitialState extends SignOutCubitStates{}
class SignOutLoadingState extends SignOutCubitStates{}
class SignOutWaitingVerificationState extends SignOutCubitStates{}
class SignOutSuccessState extends SignOutCubitStates{}
class SignOutFailedState extends SignOutCubitStates{
  final String message;
  SignOutFailedState({required this.message});
}