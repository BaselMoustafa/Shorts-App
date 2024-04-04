import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/persons/domain/usecases/serach_persons_usecase.dart';
import '../../../dependancies/persons/domain/models/person.dart';
import 'search_persons_cubit_states.dart';

class SearchPersonsCubit extends Cubit<SearchPersonsStates>{
  final SearchPersonsUseCase searchPersonsUseCase;

  SearchPersonsCubit({
    required this.searchPersonsUseCase,
  }):super(SearchPersonsInitial());

  static SearchPersonsCubit get(BuildContext context)=>BlocProvider.of(context);

  List<Person>_persons=[];

  void init(){
    _persons=[];
    emit(SearchPersonsInitial());
  }

  Future<void>searchPersons(String? query)async{
    if(query==null){
      emit(SearchPersonsLoading());
      return;
    }
    emit(SearchPersonsLoading());
    Either<Failure,List<Person>>personsOrFailure= await searchPersonsUseCase.excute(query.toLowerCase());
    personsOrFailure.fold(
      (Failure failure){
        emit(SearchPersonsFailed(message: failure.message,persons: _persons));
      }, 
      (List<Person> persons){
        _persons=persons;
        emit(SearchPersonsSuccess(persons: _persons));
      }
    );
  }
}