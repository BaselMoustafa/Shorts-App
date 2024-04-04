import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../authantication_repo/authantication_reposatory.dart';

class SendEmailVerificationUsecase extends Equatable{

  final AuthanticationReposatory authanticationReposatory;
  const SendEmailVerificationUsecase({required this.authanticationReposatory});

  Future<Either<Failure,Unit>>excute()async{
    return await authanticationReposatory.sendEmailVerification();
  }

  @override
  List<Object?> get props => [authanticationReposatory];

}