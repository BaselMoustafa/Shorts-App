import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/dependancies/shorts/domain/repo/shorts_repo.dart';

class GetHomeShortsUsecase extends Equatable{
  final ShortsRepo shortsRepo;

  const GetHomeShortsUsecase({required this.shortsRepo});

  Future<Either<Failure,List<Short>>> excute({required bool isFirstGet,required int limit})async{
    return await shortsRepo.getHomeShorts(isFirstGet: isFirstGet,limit: limit);
  }

  @override
  List<Object?> get props => [shortsRepo];
}