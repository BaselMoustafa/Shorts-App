import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../authantication/Domain/usecases/sign_out_usecase.dart';
import 'signout_cubit_states.dart';

class SignOutCubit extends Cubit<SignOutCubitStates>{
  final SignOutUsecase signOutUsecase;
  SignOutCubit({
    required this.signOutUsecase,

  }):super(SignOutInitialState());

  static SignOutCubit get(BuildContext context)=>BlocProvider.of(context); 

  Future<void>signOut()async{
    emit(SignOutLoadingState());
    final Either<Failure,Unit>signOutOrFailure= await signOutUsecase.excute();
    signOutOrFailure.fold(
      (Failure failure){
        emit(SignOutFailedState(message: failure.message));
      }, 
      (Unit success){
        emit(SignOutSuccessState());
      }
    );
  }
}