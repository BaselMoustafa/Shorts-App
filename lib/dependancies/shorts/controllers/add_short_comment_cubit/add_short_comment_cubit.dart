import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/comment.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';

import '../../domain/usecases/add_short_comment_usecase.dart';
import 'add_short_comment_cubit_states.dart';

class AddShortCommentCubit extends Cubit<AddShortCommentStates>{
  final AddShortCommentUsecase addShortCommentUsecase;

  AddShortCommentCubit({
    required this.addShortCommentUsecase,
  }):super(AddShortCommentInitial());

  static AddShortCommentCubit get(BuildContext context)=>BlocProvider.of(context);


  Future<void>addShortComment({
    required Short short,
    required NewComment newComment,
  })async{
    emit(AddShortCommentLoading(
      newComment: newComment,
      short:short.increamentComments(), 
    ));
    Either<Failure,UploadedComment>likedOrFailure=await addShortCommentUsecase.excute(
      short: short,
      newComment: newComment,
    );
    likedOrFailure.fold(
      (Failure failure){
        emit(AddShortCommentFailed(short: short,newComment: newComment,message: failure.message));
      }, 
      (UploadedComment uploadedComment){
        emit(AddShortCommentSuccess());
      }
    );
  }
}
