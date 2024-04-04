
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short_Info.dart';

abstract class AddShortStates {}

class AddShortInitialState extends AddShortStates{}

class AddShortLoadingState extends AddShortStates{}

class AddShortFailedState extends AddShortStates{
  final NewShortInfo newShortInfo;
  final String message;
  AddShortFailedState({required this.message,required this.newShortInfo});
}

class AddShortSuccessState extends AddShortStates{
  final Short short;
  AddShortSuccessState({required this.short});
}
