import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/managers/color_manager.dart';
import 'package:shorts_app/dependancies/persons/controllers/get_my_person_cubit/get_my_person_cubit.dart';
import 'package:shorts_app/core/widgets/show_my_snackbar.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short_Info.dart';
import 'package:shorts_app/core/models/video_controller_info.dart';
import 'package:shorts_app/features/add_short/add_short_cubit/add_short_cubit.dart';
import 'package:shorts_app/features/add_short/add_short_cubit/add_short_cubit_states.dart';
import 'package:shorts_app/features/add_short/screens/short_preview_screen.dart';
import 'package:shorts_app/core/widgets/custom_button.dart';
import 'package:shorts_app/core/widgets/short_preview_widget.dart';

import '../../../core/managers/navigator_manager.dart';

class AddDetailsScreen extends StatefulWidget {
  const AddDetailsScreen({super.key,required this.newShortInfo});
  final NewShortInfo newShortInfo;

  @override
  State<AddDetailsScreen> createState() => _AddDetailsScreenState();
}

class _AddDetailsScreenState extends State<AddDetailsScreen> {
  late final TextEditingController _captionController;

  @override
  void initState() {
    super.initState();
    _captionController=TextEditingController()..text=widget.newShortInfo.caption??"";
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddShortCubit,AddShortStates>(
      listener: (context, state) {
        if(state is AddShortLoadingState){
          NavigatorManager.pop(context: context);
          showMySnackBar(context: context, color: ColorManager.green,content: const Text("Upload Is On Progress, Will Notify You When Complete"));
        }
      },
      child: GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title:const Text("Add Details"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20,),
                ),
                SliverToBoxAdapter(
                  child: _ShortPreviewWidget(videoFile: widget.newShortInfo.videoFile),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20,),
                ),
                SliverToBoxAdapter(
                  child: Text(
                  "Caption",
                  style:Theme.of(context).textTheme.bodyMedium,
                ),
                ),
                SliverToBoxAdapter(
                  child: _CaptionTextField(
                    captionController: _captionController,
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:Padding(
                      padding:const EdgeInsets.symmetric(vertical: 10),
                      child: _UploadShortButton(state: this,),
                    ) ,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShortPreviewWidget extends StatelessWidget {
  const _ShortPreviewWidget({required this.videoFile});
  final File videoFile;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.25,
      child: Align(
        child: ShortPreviewWidget(
          onTap: ()=>_onTap(context),
          videoInfo: FileVideoInfo(file: videoFile),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    NavigatorManager.push(
      context: context, 
      widget: ShortPreviewScreen(videoFile: videoFile),
    );  
  }
}

class _CaptionTextField extends StatelessWidget {
  const _CaptionTextField({
    required this.captionController,
  });
  final TextEditingController captionController;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: captionController,
      maxLength: 150,
      minLines: 1,
      maxLines: 100,
      style: Theme.of(context).textTheme.headlineMedium,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: "Write a caption here ....",
        hintStyle: Theme.of(context).textTheme.labelLarge,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}

class _UploadShortButton extends StatelessWidget {
  const _UploadShortButton({
    required this.state,
  });
  final _AddDetailsScreenState state;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: ()=>_uploadShort(context),
      child: const Text("Upload Short"), 
    );
  }

  void _uploadShort(BuildContext context){
    FocusScope.of(context).unfocus();
    AddShortCubit.get(context).addShort(
      newShortInfo: NewShortInfo(
        videoFile: state.widget.newShortInfo.videoFile, 
        caption: state._captionController.text, 
        from: GetMyPersonCubit.myPerson,
      ),
    );
  }
}




