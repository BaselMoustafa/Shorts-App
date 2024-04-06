import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/exception_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../search_persons_cubit/search_persons_cubit.dart';
import '../search_persons_cubit/search_persons_cubit_states.dart';
import 'searched_persons_list_view.dart';

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPersonsCubit,SearchPersonsStates>(
      builder: (context, state) {
        if(state is SearchPersonsLoading){
          return const LoadingWidget();
        }
        if(state is SearchPersonsFailed){
          if(state.persons.isEmpty){
            return ExceptionWidget(message: state.message);
          }
          return SearchedPersonsListView(persons: state.persons);
        }
        if(state is SearchPersonsSuccess){
          if(state.persons.isEmpty){
            return const ExceptionWidget(message: "There Are No Persons Matches This Search Term");
          }
          return SearchedPersonsListView(persons: state.persons);
        }
        return const ExceptionWidget(
          widget: Icon(Icons.search,size: 45,),
          message: "Search Now",
        );
      },
    );
  }
}