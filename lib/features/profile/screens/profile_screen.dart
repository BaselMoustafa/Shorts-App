import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/widgets/profile_image_widget.dart';
import 'package:shorts_app/dependancies/persons/domain/models/another_person.dart';
import 'package:shorts_app/dependancies/persons/domain/models/my_person.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person.dart';
import 'package:shorts_app/core/models/image_details.dart';
import 'package:shorts_app/features/profile/controllers/get_profile_shorts_cubit/get_profile_shorts_cubit.dart';
import 'package:shorts_app/features/profile/controllers/update_my_person_cubit/update_my_person_cubit.dart';
import 'package:shorts_app/features/profile/controllers/update_my_person_cubit/update_my_person_cubit_states.dart';
import 'package:shorts_app/features/profile/widget/edit_profile_button.dart';
import 'package:shorts_app/features/profile/widget/follow_or_unfollow_person_button.dart';
import 'package:shorts_app/features/profile/widget/get_profile_shorts_bloc_builder.dart';
import 'package:shorts_app/features/profile/widget/person_counters_widget.dart';
import '../../../core/managers/color_manager.dart';

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
    _person=widget.person;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    GetProfileShortsCubit.get(context).getProfileShorts(_person.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateMyPersonCubit,UpdateMyPersonStates>(
      listener: (context, state) {
        if(state is UpdateMyPersonSuccess&& _person.id==state.myPerson.id){
          _person=state.myPerson;
          setState(() {
            
          });
        }
      },
      child: Padding(
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
              padding: const EdgeInsets.only(top: 10),
              child: _PersonBio(person: _person),
            ),
      
            const SizedBox(height: 20,),
            PersonCountersWidget(person: _person),
      
            const SizedBox(height: 20,),
            _person is MyPerson?  
              const EditProfileButton()
              :FollowOrUnfollowPersonButton(anotherPerson: _person as AnotherPerson,),
      
            const SizedBox(height: 20,),
            const GetProfileShortsBlocBuilder(),
          ],
        ),
      ),
    );
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
        fontSize: 14,
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




