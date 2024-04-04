import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/error/failures.dart';
import '../../../../dependancies/persons/domain/usecases/follow_person_usecase.dart';
import 'follow_person_cubit_states.dart';

class FollowPersonCubit extends Cubit<FollowPersonStates>{
  final FollowPersonUsecase followPersonUsecase;

  FollowPersonCubit({
    required this.followPersonUsecase,
  }):super(FollowPersonInitial());

  static FollowPersonCubit get(BuildContext context)=>BlocProvider.of(context);

  Future<void>followPerson(String userId)async{
    emit(FollowPersonLoading());
    Either<Failure,Unit>viewedOrFailure=await followPersonUsecase.excute(userId);

    viewedOrFailure.fold(
      (Failure failure){
        emit(FollowPersonFailed(message: failure.message));
      }, 
      (Unit followed){
        emit(FollowPersonSuccess());
      }
    );
  }
}
