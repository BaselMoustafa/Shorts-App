import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/widgets/exception_widget.dart';
import 'package:shorts_app/core/widgets/loading_widget.dart';
import 'package:shorts_app/features/profile/controllers/get_profile_shorts_cubit/get_profile_shorts_cubit.dart';
import 'package:shorts_app/features/profile/controllers/get_profile_shorts_cubit/get_profile_shorts_cubit_states.dart';
import 'package:shorts_app/features/profile/widget/shorts_grid_view.dart';

class GetProfileShortsBlocBuilder extends StatelessWidget {
  const GetProfileShortsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProfileShortsCubit,GetProfileShortsStates>(
      builder: (context, state) {
        if(state is GetProfileShortsLoadingState){
          return const LoadingWidget();
        }
        if(state is GetProfileShortsFailedState){
          return _ExceptionWidget(message: state.message,);
        }
        if(state is GetProfileShortsSuccessState){
          return ShortsGridView(shorts: state.shorts);
        }
        return const SizedBox();
      },
    );
  }
}

class _ExceptionWidget extends StatelessWidget {
  const _ExceptionWidget({required this.message});

  final String message;
  @override
  Widget build(BuildContext context) {
    return ExceptionWidget(
      message: message,
      onTryAgain: () {
        GetProfileShortsCubit.get(context).tryToGetAgain();
      },
    );
  }
}