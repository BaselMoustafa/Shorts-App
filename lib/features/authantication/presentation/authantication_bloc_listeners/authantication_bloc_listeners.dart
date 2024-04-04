// import 'package:animal_adoption_app/core/Widgets/main_layout_widget.dart';
// import 'package:animal_adoption_app/core/Widgets/show_my_toast.dart';
// import 'package:animal_adoption_app/core/resources/navigator_manager.dart';
// import 'package:animal_adoption_app/features/Authantication/View/controllers/email_authantication_cubit/email_authantication_cubit.dart';
// import 'package:animal_adoption_app/features/Authantication/View/controllers/email_authantication_cubit/email_authantication_cubit_states.dart';
// import 'package:animal_adoption_app/features/Authantication/View/controllers/google_authantication_cubit/google_authantication_cubit.dart';
// import 'package:animal_adoption_app/features/Authantication/View/controllers/google_authantication_cubit/google_authantication_cubit_states.dart';
// import 'package:animal_adoption_app/features/Authantication/View/screens/wait_for_verification_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// class AuthanticationBlocListeners {

//   List<BlocListener>get(ValueNotifier<bool>authanticationIsInLoadingStateValueNotifier)=>[
//     _emailAuthanticationBlocListener(authanticationIsInLoadingStateValueNotifier),
//     _googleAuthanticationBlocListener(authanticationIsInLoadingStateValueNotifier),
//   ];

//   BlocListener _emailAuthanticationBlocListener(ValueNotifier<bool>authanticationIsInLoadingStateValueNotifier)=>
//     BlocListener<EmailAuthanticationCubit,EmailAuthanticationCubitStates>(
//       listener: (context, state) {
//         if(state is EmailAuthanticationLoadingState){
//           authanticationIsInLoadingStateValueNotifier.value=true;
//         }else{
//           authanticationIsInLoadingStateValueNotifier.value=false;
//           if(state is EmailAuthanticationSuccessState){
//             NavigatorManager.nagivateToAndCloseThePreviousScreens(context: context, widget:const MainLayoutWidget());
//           }
//           else if(state is EmailAuthanticationFailedState){
//             showMyToast(message: state.message);
//           }
//           else if(state is EmailAuthanticationWaitingVerificationState){
//             NavigatorManager.navigateTo(context: context, widget:const WaitForVerificationScreen());
//           }
//         }
//       },
//     );


//   BlocListener _googleAuthanticationBlocListener(ValueNotifier<bool>authanticationIsInLoadingStateValueNotifier)=>
//     BlocListener<GoogleAuthanticationCubit,GoogleAuthanticationCubitStates>(
//       listener: (context, state) {
//         if(state is GoogleAuthanticationLoadingState){
//             authanticationIsInLoadingStateValueNotifier.value=true;
//         }else{
//           authanticationIsInLoadingStateValueNotifier.value=false;
//           if(state is GoogleAuthanticationSuccessState){
//             NavigatorManager.nagivateToAndCloseThePreviousScreens(context: context, widget:const MainLayoutWidget());
//           }
//           else if(state is GoogleAuthanticationFailedState){
//             showMyToast(message: state.message);
//           }
//         }
//       },
//     );


// }