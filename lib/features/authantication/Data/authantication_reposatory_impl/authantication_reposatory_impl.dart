
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shorts_app/dependancies/persons/domain/models/authantication_mehod_enum.dart';
import 'package:shorts_app/dependancies/persons/domain/models/my_person.dart';
import '../../../../../core/network/firebase/firebase_auth_helper/firebase_auth_helper.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_connection_info/network_connection_info.dart';
import '../../Domain/authantication_repo/authantication_reposatory.dart';
import '../authantication_data_source/authantication_local_data_source.dart';
import '../authantication_data_source/authantication_remote_data_source.dart';

class AuthanticationReposatoryImpl extends AuthanticationReposatory{
  final AuthanticationRemoteDataSource authanticationRemoteDataSource;
  final AuthanticationLocalDataSource  authanticationLocalDataSource;
  final NetworkConnectionInfo networkConnectionInfo;
  const AuthanticationReposatoryImpl({required this.authanticationRemoteDataSource,required this. authanticationLocalDataSource,required this.networkConnectionInfo});

  @override
  Future<Either<Failure, UserCredential>> signUpWithEmailAndPassword({required String name,required String email, required String password})async{
    return await _failureHandler(
      functionToExcute: () async{
        UserCredential userCredential= await authanticationRemoteDataSource.signUpWithEmailAndPassword(email: email, password: password);
        await authanticationRemoteDataSource.setNewPersonToDataBase(
          MyPerson.newPerson(emailIsVerified: false,id: userCredential.user!.uid, name: name,),
        );
        return userCredential;
      },
    );
  }
 
  @override
  Future<Either<Failure,Unit>>sendEmailVerification()async{
    return await _failureHandler(
      functionToExcute: () async{
        await authanticationRemoteDataSource.sendEmailVerification();
        return unit;
      },
    );
  }

  @override
  Future<Either<Failure,bool>>checkEmailVerification()async{
    return await _failureHandler(
      functionToExcute: () async{
        final User userData= await authanticationRemoteDataSource.checkEmailVerification();
        if(userData.emailVerified){
          await _whenVerifyPersonEmail(userData.uid);
        }
        return userData.emailVerified;
      },
    );
  }

  @override
  Future<Either<Failure,Unit>>signInWithGoogle()async{
    return await _failureHandler(
      functionToExcute: () async{
        GoogleUserInfo googleUserInfo=await authanticationRemoteDataSource.signInWithGoogle();
        MyPerson myPerson=MyPerson.newPerson(emailIsVerified: true,id: googleUserInfo.userId, name: googleUserInfo.name);
        if( ! await authanticationRemoteDataSource.thisPersonExistsAtDataBase(googleUserInfo.userId)){
          await authanticationRemoteDataSource.setNewPersonToDataBase(myPerson);
        }
        authanticationLocalDataSource.setUserId(googleUserInfo.userId);
        authanticationLocalDataSource.setAuthanticationMethod(AuthanticationMethod.google);
        authanticationLocalDataSource.setPerson(myPerson);
        return unit;
      },
    );
  }

  @override
  Future<Either<Failure,UserCredential>>signInWithEmailAndPassword({required String email,required String password})async{
    return await _failureHandler(
      functionToExcute: () async{
        UserCredential userCredential=await authanticationRemoteDataSource.signInWithEmailAndPassword(email: email, password: password);
        if(userCredential.user!.emailVerified){
          await _whenVerifyPersonEmail(userCredential.user!.uid);
        }
        return userCredential;
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> signOut() async{
    return _failureHandler(
      functionToExcute: () async{
        AuthanticationMethod authanticationMethod=await authanticationLocalDataSource.getAuthanticationMethod();
        await authanticationRemoteDataSource.signOut(authanticationMethod);
        await authanticationLocalDataSource.deleteLocalData();
        return unit;
      },
    );
  }
  
  Future<void>_whenVerifyPersonEmail(String userId)async{
    await authanticationRemoteDataSource.markPersonEmailAsVerified(userId);
    authanticationLocalDataSource.setUserId(userId);
    authanticationLocalDataSource.setAuthanticationMethod(AuthanticationMethod.emailAndPassword);
  }

  Future<Either<Failure,T>>_failureHandler<T>({
    required Future<T> Function() functionToExcute,
  })async{
    
    if(await networkConnectionInfo.isConnected){
      try {
        return Right(await functionToExcute());
      } on AuthanticationException catch (ex) {
        return Left(AuthanticationFailure(message: ex.message));
      } on LocalDataBaseException catch (ex){
        return Left(LocalDataBaseFailure(message: ex.message));
      }
    }
    return const Left(OfflineFailure());
  }

  @override
  List<Object?> get props => [
    authanticationRemoteDataSource,
    authanticationLocalDataSource,
    networkConnectionInfo,
  ];

}

