abstract class AddShortViewStates{}

class AddShortViewInitial extends AddShortViewStates{}

class AddShortViewLoading extends AddShortViewStates{}

class AddShortViewFailed extends AddShortViewStates{
  final String message;
  AddShortViewFailed({required this.message});
}

class AddShortViewSuccess extends AddShortViewStates{}