import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shorts_app/core/constants/constants.dart';
import 'package:shorts_app/core/error/exceptions.dart';
import 'package:shorts_app/core/network/firebase/cloud_storage_helper/cloud_storage_helper.dart';
import 'package:shorts_app/core/network/firebase/fire_store_helper/fire_store_filter/limit_filter.dart';
import 'package:shorts_app/core/network/firebase/fire_store_helper/fire_store_filter/order_by_filter.dart';
import 'package:shorts_app/core/network/firebase/fire_store_helper/fire_store_filter/where_filter.dart';
import 'package:shorts_app/core/network/firebase/fire_store_helper/fire_store_helper.dart';
import 'package:shorts_app/core/network/firebase/fire_store_helper/get_collection_output.dart';
import 'package:shorts_app/dependancies/persons/data/data_source/persons_remote_data_source.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/comment.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short_Info.dart';

abstract class ShortsRemoteDataSource {
  const ShortsRemoteDataSource();

  Future<List<Short>> getHomeShorts({required String personId,required int limit});

  Future<UploadedShortInfo> addShort({required NewShortInfo newShortInfo,});

  Future<UploadedComment>addShortComment(NewComment newComment);

  Future<Unit>addShortLike(String personId,Short short);

  Future<Unit>removeShortLike(String personId,Short short);
  
  Future<Unit>addShortView(String personId,Short short);

  Future<List<UploadedComment>>getShortComments({
    required String shortId,
    required String myPersonId,
  });

  Future<List<Short>>getProfileShorts({required String personId,required String myPeronId});
}

class ShortsRemoteDataSourceImpl extends ShortsRemoteDataSource{
  final FireStoreHelper fireStoreHelper;
  final CloudStorageHelper cloudStorageHelper;
  final PersonsRemoteDataSource personsRemoteDataSource;
  List<QueryDocumentSnapshot>_currentHomeShoresDocs=[];


  ShortsRemoteDataSourceImpl({
    required this.cloudStorageHelper,
    required this.fireStoreHelper,
    required this.personsRemoteDataSource,
  });

  @override
  Future<UploadedShortInfo> addShort({required NewShortInfo newShortInfo,})async{
    return _tryAndCatchBlock(
      message: "Failed To Add Your Short", 
      customException: AddShortException(newShortInfo: newShortInfo, message: "Failed To Add Your Short"),
      functionToExcute: ()async {
        String videoUrl= await cloudStorageHelper.uploadFile(
          file: newShortInfo.videoFile, 
          path: [newShortInfo.from.id],
        );
        DateTime currentTime=DateTime.now();
        String id=await fireStoreHelper.add(
          collectionPath: [KConst.shortsCollection], 
          data: newShortInfo.toFireStore(date: currentTime, videoUrl: videoUrl),
        );
        return UploadedShortInfo.fromNewShortInfo(newShortInfo: newShortInfo, id: id, url: videoUrl, date: currentTime);
      },
    );
  }

  @override
  Future<List<Short>> getHomeShorts({
    required String personId,
    required int limit,
  }) async{
    return await _tryAndCatchBlock(
      message: "Failed To Get Home Shorts", 
      functionToExcute: ()async {
        GetCollectionOutput result=await fireStoreHelper.paginate(
          path: [KConst.shortsCollection,],
          currentDocs: _currentHomeShoresDocs,
          fireStoreFilters: [
            const OrderByFilter(filedName: KConst.date,descending: true),
            LimitFilter(limit: limit)
          ]
        );
        _currentHomeShoresDocs=result.docs;
        return await _modelShorts(myPersonId: personId,shorts: result.data, personId: personId);
      },
    );
  }

  @override
  Future<List<Short>>getProfileShorts({required String personId,required String myPeronId})async{
    
    return await _tryAndCatchBlock(
      message: "Failed To Get Comments", 
      functionToExcute: ()async {
        GetCollectionOutput result=await fireStoreHelper.getCollection(
          path: [KConst.shortsCollection],
          fireStoreFilters: [
            WhereIsEqualTo(fieldName: KConst.from, value: personId),
            const OrderByFilter(filedName: KConst.date,descending: true),
          ]
        );
        return await _modelShorts(
          person: await personsRemoteDataSource.getPeron(personId: personId,myPersonId:myPeronId ), 
          shorts: result.data, 
          personId: personId,
          myPersonId: myPeronId
        );
      },
    );
  }

  Future<List<Short>>_modelShorts({
    Person? person,
    required List<Map<String,dynamic>>shorts,
    required String personId,
    required String myPersonId
  })async{
    final List<Short>toReturn=[];
    for (var i = 0; i < shorts.length; i++) {
      shorts[i][KConst.likedByMyPerson]=await _shortLikedByMyPerson(myPersonId,shorts[i]);
      shorts[i][KConst.viewsCount]=await _getShortViewsCount(shorts[i]);
      shorts[i][KConst.likesCount]=await _getShortLikesCount(shorts[i]);
      shorts[i][KConst.commentsCount]=await _getShortCommentsCount(shorts[i]);
      toReturn.add(
        Short.fromFireStore(
          map: shorts[i],
          from:person ??await personsRemoteDataSource.getPeron(
            personId: shorts[i][KConst.from],
            myPersonId: myPersonId,
          ),
        )
      );
    }
    return toReturn;
  }

  @override
  Future<UploadedComment> addShortComment(NewComment newComment) async{
    return await _tryAndCatchBlock(
      message:"Failed To Add The Comment",
      functionToExcute: () async{
        String commentId=await fireStoreHelper.add(
          collectionPath: [KConst.commentsShortsCollection], 
          data: newComment.toMap(),
        );
        return UploadedComment.fromNewComment(id: commentId, newComment: newComment);
      },
    );
  }
  
  @override
  Future<Unit> addShortLike(String personId,Short short) async{
    return await _tryAndCatchBlock(
      message:"Failed To Add The Like",
      functionToExcute: () async{
        await fireStoreHelper.add(
          collectionPath: [KConst.likesShortsCollection], 
          data:{
            KConst.short:short.id,
            KConst.from:personId,
            KConst.to:short.from.id,
            KConst.date:DateTime.now(),
          },
        );
        return unit;
      },
    );
  }

  @override
  Future<Unit>removeShortLike(String personId,Short short)async{
    return await _tryAndCatchBlock(
      message:"Failed To Remove The Like",
      functionToExcute: () async{
        await fireStoreHelper.deleteCollection(
          collectionPath: [KConst.likesShortsCollection], 
          fireStoreFilters: [
            WhereIsEqualTo(fieldName: KConst.from, value: personId),
            WhereIsEqualTo(fieldName: KConst.short, value: short.id),
          ]
        );
        return unit;
      },
    );
  }
  
  @override
  Future<Unit> addShortView(String personId,Short short) async{
    return await _tryAndCatchBlock(
      message:"Failed To Add The View",
      functionToExcute: () async{
        await fireStoreHelper.add(
          collectionPath: [KConst.viewsShortsCollection], 
          data:{
            KConst.short:short.id,
            KConst.from:personId,
            KConst.to:short.from.id,
            KConst.date:DateTime.now(),
          },
        );
        return unit;
      },
    );
  }

  Future<bool> _shortLikedByMyPerson(String personId,Map<String, dynamic> short) async{
    GetCollectionOutput result= await fireStoreHelper.getCollection(
      path: [KConst.likesShortsCollection],
      fireStoreFilters: [
        WhereIsEqualTo(fieldName: KConst.from, value:personId),
        WhereIsEqualTo(fieldName: KConst.short, value:short[KConst.id]),
      ],
    );
    return result.data.length==1;
  }

  Future<int> _getShortViewsCount(Map<String, dynamic> short) async{
    return await fireStoreHelper.numOfDocuments(
      path: [KConst.viewsShortsCollection],
      fireStoreFilters: [
        WhereIsEqualTo(fieldName: KConst.short, value:short[KConst.id]),
      ],
    );
  }

  Future<int> _getShortLikesCount(Map<String, dynamic> short) async{
    return await fireStoreHelper.numOfDocuments(
      path: [KConst.likesShortsCollection],
      fireStoreFilters: [
        WhereIsEqualTo(fieldName: KConst.short, value:short[KConst.id]),
      ],
    );
  }

  Future<int> _getShortCommentsCount(Map<String, dynamic> short) async{
    return await fireStoreHelper.numOfDocuments(
      path: [KConst.commentsShortsCollection],
      fireStoreFilters: [
        WhereIsEqualTo(fieldName: KConst.short, value:short[KConst.id]),
      ],
    );
  }

  @override
  Future<List<UploadedComment>>getShortComments({
    required String shortId,
    required String myPersonId,
  })async{
    return await _tryAndCatchBlock(
      message: "Failed To Get Comments", 
      functionToExcute: ()async {
        List<UploadedComment>toReturn=[];
        GetCollectionOutput result=await fireStoreHelper.getCollection(
          path: [KConst.commentsShortsCollection],
          fireStoreFilters: [
            WhereIsEqualTo(fieldName: KConst.short, value: shortId),
            const OrderByFilter(filedName: KConst.date,descending: true)
          ]
        );
        for (var i = 0; i < result.data.length; i++) {
          toReturn.add(
            UploadedComment.fromFireStore(
              map: result.data[i],
              from:await personsRemoteDataSource.getPeron(
                myPersonId: myPersonId,
                personId: result.data[i][KConst.from],
              ), 
              to:await personsRemoteDataSource.getPeron(
                myPersonId: myPersonId,
                personId: result.data[i][KConst.to],
              ), 
            ),
          );
        }
        return toReturn;
      },
    );
  }

  

  Future<T> _tryAndCatchBlock<T>({
    required String message,
    required Future<T>Function()functionToExcute,
    Exception? customException ,
  })async{
    T t= await functionToExcute().catchError((ex){
      throw customException??RemoteDataBaseException(message: message);
    });
    return t;
  }

}