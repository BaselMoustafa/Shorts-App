import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/managers/navigator_manager.dart';
import 'package:shorts_app/core/widgets/block_interaction_loading_widget.dart';
import 'package:shorts_app/core/widgets/profile_image_widget.dart';
import 'package:shorts_app/core/widgets/show_my_snackbar.dart';
import 'package:shorts_app/dependancies/persons/domain/models/another_person.dart';
import 'package:shorts_app/dependancies/persons/domain/models/my_person.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person.dart';
import 'package:shorts_app/core/models/image_details.dart';
import 'package:shorts_app/dependancies/shorts/controllers/get_short_comments_cubit/get_short_comments_cubit.dart';
import 'package:shorts_app/features/authantication/presentation/screens/sign_up_screen.dart';
import 'package:shorts_app/features/home/get_home_shorts_cubit/get_home_shorts_cubit.dart';
import 'package:shorts_app/features/profile/controllers/get_profile_shorts_cubit/get_profile_shorts_cubit.dart';
import 'package:shorts_app/features/profile/controllers/signout_cubit/sign_out_cubit.dart';
import 'package:shorts_app/features/profile/controllers/signout_cubit/signout_cubit_states.dart';
import 'package:shorts_app/features/profile/controllers/update_my_person_cubit/update_my_person_cubit.dart';
import 'package:shorts_app/features/profile/controllers/update_my_person_cubit/update_my_person_cubit_states.dart';
import 'package:shorts_app/features/profile/widget/edit_profile_button.dart';
import 'package:shorts_app/features/profile/widget/follow_or_unfollow_person_button.dart';
import 'package:shorts_app/features/profile/widget/get_profile_shorts_bloc_builder.dart';
import 'package:shorts_app/features/profile/widget/logoutButton.dart';
import 'package:shorts_app/features/profile/widget/person_counters_widget.dart';
import '../../../core/managers/color_manager.dart';
import '../../../dependancies/persons/controllers/get_my_person_cubit/get_my_person_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key,required this.person,this.asScaffold=false});
  final bool asScaffold;
  final Person person;
  @override
  Widget build(BuildContext context) {
    if(asScaffold){
      return Scaffold(
        appBar: AppBar(),
        body: _WidgetDesign(person: person),
      );
    }
    return _WidgetDesign(person: person);
  }
}

class _WidgetDesign extends StatefulWidget {
  const _WidgetDesign({
    required this.person,
  });

  final Person person;

  @override
  State<_WidgetDesign> createState() => _WidgetDesignState();
}

class _WidgetDesignState extends State<_WidgetDesign> {

  late Person _person;
  @override
  void initState() {
    super.initState();
    _person=widget.person is AnotherPerson?widget.person:GetMyPersonCubit.myPerson;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    GetProfileShortsCubit.get(context).getProfileShorts(_person.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateMyPersonCubit,UpdateMyPersonStates>(
      listener: _updateMyPersonCubitBlocListener,
      child: BlocConsumer<SignOutCubit,SignOutCubitStates>(
        listener: _signoutBlocListener,
        builder: (context, state) {
          return BlockInteractionLoadingWidget(
            isLoading: state is SignOutLoadingState,
            widget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  const SizedBox(height: 10,),
                  Center(
                    child: ProfileImageWidget(
                      radius: 70,
                      imageDetails: _person.image==null?null:NetworkImageDetails(url: _person.image!),
                    ),
                  ),
            
                  const SizedBox(height: 10,),
                  _PersonName(person: _person),
            
                  if(_person.bio!=null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: _PersonBio(person: _person),
                  ),
            
                  const SizedBox(height: 10,),
                  PersonCountersWidget(person: _person),
            
                  const SizedBox(height: 20,),
                  _person is ! MyPerson?  
                    FollowOrUnfollowPersonButton(anotherPerson: _person as AnotherPerson,)
                    :const Row(
                      children: [
                        Expanded(child:EditProfileButton()),
                        SizedBox(width: 10,),
                        Expanded(child:LogoutButton()),
                      ],
                    )
                    ,
            
                  const SizedBox(height: 20,),
                  const GetProfileShortsBlocBuilder(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _signoutBlocListener(context, state) {
    if(state is SignOutFailedState){
      showMySnackBar(context: context, content: Text(state.message));
    }
    else if(state is SignOutSuccessState){
      GetHomeShortsCubit.get(context).init();
      GetProfileShortsCubit.get(context).init();
      GetShortCommentsCubit.get(context).init();
      NavigatorManager.pushAndRemoveUntil(
        context: context, 
        widget: const SignUpScreen()
      );
    }
  }

  void _updateMyPersonCubitBlocListener(context, state) {
    if(state is UpdateMyPersonSuccess&& _person.id==state.myPerson.id){
      setState(() {
        _person=state.myPerson;
      });
    }
  }
}

class _PersonBio extends StatelessWidget {
  const _PersonBio({required this.person});

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Text(
      person.bio!,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: ColorManager.grey,
        fontSize: 16,
      ),
    );
  }
}

class _PersonName extends StatelessWidget {
  const _PersonName({required this.person});

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        person.name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: ColorManager.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}




