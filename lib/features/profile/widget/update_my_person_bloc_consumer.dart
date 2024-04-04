import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/managers/navigator_manager.dart';
import 'package:shorts_app/core/widgets/block_interaction_loading_widget.dart';
import 'package:shorts_app/core/widgets/show_my_snackbar.dart';
import 'package:shorts_app/dependancies/persons/controllers/get_my_person_cubit/get_my_person_cubit.dart';
import 'package:shorts_app/features/home/get_home_shorts_cubit/get_home_shorts_cubit.dart';
import 'package:shorts_app/features/profile/controllers/get_profile_shorts_cubit/get_profile_shorts_cubit.dart';
import 'package:shorts_app/features/profile/controllers/update_my_person_cubit/update_my_person_cubit.dart';
import 'package:shorts_app/features/profile/controllers/update_my_person_cubit/update_my_person_cubit_states.dart';
import 'package:shorts_app/features/profile/screens/edit_profile_screen.dart';

class UpdateMyPersonBlocConsumer extends StatelessWidget {
  const UpdateMyPersonBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateMyPersonCubit,UpdateMyPersonStates>(
      listener: (context, state) {
        if(state is UpdateMyPersonFailed){
          showMySnackBar(context: context, content:Text(state.message));
        }
        if(state is UpdateMyPersonSuccess){
          GetMyPersonCubit.get(context).replaceThisPerson(state.myPerson);
          GetHomeShortsCubit.get(context).replaceThisPerson(state.myPerson);
          GetProfileShortsCubit.get(context).replaceThisPerson(state.myPerson);
          NavigatorManager.pop(context: context);
        }
      },
      builder: (context, state) {
        return BlockInteractionLoadingWidget(
          isLoading: state is UpdateMyPersonLoading,
          widget: const EditProfileScreen(), 
        );
      },
      
    );
  }
}