import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/persons/controllers/get_my_person_cubit/get_my_person_cubit_states.dart';
import 'package:shorts_app/dependancies/persons/domain/models/another_person.dart';
import 'package:shorts_app/dependancies/persons/domain/models/my_person.dart';
import 'package:shorts_app/dependancies/persons/domain/usecases/get_my_person_usecase.dart';

class GetMyPersonCubit extends Cubit<GetMyPersonCubitStates>{
  final GetMyPersonUseCase getMyPersonUseCase;

  static late MyPerson myPerson;

  static GetMyPersonCubit get(BuildContext context)=>BlocProvider.of(context); 
  
  GetMyPersonCubit({
    required this.getMyPersonUseCase,
  }):super(GetMyPersonInitialState());

  Future<void>getMyPerson()async{
    emit(GetMyPersonLoadingState());
    Either<Failure,MyPerson> personOrFailure=await getMyPersonUseCase.excute();
    personOrFailure.fold(
      (Failure failure){
        emit(GetMyPersonFailedState(message: failure.message));
      }, (MyPerson gettedPerson){
        myPerson=gettedPerson;
        emit(GetMyPersonSuccessState());
      }
    );
  }

  void replaceThisPerson(MyPerson person){
    myPerson=person;
    emit(GetMyPersonSuccessState());
  }

  void increamentOrDecreamentFollowing(AnotherPerson anotherPerson){
    if(anotherPerson.followedByMyPerson){
      myPerson=myPerson.increamentFollwingCount();
    }else{
      myPerson=myPerson.decreamentFollwingCount();
    }
    emit(GetMyPersonSuccessState());
  }
  
}