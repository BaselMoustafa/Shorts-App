import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/managers/color_manager.dart';
import 'package:shorts_app/core/widgets/comments_bottom_sheet/comment_widget.dart';
import 'package:shorts_app/core/widgets/custom_button.dart';
import 'package:shorts_app/core/widgets/exception_widget.dart';
import 'package:shorts_app/core/widgets/loading_widget.dart';
import 'package:shorts_app/dependancies/shorts/controllers/get_short_comments_cubit/get_short_comments_cubit.dart';
import 'package:shorts_app/dependancies/shorts/controllers/get_short_comments_cubit/get_short_comments_cubit_states.dart';

class ShortCommentsListView extends StatelessWidget {
  const ShortCommentsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<GetShortCommentsCubit,GetShortCommentsStates>(
        builder: (context, state) {
          if(state is GetShortCommentsLoading){
            return Column(
              children: [
                const LoadingWidget(),
              ],
            );
          }
          if(state is GetShortCommentsFailed){
            return Column(
              children: [
                ExceptionWidget(
                      color: ColorManager.black,
                      message:state.message,
                      actionWidget: CustomButton(
                        onTap: (){
                          GetShortCommentsCubit.get(context).tryToGetAgain();
                        },
                        child: Text("Try Again"), 
                      ),
                    ),
              ],
            );
          }
          if(state is GetShortCommentsSuccess){
            if(state.comments.isEmpty){
              return const ExceptionWidget(color: ColorManager.black,message: "There Are No Comments Yet");
            }
            return Column(
              children: [
                for(int i=0;i<state.comments.length;i++)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CommentWidget(comment: state.comments[i]),
                )
              ],
              
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
