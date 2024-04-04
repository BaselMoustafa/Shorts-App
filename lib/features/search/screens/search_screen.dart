import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/managers/box_decoration_manager.dart';
import 'package:shorts_app/core/managers/color_manager.dart';
import 'package:shorts_app/core/managers/navigator_manager.dart';
import 'package:shorts_app/core/models/image_details.dart';
import 'package:shorts_app/core/widgets/custom_text_form_filed.dart';
import 'package:shorts_app/core/widgets/exception_widget.dart';
import 'package:shorts_app/core/widgets/loading_widget.dart';
import 'package:shorts_app/core/widgets/profile_image_widget.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person.dart';
import 'package:shorts_app/features/profile/screens/profile_screen.dart';
import 'package:shorts_app/features/search/search_persons_cubit/search_persons_cubit.dart';
import 'package:shorts_app/features/search/search_persons_cubit/search_persons_cubit_states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  Column(
            children: [
              const SizedBox(height: 100,),
              InkWell(
                onTap: () => NavigatorManager.push(context: context, widget: _SearchScreen()),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecorationManager.outlined,
                  child: Text("sEARCH",style: TextStyle(color: ColorManager.white),),
                ),
              )
            ],
          );
  }
}

class _SearchScreen extends StatefulWidget {
  const _SearchScreen();

  @override
  State<_SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<_SearchScreen> {

  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController=TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(didPop){
          return ;
        }
        SearchPersonsCubit.get(context).init();
        NavigatorManager.pop(context: context);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    IconButton(onPressed: ()=>NavigatorManager.pop(context: context), icon: Icon(Icons.back_hand)),
                    Expanded(
                      child: CustomTextFormField(
                        textFormFieldProperties:TextFormFieldProperties(
                          controller:_searchController,
                          onChanged: (value) {
                            SearchPersonsCubit.get(context).searchPersons(value);
                          },
                        )
                      )
                    )
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<SearchPersonsCubit,SearchPersonsStates>(
                  builder: (context, state) {
                    if(state is SearchPersonsLoading){
                      return LoadingWidget();
                    }
                    if(state is SearchPersonsFailed){
                      if(state.persons.isEmpty){
                        return ExceptionWidget(message: state.message);
                      }
                      return ListView.separated(
                        itemCount: state.persons.length,
                        itemBuilder: (context,index)=>PersonSearchItem(person: state.persons[index]), 
                        separatorBuilder: (context,index)=>SizedBox(height: 10,), 
                        
                      );
                    }
                    if(state is SearchPersonsSuccess){
                      if(state.persons.isEmpty){
                        return const ExceptionWidget(message: "There Are No Persons Matches This Query");
                      }
                      return ListView.separated(
                        itemCount: state.persons.length,
                        itemBuilder: (context,index)=>PersonSearchItem(person: state.persons[index]), 
                        separatorBuilder: (context,index)=>SizedBox(height: 10,), 
                        
                      );
                    }
                    return ExceptionWidget(
                      widget: Icon(Icons.search),
                      message: "Search Now",
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



class PersonSearchItem extends StatelessWidget {
  const PersonSearchItem({super.key,required this.person});
  final Person person;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorManager.push(context: context, widget: ProfileScreen(person: person,asScaffold: true,));
      },
      child: Row(
        children: [
          ProfileImageWidget(imageDetails: person.image==null?null:NetworkImageDetails(url: person.image!),),
          Expanded(
            child: Text(
              person.name,
            ),
          )
        ],
      ),
    );
  }
}
