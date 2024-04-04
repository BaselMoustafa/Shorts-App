import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/persons/domain/repo/persons_repo.dart';
import '../models/my_person.dart';

class GetMyPersonUseCase extends Equatable{
  final PersonsRepo personsRepo;

  const GetMyPersonUseCase({required this.personsRepo});

  Future<Either<Failure,MyPerson>> excute()async{
    return await personsRepo.getMyPerson();
  }
  @override
  List<Object?> get props => [personsRepo];
}