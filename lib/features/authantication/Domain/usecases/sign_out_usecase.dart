import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../authantication_repo/authantication_reposatory.dart';

class SignOutUsecase extends Equatable{

  final AuthanticationReposatory authanticationReposatory;
  const SignOutUsecase({required this.authanticationReposatory});

  Future<Either<Failure,Unit>>excute()async{
    return await authanticationReposatory.signOut();
  }

  @override
  List<Object?> get props => [authanticationReposatory];

}