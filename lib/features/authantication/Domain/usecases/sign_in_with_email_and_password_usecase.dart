import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/features/authantication/Domain/authantication_repo/authantication_reposatory.dart';

class SignInWithEmailAndPasswordUseCase extends Equatable{
  final AuthanticationReposatory authanticationReposatory;
  const SignInWithEmailAndPasswordUseCase({required this.authanticationReposatory});

  Future<Either<Failure,UserCredential>>excute({required String email,required String password})async{
    return await authanticationReposatory.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  List<Object?> get props => [authanticationReposatory];
}