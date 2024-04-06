import 'package:flutter/material.dart';
import 'package:shorts_app/core/managers/box_decoration_manager.dart';
import 'package:shorts_app/core/managers/color_manager.dart';
import 'package:shorts_app/core/managers/navigator_manager.dart';
import 'package:shorts_app/core/widgets/exception_widget.dart';
import 'package:shorts_app/features/search/search_persons_cubit/search_persons_cubit.dart';
import 'package:shorts_app/features/search/widget/search_filed_widget.dart';
import 'package:shorts_app/features/search/widget/search_results_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            InkWell(
              onTap: () => _onTap(context),
              child: Container(
                padding:const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecorationManager.outlined,
                child:const Row(
                  children: [
                    Icon(Icons.search,size: 26,),
                    SizedBox(width: 8,),
                    Text(
                      "Search Now ....",
                      style: TextStyle(color: ColorManager.white,fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: ExceptionWidget(
                widget: Icon(Icons.search,size: 150,),
                message: "Search Now To Add New Friends",
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context){
    NavigatorManager.push(
      context: context, 
      widget:const _SearchScreen(),
      navigationAnimationType: NavigationAnimationType.fading,
    );
  }
}

class _SearchScreen extends StatelessWidget {
  
  const _SearchScreen();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop)=>_onPopInvoked(context,didPop),
      child:const Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20,),
              SearchFieldWidget(),
              SizedBox(height: 20,),
              Expanded(child: SearchResultsWidget(),),
            ],
          ),
        ),
      ),
    );
  }

  void _onPopInvoked(BuildContext context,bool didPop) {
    SearchPersonsCubit.get(context).init();
    if(didPop){
      return ;
    }    
    NavigatorManager.pop(context: context);
  }
}