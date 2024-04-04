import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/dependancies/shorts/domain/usecases/add_or_remove_short_like_usecase.dart';
import 'add_or_remove_short_like_cubit_states.dart';

class AddOrRemoveShortLikeCubit extends Cubit<AddOrRemoveShortLikeStates>{
  final AddOrRemoveShortLikeUsecase addOrRemoveShortLikeUsecase;

  AddOrRemoveShortLikeCubit({
    required this.addOrRemoveShortLikeUsecase,
  }):super(AddOrRemoveShortLikeInitial());

  static AddOrRemoveShortLikeCubit get(BuildContext context)=>BlocProvider.of(context);

  final List<String>_inProgressShortIds=[];

  Future<void>addOrRemoveShortLike(Short short)async{
    if(_inProgressShortIds.contains(short.id)){
      return;
    }
    _inProgressShortIds.add(short.id);
    print("WILL EMIT LOADING============================");
    emit(AddOrRemoveShortLikeLoading(short: _toggleLike(short)));

    Either<Failure,Unit>likedOrFailure=await addOrRemoveShortLikeUsecase.excute(short: short);

    _inProgressShortIds.remove(short.id);

    likedOrFailure.fold(
      (Failure failure){

        emit(AddOrRemoveShortLikeFailed(message: failure.message,short: short));
      }, 
      (Unit liked){
        emit(AddOrRemoveShortLikeSuccess());
      }
    );
  }

  Short _toggleLike(Short short){
    return short.likedByMyPerson?short.removeLike():short.addLike();
  }
}
