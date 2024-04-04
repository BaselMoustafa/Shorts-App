import 'package:shorts_app/dependancies/persons/domain/models/my_person.dart';

abstract class UpdateMyPersonStates{}

class UpdateMyPersonInitial extends UpdateMyPersonStates{}

class UpdateMyPersonLoading extends UpdateMyPersonStates{}

class UpdateMyPersonFailed extends UpdateMyPersonStates{
  final String message;
  UpdateMyPersonFailed({required this.message});
}

class UpdateMyPersonSuccess extends UpdateMyPersonStates{
  final MyPerson myPerson;
  UpdateMyPersonSuccess({required this.myPerson});
}