import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/widgets/custom_button.dart';
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
          print("LOADING=====================");
          return LoadingWidget();
        }
        if(state is GetProfileShortsFailedState){
          print("FAILED=====================");
          return ExceptionWidget(
            message: state.message,
            actionWidget: CustomButton(
              child:const Text("Try Again"), 
              onTap: (){
                GetProfileShortsCubit.get(context).tryToGetAgain();
              },
            ),
          );
        }
        if(state is GetProfileShortsSuccessState){
          print("SUCESS=====================");
          return ShortsGridView(shorts: state.shorts);
        }
        print("INITIAL===================================");
        return SizedBox();
      },
    );
  }
}