import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shorts_app/dependancies/persons/controllers/get_my_person_cubit/get_my_person_cubit.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short_Info.dart';
import 'package:shorts_app/features/add_short/screens/add_details_screen.dart';
import 'package:shorts_app/features/add_short/widgets/pick_video_button.dart';
import 'package:shorts_app/features/add_short/widgets/short_max_duration_selector.dart';
import '../../../core/managers/navigator_manager.dart';
import '../widgets/camera_preview_widget.dart';
import '../widgets/record_video_button.dart';

class AddShortScreen extends StatefulWidget {
  const AddShortScreen({super.key});

  @override
  State<AddShortScreen> createState() => _AddShortScreenState();
}

class _AddShortScreenState extends State<AddShortScreen> {

  late final ValueNotifier<Duration>_maxDurationValueNotifier;

  @override
  void initState() {
    super.initState();
    _maxDurationValueNotifier=ValueNotifier(const Duration(seconds: 15));
  }

  @override
  void dispose() {
    _maxDurationValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const CameraPreviewWidget(),
        ),
    
        PositionedDirectional(
          end: 0,start: 0,top: 50,
          child: ShortMaxDurationSelector(
            maxDurationValueNotifier: _maxDurationValueNotifier,
          ),
        ),
    
        PositionedDirectional(
          end: 0,start: 0,bottom: 20,
          child: RecordVideoButton(
            maxDurationValueNotifier: _maxDurationValueNotifier,
            onVideoPicked: _onVideoPicked,
          ),
        ),

        PositionedDirectional(
          end: 10,bottom: 15,
          child: PickVideoButton(
            maxDurationValueNotifier: _maxDurationValueNotifier,
            onVideoPicked: _onVideoPicked,
          ),
        ),
      ],
    );
  }

  void _onVideoPicked (File videoFile) {
    NavigatorManager.push(
      context: context, 
      widget: AddDetailsScreen(newShortInfo: NewShortInfo(
        videoFile: videoFile,
        caption: null,
        from: GetMyPersonCubit.myPerson,
      ),),
    );
  }
}
