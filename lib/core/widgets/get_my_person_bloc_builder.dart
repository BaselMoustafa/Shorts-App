import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/widgets/loading_widget.dart';
import 'package:shorts_app/core/widgets/main_layout_widget.dart';
import '../../dependancies/persons/controllers/get_my_person_cubit/get_my_person_cubit.dart';
import '../../dependancies/persons/controllers/get_my_person_cubit/get_my_person_cubit_states.dart';
import '../../features/home/get_home_shorts_cubit/get_home_shorts_cubit.dart';
import 'exception_widget.dart';

class GetMtPersonBlocBuilder extends StatefulWidget {
  const GetMtPersonBlocBuilder({super.key});

  @override
  State<GetMtPersonBlocBuilder> createState() => _GetMtPersonBlocBuilderState();
}

class _GetMtPersonBlocBuilderState extends State<GetMtPersonBlocBuilder> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    GetMyPersonCubit.get(context).getMyPerson();
    GetHomeShortsCubit.get(context).getHomeShorts();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMyPersonCubit,GetMyPersonCubitStates>(
      builder: (context, state) {        
        if(state is GetMyPersonSuccessState){
          return const MainLayoutWidget();
        }
        if(state is GetMyPersonLoadingState){
          return const LoadingWidget();
        }
        if(state is GetMyPersonFailedState){
          return Scaffold(
            body: ExceptionWidget(
              message: state.message,
              onTryAgain: () => GetMyPersonCubit.get(context).getMyPerson(),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}