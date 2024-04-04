import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/shorts/controllers/add_short_view_cubit/add_view_cubit_states.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/dependancies/shorts/domain/usecases/add_short_view_usecase.dart';

class AddShortViewCubit extends Cubit<AddShortViewStates>{
  final AddShortViewUsecase addShortViewUsecase;

  AddShortViewCubit({
    required this.addShortViewUsecase,
  }):super(AddShortViewInitial());

  static AddShortViewCubit get(BuildContext context)=>BlocProvider.of(context);

  Future<void>addShortView(Short short)async{
    emit(AddShortViewLoading());
    Either<Failure,Unit>viewedOrFailure=await addShortViewUsecase.excute(short: short);

    viewedOrFailure.fold(
      (Failure failure){
        emit(AddShortViewFailed(message: failure.message));
      }, 
      (Unit viewed){
        emit(AddShortViewSuccess());
      }
    );
  }
}
