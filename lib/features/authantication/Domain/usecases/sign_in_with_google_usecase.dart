import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/features/authantication/Domain/authantication_repo/authantication_reposatory.dart';

class SignInWithGoogleUsecase extends Equatable{

  final AuthanticationReposatory authanticationReposatory;
  const SignInWithGoogleUsecase({required this.authanticationReposatory});

  Future<Either<Failure,Unit>>excute()async{
    return await authanticationReposatory.signInWithGoogle();
  }

  @override
  List<Object?> get props => [authanticationReposatory];

}