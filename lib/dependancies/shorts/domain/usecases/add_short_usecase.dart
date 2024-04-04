import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short_Info.dart';
import 'package:shorts_app/dependancies/shorts/domain/repo/shorts_repo.dart';

class AddShortUsecase extends Equatable{
  final ShortsRepo shortsRepo;

  const AddShortUsecase({required this.shortsRepo});

  Future<Either<AddShortFailure,Short>> excute({
    required NewShortInfo newShortInfo,
  })async{
    return await shortsRepo.addShort(newShortInfo:newShortInfo,);
  }

  @override
  List<Object?> get props => [shortsRepo];
}