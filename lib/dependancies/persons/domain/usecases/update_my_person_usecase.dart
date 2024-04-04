import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/persons/domain/repo/persons_repo.dart';
import '../models/my_person.dart';
import '../models/person_update_Info.dart';

class UpdateMyPersonUseCase extends Equatable{
  final PersonsRepo personsRepo;

  const UpdateMyPersonUseCase({required this.personsRepo});

  Future<Either<Failure, MyPerson>> excute(NewPeronUpdateInfo newPeronUpdateInfo)async{
    return await personsRepo.updateMyPerson(newPeronUpdateInfo);
  }
  @override
  List<Object?> get props => [personsRepo];
}