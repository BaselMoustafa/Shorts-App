import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/persons/domain/models/another_person.dart';
import 'package:shorts_app/dependancies/persons/domain/repo/persons_repo.dart';

class FollowOrUnfollowPersonUsecase extends Equatable{
  final PersonsRepo personsRepo;

  const FollowOrUnfollowPersonUsecase({required this.personsRepo});

  Future<Either<Failure,Unit>> excute(AnotherPerson anotherPerson)async{
    return await personsRepo.followOrUnfollowPerson(anotherPerson:anotherPerson );
  }
  @override
  List<Object?> get props => [personsRepo];
}