import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/widgets/block_interaction_loading_widget.dart';
import 'package:shorts_app/core/widgets/show_my_snackbar.dart';
import 'package:shorts_app/features/authantication/presentation/controllers/email_authantication_cubit/email_authantication_cubit.dart';
import 'package:shorts_app/features/authantication/presentation/controllers/email_authantication_cubit/email_authantication_cubit_states.dart';
import 'package:shorts_app/features/authantication/presentation/controllers/google_authantication_cubit/google_authantication_cubit.dart';
import 'package:shorts_app/features/authantication/presentation/controllers/google_authantication_cubit/google_authantication_cubit_states.dart';
import 'package:shorts_app/features/authantication/presentation/screens/wait_for_verification_screen.dart';

import '../../../../core/managers/navigator_manager.dart';
import '../../../../core/widgets/get_my_person_bloc_builder.dart';

class GoogleAndEmailBlocListeners extends StatefulWidget {
  const GoogleAndEmailBlocListeners({super.key,required this.widget});
  final Widget widget;
  @override
  State<GoogleAndEmailBlocListeners> createState() => _GoogleAndEmailBlocListenersState();
}

class _GoogleAndEmailBlocListenersState extends State<GoogleAndEmailBlocListeners> {

  bool _isLoading=false;

  BlocListener<GoogleAuthanticationCubit,GoogleAuthanticationCubitStates> get _googleAuthBlocListener=>BlocListener(
    listener: (context, state) {
      if(state is GoogleAuthanticationLoadingState){
        _isLoading=true;
      }else{
        _isLoading=false;
        if(state is GoogleAuthanticationFailedState){
          showMySnackBar(context: context, content: Text(state.message));
        }else if(state is GoogleAuthanticationSuccessState){
          NavigatorManager.pushAndRemoveUntil(context: context, widget: const GetMtPersonBlocBuilder());
        }
      }
      setState(() {});
    },
  );

  BlocListener<EmailAuthanticationCubit,EmailAuthanticationCubitStates> get _emailAuthBlocListener=>BlocListener(
    listener: (context, state) {
      if(state is EmailAuthanticationLoadingState){
        _isLoading=true;
      }else{
        _isLoading=false;
        setState(() {});
        if(state is EmailAuthanticationFailedState){
          showMySnackBar(context: context, content: Text(state.message));
        }else if(state is EmailAuthanticationSuccessState){
          NavigatorManager.pushAndRemoveUntil(context: context, widget: const GetMtPersonBlocBuilder());
        }else if(state is EmailAuthanticationWaitingVerificationState){
          NavigatorManager.push(context: context, widget: const WaitForVerificationScreen());
        }
      }
      
    },
  );
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        _googleAuthBlocListener,
        _emailAuthBlocListener,
      ], 
      child: BlockInteractionLoadingWidget(
        isLoading: _isLoading,
        widget:widget.widget,
      )
    );
  }
}