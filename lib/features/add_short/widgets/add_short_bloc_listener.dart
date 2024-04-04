import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/features/add_short/add_short_cubit/add_short_cubit_states.dart';
import '../add_short_cubit/add_short_cubit.dart';

class AddShortBlocListener extends StatelessWidget {
  const AddShortBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddShortCubit,AddShortStates>(
      listener: (context, state) {
        
      },
    );
  }
}