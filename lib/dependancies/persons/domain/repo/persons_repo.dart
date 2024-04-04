import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person_update_Info.dart';

import '../models/my_person.dart';

abstract class PersonsRepo extends Equatable{
  const PersonsRepo();
  Future<Either<Failure,MyPerson>>getMyPerson();
  Future<Either<Failure,Unit>>followPerson(String userId);
  Future<Either<Failure, MyPerson>> updateMyPerson(NewPeronUpdateInfo newPeronUpdateInfo);
  Future<Either<Failure, List<Person>>> searchPersons(String query);
}