import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/persons/domain/repo/persons_repo.dart';

class FollowPersonUsecase extends Equatable{
  final PersonsRepo personsRepo;

  const FollowPersonUsecase({required this.personsRepo});

  Future<Either<Failure,Unit>> excute(String userId)async{
    return await personsRepo.followPerson(userId);
  }
  @override
  List<Object?> get props => [personsRepo];
}