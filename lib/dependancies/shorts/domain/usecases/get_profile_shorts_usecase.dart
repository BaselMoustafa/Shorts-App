import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/dependancies/shorts/domain/repo/shorts_repo.dart';

class GetProfileShortsUsecase extends Equatable{
  final ShortsRepo shortsRepo;

  const GetProfileShortsUsecase({required this.shortsRepo});

  Future<Either<Failure,List<Short>>> excute(String userId)async{
    return await shortsRepo.getProfileShorts(userId);
  }

  @override
  List<Object?> get props => [shortsRepo];
}