import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shorts_app/core/widgets/custom_button.dart';
import 'package:shorts_app/core/widgets/user_name_form_field.dart';
import 'package:shorts_app/dependancies/persons/controllers/get_my_person_cubit/get_my_person_cubit.dart';
import 'package:shorts_app/dependancies/persons/domain/models/my_person.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person_update_Info.dart';
import 'package:shorts_app/features/profile/controllers/update_my_person_cubit/update_my_person_cubit.dart';

import '../../../core/models/image_details.dart';
import '../widget/bio_text_field.dart';
import '../widget/editable_profile_image_widget.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _userNameTextController;
  late final TextEditingController _bioTextController;
  late final ValueNotifier<ImageDetails?>_imageDetailsValueNotifier;
  late final GlobalKey<FormState>_formKey;
  @override
  void initState() {
    super.initState();
    MyPerson myPerson=GetMyPersonCubit.myPerson;
    _formKey=GlobalKey();
    _userNameTextController=TextEditingController()..text=myPerson.name;
    _bioTextController=TextEditingController()..text=myPerson.bio??"";
    _imageDetailsValueNotifier=ValueNotifier(myPerson.image==null?null:NetworkImageDetails(url: myPerson.image!));
  }

  @override
  void dispose() {
    _userNameTextController.dispose();
    _bioTextController.dispose();
    _imageDetailsValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Edit Profile"),),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(height: 20,),
              ),
              SliverToBoxAdapter(
                child: EditableProfileImageWidget(
                  imageDetailsValueNotifier: _imageDetailsValueNotifier,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 40,),
              ),
              Form(
                key: _formKey,
                child: SliverToBoxAdapter(
                  child: UserNameFormFiled(userNameController: _userNameTextController),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 15,),
              ),
              SliverToBoxAdapter(
                child: BioTextField(bioTextController: _bioTextController),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child:_EditButton(state: this,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({
    required this.state,
  });
  final _EditProfileScreenState state;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10,top: 20),
        child: CustomButton(
          onTap: ()=>_onTap(context),
          child:const Text("Edit"), 
        ),
      ),
    );
  }

  void _onTap(BuildContext context){
    if(state._formKey.currentState!.validate()==false){
      return ;
    }
    FocusScope.of(context).unfocus();
    ImageDetails? imageDetails=state._imageDetailsValueNotifier.value;
    File? imageFile;
    if(imageDetails is FileImageDetails){
      imageFile=imageDetails.imageFile;
    }
    UpdateMyPersonCubit.get(context).updateMyPerson(
      NewPeronUpdateInfo(
        currentPeron: GetMyPersonCubit.myPerson, 
        name: state._userNameTextController.text, 
        bio: state._bioTextController.text, 
        profileImageUpdate: imageDetails==null?RemoveProfileImage():AddProfileImage(imageFile:imageFile),
      )
    );
  }
}