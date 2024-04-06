import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/dependancies/shorts/domain/usecases/get_home_shorts_usecase.dart';
import '../../../dependancies/persons/domain/models/person.dart';
import 'get_home_shorts_cubit_states.dart';

class GetHomeShortsCubit extends Cubit<GetHomeShortsStates>{
  final GetHomeShortsUsecase getHomeShortsUsecase;

  GetHomeShortsCubit({
    required this.getHomeShortsUsecase,
  }):super(GetHomeShortsInitialState());

  static GetHomeShortsCubit get(BuildContext context)=>BlocProvider.of(context);

  static double? currentPageAtHomePageView;

  final int _limit=5;
  List<Short>_shorts=[];
  bool _maxLimitReached=false;

  get atLoadingState=>state is GetHomeShortsLoadingState;

  void init(){
    _shorts=[];
    currentPageAtHomePageView=null;
    _maxLimitReached=false;
    emit(GetHomeShortsInitialState());
  }

  Future<void>getHomeShorts()async{
    if(_maxLimitReached){
      emit(GetHomeShortsFailedState(message: "There Are No More Shorts",shorts: _shorts));
      return ;
    }
    emit(GetHomeShortsLoadingState());
    Either<Failure,List<Short>>uploadedOrFailure= await getHomeShortsUsecase.excute(
      isFirstGet: state is GetHomeShortsInitialState,
      limit: _limit,
    );
    
    uploadedOrFailure.fold(
      (Failure failure){
        emit(GetHomeShortsFailedState(message: failure.message,shorts: _shorts));
      }, 
      (List<Short> shorts){
        if(shorts.length<_limit){
          _maxLimitReached=true;
        }
        _shorts=[..._shorts,...shorts];
        emit(GetHomeShortsSuccessState(shorts: _shorts));
      }
    );
  }

  void replaceThisShort(Short short){
    int index=_shorts.indexWhere((Short element) => element.id==short.id);
    if(index!=-1){
      _shorts[index]=short;
    }
    if(state is GetHomeShortsSuccessState){
      emit(GetHomeShortsSuccessState(shorts: _shorts));
    }
  }

  void replaceThisPerson(Person person){
    for (var i = 0; i < _shorts.length; i++) {
      if(_shorts[i].from.id==person.id){
        _shorts[i]=_shorts[i].replaceThePerson(person);
      }
    }
    if(state is GetHomeShortsSuccessState){
      emit(GetHomeShortsSuccessState(shorts: _shorts));
    }
  }
}