import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short_Info.dart';
import 'package:shorts_app/dependancies/shorts/domain/usecases/add_short_usecase.dart';
import 'package:shorts_app/features/add_short/add_short_cubit/add_short_cubit_states.dart';

class AddShortCubit extends Cubit<AddShortStates>{
  final AddShortUsecase addShortUsecase;

  AddShortCubit({
    required this.addShortUsecase,
  }):super(AddShortInitialState());

  static AddShortCubit get(BuildContext context)=>BlocProvider.of(context);

  Future<void>addShort({required NewShortInfo newShortInfo})async{
    emit(AddShortLoadingState());
    Either<AddShortFailure,Short>uploadedOrFailure= await addShortUsecase.excute(newShortInfo: newShortInfo);
    uploadedOrFailure.fold(
      (AddShortFailure failure){
        emit(AddShortFailedState(message: failure.message, newShortInfo: failure.newShortInfo));
      }, 
      (Short short){
        emit(AddShortSuccessState(short: short));
      }
    );
  }


}