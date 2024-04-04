import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failures.dart';

abstract class AuthanticationReposatory extends Equatable{
  const AuthanticationReposatory();
  Future<Either<Failure,UserCredential>> signUpWithEmailAndPassword({required String name,required String email,required String password});
  Future<Either<Failure,Unit>>sendEmailVerification();
  Future<Either<Failure,bool>>checkEmailVerification();
  Future<Either<Failure,Unit>>signInWithGoogle();
  Future<Either<Failure,UserCredential>>signInWithEmailAndPassword({required String email,required String password});
}