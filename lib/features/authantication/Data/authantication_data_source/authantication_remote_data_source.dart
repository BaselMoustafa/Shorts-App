import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shorts_app/dependancies/persons/domain/models/my_person.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/firebase/fire_store_helper/fire_store_helper.dart';
import '../../../../core/network/firebase/fire_store_helper/update_info/fire_store_update.dart';
import '../../../../core/network/firebase/fire_store_helper/update_info/update_method.dart';
import '../../../../core/network/firebase/firebase_auth_helper/firebase_auth_helper.dart';


abstract class AuthanticationRemoteDataSource extends Equatable{
  const AuthanticationRemoteDataSource();
  
  Future<UserCredential> signUpWithEmailAndPassword({required String email,required String password});
  Future<UserCredential> signInWithEmailAndPassword({required String email,required String password});
  Future<GoogleUserInfo> signInWithGoogle();
  Future<Unit>sendEmailVerification();
  Future<User>checkEmailVerification();
  Future<bool>thisPersonExistsAtDataBase(String userId);
  Future<Unit>setNewPersonToDataBase(MyPerson myPerson);
  Future<Unit>markPersonEmailAsVerified(String userId);
  @override
  List<Object?> get props => [];
}

class AuthanticationRemoteDataSourceImpl extends AuthanticationRemoteDataSource{
  final FirebaseAuthHelper firebaseAuthHelper;
  final FireStoreHelper fireStoreHelper;
  const AuthanticationRemoteDataSourceImpl({required this.firebaseAuthHelper,required this.fireStoreHelper});

  @override
  Future<UserCredential> signUpWithEmailAndPassword({required String email, required String password}) async{
    return await _tryAndCatchBlock(
      functionToExcute: () async{
        return await firebaseAuthHelper.signUpWithEmailAndPassword(
          email: email,
          password: password,
        );
      },
    );
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({required String email,required String password})async{
    return await _tryAndCatchBlock(
      functionToExcute: () async{
        return await firebaseAuthHelper.signInWithEmailAndPassword(email: email, password: password);
      },
    );
  }

  @override
  Future<GoogleUserInfo> signInWithGoogle() async {
    return await _tryAndCatchBlock(
      functionToExcute: ()async {
        return await firebaseAuthHelper.signInWithGoogle();
      },
    );
  }

  @override
  Future<Unit> sendEmailVerification()async{
    return await _tryAndCatchBlock(
      functionToExcute: () async{
        await firebaseAuthHelper.sendEmailVerification();
        return unit;
      },
    );
  }

  @override
  Future<User>checkEmailVerification()async{
    return await _tryAndCatchBlock(
      functionToExcute: () async{
        return await firebaseAuthHelper.checkEmailVerification();
      },
    );
  }

  @override
  Future<bool> thisPersonExistsAtDataBase(String userId)async {
    return await _tryAndCatchBlock(
      functionToExcute: () async{
        return await fireStoreHelper.documentIsExists(
          path: [KConst.personsCollection, userId]
        );
      },
    );
  }
  
  @override
  Future<Unit> setNewPersonToDataBase(MyPerson myPerson)async {
    return await  _tryAndCatchBlock(
      functionToExcute: ()async{
        await fireStoreHelper.set(
          documentPath: [KConst.personsCollection,myPerson.id], 
          data: myPerson.toFireStore(),
        );
        return unit;
      }
    );
  }
  
  @override
  Future<Unit> markPersonEmailAsVerified(String userId) async{
    return await _tryAndCatchBlock(
      functionToExcute: () async{
        await fireStoreHelper.update(
          documentPath: [KConst.personsCollection,userId], 
          updates:const [
            FireStoreUpdate(key: KConst.emailIsVerified,updateMethod: SetValue(value: true))
          ],
        );
        return unit;
      },
    );
  }

  Future<T> _tryAndCatchBlock<T>({
    required Future<T>Function()functionToExcute,
  }){
    try {
      return functionToExcute();
    }on  AuthanticationException {
      rethrow;
    }
    catch (e) {
      rethrow; 
    }
  }
  
}