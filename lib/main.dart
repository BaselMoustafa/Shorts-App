import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/dependancies/persons/controllers/get_my_person_cubit/get_my_person_cubit.dart';
import 'package:shorts_app/core/service_locator/service_locator.dart';
import 'package:shorts_app/dependancies/shorts/controllers/add_or_remove_short_like_cubit/add_or_remove_short_like_cubit.dart';
import 'package:shorts_app/dependancies/shorts/controllers/add_short_comment_cubit/add_short_comment_cubit.dart';
import 'package:shorts_app/dependancies/shorts/controllers/get_short_comments_cubit/get_short_comments_cubit.dart';
import 'package:shorts_app/features/add_short/add_short_cubit/add_short_cubit.dart';
import 'package:shorts_app/features/authantication/presentation/controllers/email_authantication_cubit/email_authantication_cubit.dart';
import 'package:shorts_app/features/authantication/presentation/controllers/google_authantication_cubit/google_authantication_cubit.dart';
import 'package:shorts_app/features/authantication/presentation/screens/splash_screen.dart';
import 'package:shorts_app/features/home/get_home_shorts_cubit/get_home_shorts_cubit.dart';
import 'package:shorts_app/features/profile/controllers/get_profile_shorts_cubit/get_profile_shorts_cubit.dart';
import 'package:shorts_app/features/profile/controllers/update_my_person_cubit/update_my_person_cubit.dart';
import 'core/managers/theme_manager.dart';

void main(){

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>getIt<EmailAuthanticationCubit>()),
        BlocProvider(create: (context)=>getIt<GoogleAuthanticationCubit>()),
        BlocProvider(create: (context)=>getIt<GetMyPersonCubit>()),
        BlocProvider(create: (context)=>getIt<AddShortCubit>()),
        BlocProvider(create: (context)=>getIt<GetHomeShortsCubit>()),
        BlocProvider(create: (context)=>getIt<AddOrRemoveShortLikeCubit>()),
        BlocProvider(create: (context)=>getIt<AddShortCommentCubit>()),
        BlocProvider(create: (context)=>getIt<GetShortCommentsCubit>()),
        BlocProvider(create: (context)=>getIt<GetProfileShortsCubit>()),
        BlocProvider(create: (context)=>getIt<UpdateMyPersonCubit>()),
      ], 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme:ThemeManager.lightTheme,
        home:const SplashScreen(),
      ),
    );
  }

}


