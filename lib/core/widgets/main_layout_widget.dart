import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/dependancies/persons/controllers/get_my_person_cubit/get_my_person_cubit.dart';
import 'package:shorts_app/features/profile/screens/profile_screen.dart';
import 'package:shorts_app/core/widgets/screens_with_navigation_bar.dart';
import 'package:shorts_app/features/search/screens/search_screen.dart';
import '../../features/add_short/add_short_cubit/add_short_cubit.dart';
import '../../features/add_short/add_short_cubit/add_short_cubit_states.dart';
import '../../features/add_short/screens/add_short_screen.dart';
import '../../features/home/screens/home_screen.dart';
import 'show_my_snackbar.dart';


class MainLayoutWidget extends StatelessWidget {
  const MainLayoutWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddShortCubit,AddShortStates>(
      listener: _addShortBlocListener,
  
      child:Scaffold(
        body: ScreensWithNavigationBar(
          navigationBarItemsInfo:_navigationBarItemsInfo,
        ),
      )
    );
  }
  

  void _addShortBlocListener(BuildContext context,AddShortStates state) {
    if(state is AddShortSuccessState){
      showAddShortSuccessSnackBar(context: context, short: state.short);
    }
    if(state is AddShortFailedState){
      showAddShortFailedSnackBar(
        context: context, 
        message: state.message, 
        newShortInfo: state.newShortInfo,
      );
    }
  }

  List<NavigationBarItemInfo> get _navigationBarItemsInfo=>[
    _homeScreenItemInfo,
    _addShortScreenItemInfo,
    _searchItemInfo,
    _profileItemInfo,
  ];

  NavigationBarItemInfo get _homeScreenItemInfo=>const NavigationBarItemInfo(
    extendBodyBehindNavigationBar: true,
    name: "Home", 
    iconData: Icons.home, 
    screen: HomeScreen(),
  );

  NavigationBarItemInfo get _addShortScreenItemInfo=>const NavigationBarItemInfo(
    extendBodyBehindNavigationBar: true,
    name: "Add Short", 
    iconData: Icons.add, 
    screen: AddShortScreen(),
  );

  NavigationBarItemInfo get _searchItemInfo=>const NavigationBarItemInfo(
    name: "Search", 
    iconData: Icons.search, 
    screen: SearchScreen(),
  );

  NavigationBarItemInfo get _profileItemInfo=> NavigationBarItemInfo(
    name: "Profile", 
    iconData: Icons.person, 
    screen: ProfileScreen(person: GetMyPersonCubit.myPerson)
  );
}