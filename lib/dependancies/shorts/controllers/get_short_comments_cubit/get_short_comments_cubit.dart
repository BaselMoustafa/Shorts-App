import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/comment.dart';
import '../../domain/usecases/get_short_comments_usecsae.dart';
import 'get_short_comments_cubit_states.dart';

class GetShortCommentsCubit extends Cubit<GetShortCommentsStates>{
  final GetShortCommentsUsecase getShortCommentsUsecase;

  GetShortCommentsCubit({
    required this.getShortCommentsUsecase,
  }):super(GetShortCommentsInitial());

  static GetShortCommentsCubit get(BuildContext context)=>BlocProvider.of(context);

  String _currentShortId="";
  List<Comment>_comments=[];

  Future<void>getShortComments({required String shortId})async{
    if(_currentShortId==shortId){
      emit(GetShortCommentsSuccess(comments: _comments));
      return ;
    }
    _currentShortId=shortId;
    emit(GetShortCommentsLoading());
    Either<Failure,List<UploadedComment>>uploadedOrFailure= await getShortCommentsUsecase.excute(shortId);
    uploadedOrFailure.fold(
      (Failure failure){
        emit(GetShortCommentsFailed(message: failure.message));
      }, 
      (List<UploadedComment> comments){
        _comments=List.from(comments);
        emit(GetShortCommentsSuccess(comments: _comments));
      }
    );
  }

  void addComment(NewComment newComment){
    if(_comments.contains(newComment)){
      return ;
    }
    if(_currentShortId==newComment.shortId){
      _comments.insert(0, newComment);
      emit(GetShortCommentsSuccess(comments: _comments));
    }
  }

  void removeComment(NewComment newComment){
    if(_currentShortId==newComment.shortId){
      _comments.remove(newComment);
      emit(GetShortCommentsSuccess(comments: _comments));
    }
  }

  Future<void>tryToGetAgain()async{
    getShortComments(shortId: _currentShortId);
  }

}