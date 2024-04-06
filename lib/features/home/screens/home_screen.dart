import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/managers/navigator_manager.dart';
import 'package:shorts_app/core/widgets/exception_widget.dart';
import 'package:shorts_app/core/widgets/short_widget/short_place_holder_widget.dart';
import 'package:shorts_app/core/widgets/show_my_snackbar.dart';
import 'package:shorts_app/core/widgets/there_are_no_widget.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/features/home/get_home_shorts_cubit/get_home_shorts_cubit.dart';
import 'package:shorts_app/features/home/get_home_shorts_cubit/get_home_shorts_cubit_states.dart';
import 'package:shorts_app/features/home/widgets/shorts_page_view.dart';
import 'package:shorts_app/features/profile/screens/profile_screen.dart';

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
    _pageController=PageController(
      initialPage: GetHomeShortsCubit.currentPageAtHomePageView==null?0:GetHomeShortsCubit.currentPageAtHomePageView!.round(),
    )..addListener(
      () {
        GetHomeShortsCubit.currentPageAtHomePageView=_pageController.page;
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
    return BlocListener<GetHomeShortsCubit,GetHomeShortsStates>(
      listener: _getHomeShortsBlocListener, 
      child: BlocBuilder<GetHomeShortsCubit,GetHomeShortsStates>(
        builder: (context, state) {
          if(state is GetHomeShortsSuccessState){
            _shorts=state.shorts;
            if(_shorts.isEmpty){
              return const ThereAreNoWidget(label: "Shorts");
            }
          }else if(state is GetHomeShortsFailedState){
            _shorts=state.shorts;
            if(_shorts.isEmpty){
              return _ExceptionWidget(message: state.message,);
            }
          }
          return ShortsPageView(
            pageController: _pageController, 
            children: [
              for(int i=0;i<_shorts.length;i++)
              ShortWidget(
                short: _shorts[i],
                onTapInfoWidget: (videoController) {
                  videoController.pause();
                  NavigatorManager.push(
                    context: context, 
                    widget: ProfileScreen(person:_shorts[i].from,asScaffold: true,),
                    toExcuteAfterPop: () => videoController.play(),
                  );
                },
              ),
              if(GetHomeShortsCubit.get(context).atLoadingState)
              const ShortPlaceHolderWidget(),
            ],
          );
        },
      ),
    );
  }

  void _getHomeShortsBlocListener(context, state) {
    if(state is GetHomeShortsFailedState && _shorts.isNotEmpty){
      showMySnackBar(context: context, content: Text(state.message));
    }
  }
}

class _ExceptionWidget extends StatelessWidget {
  const _ExceptionWidget({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return ExceptionWidget(
      message: message,
      onTryAgain: () => GetHomeShortsCubit.get(context).getHomeShorts(),
    );
  }
}
