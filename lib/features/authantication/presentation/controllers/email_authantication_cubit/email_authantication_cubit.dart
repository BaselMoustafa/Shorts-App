import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import '../../../Domain/usecases/check_email_verification_usecse.dart';
import '../../../Domain/usecases/send_email_verification_usecase.dart';
import '../../../Domain/usecases/sign_in_with_email_and_password_usecase.dart';
import '../../../Domain/usecases/sign_up_with_email_and_password_usecase.dart';
import 'email_authantication_cubit_states.dart';

class EmailAuthanticationCubit extends Cubit<EmailAuthanticationCubitStates>{
  final SignUpWithEmailAndPasswordUseCase signUpWithEmailAndPasswordUseCase;
  final SignInWithEmailAndPasswordUseCase signInWithEmailAndPasswordUseCase;
  final SendEmailVerificationUsecase sendEmailVerificationUsecase;
  final CheckEmailVerificationUsecase checkEmailVerificationUsecase;
  Timer? _verificationCheckTimer;
  EmailAuthanticationCubit({
    required this.signUpWithEmailAndPasswordUseCase,
    required this.sendEmailVerificationUsecase,
    required this.checkEmailVerificationUsecase,
    required this.signInWithEmailAndPasswordUseCase,
  }):super(EmailAuthanticationInitialState());

  static EmailAuthanticationCubit get(BuildContext context)=>BlocProvider.of(context); 

  void init(){
    if(_verificationCheckTimer !=null){
      emit(EmailAuthanticationInitialState());
      _verificationCheckTimer!.cancel();
      _verificationCheckTimer=null;
    }
  }

  Future<void>signIn({required String email,required String password})async{
    await _startAuthantication(name: null, email: email, password: password);
  }

  Future<void>signUp({required String name,required String email,required String password})async{
    await _startAuthantication(name: name, email: email, password: password);
  }

  Future<void>_startAuthantication({required String? name,required String email,required String password})async{
    emit(EmailAuthanticationLoadingState());
    late final Either<Failure,UserCredential>authanticationOrFailure;
    if(name!=null){
      authanticationOrFailure= await signUpWithEmailAndPasswordUseCase.excute(name: name,email: email, password: password);
    }else{
      authanticationOrFailure= await signInWithEmailAndPasswordUseCase.excute(email: email, password: password);
    }
    authanticationOrFailure.fold(
      (Failure failure){
        emit(EmailAuthanticationFailedState(message: failure.message));
      }, 
      (UserCredential userData){
        if(userData.user!.emailVerified){
          emit(EmailAuthanticationSuccessState());
        }else{
          _verifiyUserAccount();
        }
      }
    );
  }

  Future<void>_verifiyUserAccount()async{
    Either<Failure,Unit> verificationSentOrFailure=await sendEmailVerificationUsecase.excute();
    verificationSentOrFailure.fold(
      (Failure failure) {
        emit(EmailAuthanticationFailedState(message: failure.message));
      }, 
      (Unit verificationSent)async {
        emit(EmailAuthanticationWaitingVerificationState());
        await _checkEmailVerification();
      },
    );
  }
  
  Future<void> _checkEmailVerification() async{
    _verificationCheckTimer= Timer.periodic(
      const Duration(seconds: 3), 
      (timer) async{
        Either<Failure,bool>verifiedOrFailure=await checkEmailVerificationUsecase.excute();
        verifiedOrFailure.fold(
          (Failure failure){
            emit(EmailAuthanticationFailedState(message: failure.message));
          }, 
          (bool isVerified){
            if(isVerified){
              timer.cancel();
              emit(EmailAuthanticationSuccessState());
            }
          }
        );
      }
    );
  }
}