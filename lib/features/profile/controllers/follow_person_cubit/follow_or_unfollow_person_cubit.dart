import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/persons/domain/models/another_person.dart';
import 'package:shorts_app/dependancies/persons/domain/usecases/follow_or_unfollow_person_usecase.dart';
import 'follow_or_unfollow_person_cubit_states.dart';

class FollowOrUnfollowPersonCubit extends Cubit<FollowOrUnfollowPersonStates>{
  final FollowOrUnfollowPersonUsecase followOrUnfollowPersonUsecase;

  FollowOrUnfollowPersonCubit({
    required this.followOrUnfollowPersonUsecase,
  }):super(FollowOrUnfollowPersonInitial());

  static FollowOrUnfollowPersonCubit get(BuildContext context)=>BlocProvider.of(context);

  Future<void>followOrUnfollowPerson(AnotherPerson anotherPerson)async{
    if(state is FollowOrUnfollowPersonLoading){
      return ;
    }
    emit(FollowOrUnfollowPersonLoading(anotherPerson: _toggleFollow(anotherPerson)));
    Either<Failure,Unit>viewedOrFailure=await followOrUnfollowPersonUsecase.excute(anotherPerson);

    viewedOrFailure.fold(
      (Failure failure){
        emit(FollowOrUnfollowPersonFailed(anotherPerson: anotherPerson,message: failure.message));
      }, 
      (Unit followed){
        emit(FollowOrUnfollowPersonSuccess());
      }
    );
  }

  AnotherPerson _toggleFollow(AnotherPerson anotherPerson){
    return anotherPerson.followedByMyPerson?anotherPerson.unFollow():anotherPerson.follow();
  }
}
