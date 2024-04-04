import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/features/authantication/Domain/authantication_repo/authantication_reposatory.dart';

import '../../../../core/error/failures.dart';

class CheckEmailVerificationUsecase extends Equatable{

  final AuthanticationReposatory authanticationReposatory;
  const CheckEmailVerificationUsecase({required this.authanticationReposatory});

  Future<Either<Failure,bool>>excute()async{
    return await authanticationReposatory.checkEmailVerification();
  }

  @override
  List<Object?> get props => [authanticationReposatory];

}