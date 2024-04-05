import 'package:dartz/dartz.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/core/network/network_connection_info/network_connection_info.dart';
import 'package:shorts_app/dependancies/persons/data/data_source/persons_local_data_source.dart';
import 'package:shorts_app/dependancies/persons/data/data_source/persons_remote_data_source.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person_update_Info.dart';
import 'package:shorts_app/dependancies/persons/domain/repo/persons_repo.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/models/another_person.dart';
import '../../domain/models/my_person.dart';
import '../../domain/models/person.dart';

class PersonssRepoImpl extends PersonsRepo{
  final PersonsRemoteDataSource personsRemoteDataSource;
  final PersonsLocalDataSource personsLocalDataSource;
  final NetworkConnectionInfo networkConnectionInfo;

  const PersonssRepoImpl({required this.personsLocalDataSource,required this.personsRemoteDataSource,required this.networkConnectionInfo});

  @override
  Future<Either<Failure,Unit>>followOrUnfollowPerson({required AnotherPerson anotherPerson})async{
    return await _failureHandler(
      functionToExcute: () async{
        String myPersonId=personsLocalDataSource.userId();
        return anotherPerson.followedByMyPerson? 
          await personsRemoteDataSource.unFollowPerson(anotherUserId: anotherPerson.id, myUserId: myPersonId)
          :await personsRemoteDataSource.followPerson(anotherUserId: anotherPerson.id, myUserId: myPersonId);
      },
    );
  }

  @override
  Future<Either<Failure, MyPerson>> getMyPerson() async{
    return await _failureHandler(
      functionToExcute: () async{
        return await personsRemoteDataSource.getPeron(
          personId: personsLocalDataSource.userId(),
          myPersonId: personsLocalDataSource.userId(),
        ) as MyPerson;
      },
    );
  }
  

  @override
  Future<Either<Failure, MyPerson>> updateMyPerson(NewPeronUpdateInfo newPeronUpdateInfo) async{
    return await _failureHandler(
      functionToExcute: () async{
        return await personsRemoteDataSource.updateMyPerson(newPeronUpdateInfo);
      },
    );
  }

  @override
  Future<Either<Failure, List<Person>>> searchPersons(String query)async{
    return await _failureHandler(
      functionToExcute: () async{
        return await personsRemoteDataSource.searchPersons(query: query,myPersonId: personsLocalDataSource.userId());
      },
    );
  }

  Future<Either<Failure,T>>_failureHandler<T>({
    required Future<T> Function() functionToExcute,
  })async{
    if(await networkConnectionInfo.isConnected){
      try {
        return Right(await functionToExcute());
      } on RemoteDataBaseException catch (ex) {
        return Left(RemoteDataBaseFailure(message: ex.message));
      } on LocalDataBaseException catch (ex){
        return Left(LocalDataBaseFailure(message: ex.message));
      }
    }
    return const Left(OfflineFailure());
  }

  @override
  List<Object?> get props => [personsLocalDataSource,personsRemoteDataSource,networkConnectionInfo];

}