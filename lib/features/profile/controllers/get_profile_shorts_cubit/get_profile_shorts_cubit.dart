import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import '../../../../dependancies/persons/domain/models/person.dart';
import '../../../../dependancies/shorts/domain/usecases/get_profile_shorts_usecase.dart';
import 'get_profile_shorts_cubit_states.dart';


class GetProfileShortsCubit extends Cubit<GetProfileShortsStates>{
  final GetProfileShortsUsecase getProfileShortsUsecase;

  GetProfileShortsCubit({
    required this.getProfileShortsUsecase,
  }):super(GetProfileShortsInitialState());

  static GetProfileShortsCubit get(BuildContext context)=>BlocProvider.of(context);

  List<Short>_shorts=[];
  late String _currentPersonId="";

  void init(){
    _shorts=[];
    emit(GetProfileShortsInitialState());
  }

  Future<void>getProfileShorts(String userId)async{
    if(_currentPersonId==userId){
      emit(GetProfileShortsSuccessState(shorts: _shorts));
      return ;
    }
    
    emit(GetProfileShortsLoadingState());
    Either<Failure,List<Short>>uploadedOrFailure= await getProfileShortsUsecase.excute(userId);
    uploadedOrFailure.fold(
      (Failure failure){
        
        emit(GetProfileShortsFailedState(message: failure.message));
      }, 
      (List<Short> shorts){
        _currentPersonId=userId;
        _shorts=shorts;
        emit(GetProfileShortsSuccessState(shorts: _shorts));
      }
    );
  }

  void replaceThisShort(Short short){
    int index=_shorts.indexWhere((Short element) => element.id==short.id);
    if(index!=-1){
      _shorts[index]=short;
    }
  }

  void replaceThisPerson(Person person){
    for (var i = 0; i < _shorts.length; i++) {
      if(_shorts[i].from.id==person.id){
        _shorts[i]=_shorts[i].replaceThePerson(person);
      }
    }
    if(state is GetProfileShortsSuccessState){
      emit(GetProfileShortsSuccessState(shorts: _shorts));
    }
  }

  void tryToGetAgain()async{
    getProfileShorts(_currentPersonId);
  }
}