import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import '../../../Domain/usecases/sign_in_with_google_usecase.dart';
import 'google_authantication_cubit_states.dart';

class GoogleAuthanticationCubit extends Cubit<GoogleAuthanticationCubitStates>{
  final SignInWithGoogleUsecase signInWithGoogleUsecase;
  GoogleAuthanticationCubit({
    required this.signInWithGoogleUsecase,
  }):super(GoogleAuthanticationInitialState());

  static GoogleAuthanticationCubit get(BuildContext context)=>BlocProvider.of(context); 

  Future<void>signInWithGoogle()async{
    emit(GoogleAuthanticationLoadingState());
    final Either<Failure,Unit>signInOrFailure= await signInWithGoogleUsecase.excute();
    signInOrFailure.fold(
      (Failure failure){
        emit(GoogleAuthanticationFailedState(message: failure.message));
      }, 
      (Unit success)async{
        emit(GoogleAuthanticationSuccessState());
      }
    );
  }
}