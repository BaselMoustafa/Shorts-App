import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/widgets/exception_widget.dart';
import 'package:shorts_app/core/widgets/short_widget/short_place_holder_widget.dart';
import 'package:shorts_app/core/widgets/show_my_snackbar.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/features/home/get_home_shorts_cubit/get_home_shorts_cubit.dart';
import 'package:shorts_app/features/home/get_home_shorts_cubit/get_home_shorts_cubit_states.dart';
import 'package:shorts_app/features/home/widgets/shorts_page_view.dart';

import '../../../core/widgets/short_widget/short_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  List<Short>_shorts=[];
  @override
  void initState() {
    super.initState();
    _pageController=PageController()..addListener(() {
      if(!GetHomeShortsCubit.get(context).atLoadingState&& _pageController.page==_shorts.length-1 ){
          GetHomeShortsCubit.get(context).getHomeShorts();
        }
      }
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetHomeShortsCubit,GetHomeShortsStates>(
          listener: (context, state) {
            if(state is GetHomeShortsFailedState && _shorts.isNotEmpty){
              showMySnackBar(context: context, content: Text(state.message));
            }
          },
        ),
      ], 
      child: BlocBuilder<GetHomeShortsCubit,GetHomeShortsStates>(
        builder: (context, state) {
          print('At The home Screeen Shorts Builder=================');
          if(state is GetHomeShortsSuccessState){
            _shorts=state.shorts;
            if(_shorts.isEmpty){
              return const ExceptionWidget(message: "There Are No Shorts");
            }
          }else if(state is GetHomeShortsFailedState){
            if(_shorts.isEmpty){
              return ExceptionWidget(message: state.message);
            }
          }
          return ShortsPageView(
            pageController: _pageController, 
            children: [
              for(int i=0;i<_shorts.length;i++)
              ShortWidget(
                short: _shorts[i],
              ),
              if(GetHomeShortsCubit.get(context).atLoadingState)
              ShortPlaceHolderWidget(),
            ],
          );
        },
      ),
    );
  }
}
