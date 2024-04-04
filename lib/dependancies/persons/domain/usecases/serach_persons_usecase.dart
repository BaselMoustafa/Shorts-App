import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person.dart';
import 'package:shorts_app/dependancies/persons/domain/repo/persons_repo.dart';

class SearchPersonsUseCase extends Equatable{
  final PersonsRepo personsRepo;

  const SearchPersonsUseCase({required this.personsRepo});

  Future<Either<Failure,List<Person>>> excute(String query)async{
    return await personsRepo.searchPersons(query);
  }
  @override
  List<Object?> get props => [personsRepo];
}