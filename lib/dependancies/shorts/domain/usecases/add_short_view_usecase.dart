import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/dependancies/shorts/domain/repo/shorts_repo.dart';

class AddShortViewUsecase extends Equatable{
  final ShortsRepo shortsRepo;

  const AddShortViewUsecase({required this.shortsRepo});

  Future<Either<Failure,Unit>> excute({required Short short})async{
    return await shortsRepo.addShortView(short: short);
  }

  @override
  List<Object?> get props => [shortsRepo];
}