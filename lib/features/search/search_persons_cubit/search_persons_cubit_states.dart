import '../../../dependancies/persons/domain/models/person.dart';

abstract class SearchPersonsStates {}

class SearchPersonsInitial extends SearchPersonsStates{}
class SearchPersonsLoading extends SearchPersonsStates{}
class SearchPersonsSuccess extends SearchPersonsStates{
  final List<Person>persons;

  SearchPersonsSuccess({required this.persons});
}
class SearchPersonsFailed extends SearchPersonsStates{
  final List<Person>persons;
  final String message;
  SearchPersonsFailed({required this.message,required this.persons});
}