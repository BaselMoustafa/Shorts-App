import 'package:dartz/dartz.dart';
import 'package:shorts_app/core/error/exceptions.dart';
import 'package:shorts_app/core/error/failure_messages.dart';
import 'package:shorts_app/core/error/failures.dart';
import 'package:shorts_app/core/network/network_connection_info/network_connection_info.dart';
import 'package:shorts_app/dependancies/shorts/data/data_source/shorts_local_datasource.dart';
import 'package:shorts_app/dependancies/shorts/data/data_source/shorts_remote_data_source.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/comment.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short_Info.dart';
import 'package:shorts_app/dependancies/shorts/domain/repo/shorts_repo.dart';

class ShortsRepoImpl extends ShortsRepo{
  final ShortsRemoteDataSource shortsRemoteDataSource;
  final ShortsLocalDataSource shortsLocalDataSource;
  final NetworkConnectionInfo networkConnectionInfo;
  const ShortsRepoImpl({
    required this.shortsRemoteDataSource,
    required this.networkConnectionInfo,
    required this.shortsLocalDataSource,
  });

  @override
  Future<Either<AddShortFailure, Short>> addShort({required NewShortInfo newShortInfo})async{
    if(! await networkConnectionInfo.isConnected){
      return Left(AddShortFailure(message: FailureMessages.noInternet, newShortInfo: newShortInfo));
    }
    try {
      return Right(Short.fromUploadedShortInfo(
        uploadedShortInfo: await shortsRemoteDataSource.addShort(newShortInfo: newShortInfo),
      ));
    } on AddShortException catch (ex) {
      return Left(AddShortFailure(message: ex.message, newShortInfo: newShortInfo));
    }
  }

  @override
  Future<Either<Failure,List<Short>>> getHomeShorts({required int limit})async{
    return await _failureHandler(
      functionToExcute: () async{
        return await shortsRemoteDataSource.getHomeShorts(
          limit: limit,
          userId: shortsLocalDataSource.userId(),
        );
      },
    );
  }

  @override
  Future<Either<Failure,List<Short>>> getProfileShorts(String userId)async{
    return await _failureHandler(
      functionToExcute: () async{
        return await shortsRemoteDataSource.getProfileShorts(userId);
      },
    );
  }

  @override
  Future<Either<Failure, UploadedComment>> addShortComment({required Short short, required NewComment newComment})async{
    return await _failureHandler(
      functionToExcute: () async{
        return await shortsRemoteDataSource.addShortComment(newComment);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> addOrRemoveShortLike({required Short short})async{
    return await _failureHandler(
      functionToExcute: ()async {
        return  short.likedByMyPerson?await _removeShortLike(short: short):await _addShortLike(short: short);
      },
    );
  }
  
  Future<Unit> _addShortLike({required Short short})async{
    return await shortsRemoteDataSource.addShortLike(
      shortsLocalDataSource.userId(), short
    );
  }

  Future<Unit> _removeShortLike({required Short short})async{
    return await shortsRemoteDataSource.removeShortLike(
      shortsLocalDataSource.userId(), short
    );
  }

  @override
  Future<Either<Failure, Unit>> addShortView({required Short short})async{
    return await _failureHandler(
      functionToExcute: () async{
        return await shortsRemoteDataSource.addShortView(
          shortsLocalDataSource.userId(), short
        );
      },
    );
  }

  @override
  Future<Either<Failure, List<UploadedComment>>> getShortComments({required String shortId}) async{
    return await _failureHandler(
      functionToExcute: () async{
        return await shortsRemoteDataSource.getShortComments(shortId);
      },
    );
  }

  Future<Either<Failure,T>>_failureHandler<T>({
    required Future<T> Function() functionToExcute,
  })async{
    if(await networkConnectionInfo.isConnected){
      try {
        return Right(await functionToExcute());
      } on RemoteDataBaseException catch (ex) {
        return Left(RemoteDataBaseFailure(message: ex.message));
      } on LocalDataBaseException catch (ex){
        return Left(LocalDataBaseFailure(message: ex.message));
      }
    }
    return const Left(OfflineFailure());
  }

  @override
  List<Object?> get props => [shortsRemoteDataSource,networkConnectionInfo];
  
}