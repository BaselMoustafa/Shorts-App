import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/persons/domain/models/my_person.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person_update_Info.dart';
import 'package:shorts_app/dependancies/persons/domain/usecases/update_my_person_usecase.dart';
import 'update_my_person_cubit_states.dart';

class UpdateMyPersonCubit extends Cubit<UpdateMyPersonStates>{
  final UpdateMyPersonUseCase updateMyPersonUsecase;

  UpdateMyPersonCubit({
    required this.updateMyPersonUsecase,
  }):super(UpdateMyPersonInitial());

  static UpdateMyPersonCubit get(BuildContext context)=>BlocProvider.of(context);

  Future<void>updateMyPerson(NewPeronUpdateInfo newPeronUpdateInfo)async{
    emit(UpdateMyPersonLoading());
    Either<Failure,MyPerson>myPersonOrFailure=await updateMyPersonUsecase.excute(newPeronUpdateInfo);
    myPersonOrFailure.fold(
      (Failure failure){
        emit(UpdateMyPersonFailed(message: failure.message));
      }, 
      (MyPerson myPerson){
        emit(UpdateMyPersonSuccess(myPerson: myPerson));
      }
    );
  }
}
