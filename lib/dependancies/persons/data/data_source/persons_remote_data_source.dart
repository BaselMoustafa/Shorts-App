import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/constants/constants.dart';
import 'package:shorts_app/core/error/exceptions.dart';
import 'package:shorts_app/core/network/firebase/cloud_storage_helper/cloud_storage_helper.dart';
import 'package:shorts_app/core/network/firebase/fire_store_helper/fire_store_helper.dart';
import 'package:shorts_app/core/network/firebase/fire_store_helper/get_collection_output.dart';
import '../../../../core/network/firebase/fire_store_helper/fire_store_filter/where_filter.dart';
import '../../domain/models/my_person.dart';
import '../../domain/models/person.dart';
import '../../domain/models/person_update_Info.dart';

abstract class PersonsRemoteDataSource extends Equatable{
  const PersonsRemoteDataSource();
  Future<Person>getPeron({required String personId,required String myPersonId});
  Future<Unit >followPerson({required String anotherUserId,required String myUserId});
  Future<Unit >unFollowPerson({required String anotherUserId,required String myUserId});
  Future<MyPerson>updateMyPerson(NewPeronUpdateInfo newPeronUpdateInfo);
  Future<List<Person>>searchPersons({required String query ,required String myPersonId});
}

class PersonsRemoteDataSourceImpl extends PersonsRemoteDataSource{
  final FireStoreHelper fireStoreHelper;
  final CloudStorageHelper cloudStorageHelper;

  const PersonsRemoteDataSourceImpl({
    required this.cloudStorageHelper,
    required this.fireStoreHelper,
  });

  @override
  Future<Person>getPeron({required String personId,required String myPersonId})async{
    return await _tryAndCatchBlock(
      message: "Failed To Get The Person", 
      functionToExcute: ()async {
        Map<String,dynamic> person=await fireStoreHelper.getDocument(
          path: [KConst.personsCollection,personId],
        );
        await _addPersonCounters(person: person,personId: personId, myPersonId: myPersonId);
        return Person.fromMap(myPersonId: myPersonId, person: person);
      },
    );
  }

  Future<void>_addPersonCounters({required Map<String,dynamic>person,required String personId,required String myPersonId})async{
    if(personId!=myPersonId){
      person[KConst.followedByMyPerson]=await _followedByMyPerson(myPersonId);
    }
    person[KConst.likesCount]= await _likesCount(personId);
    person[KConst.followersCount]=await _followersCount(personId);
    person[KConst.followingCount]=await _followingCount(personId);
  }

  @override  
  Future<Unit> followPerson({required String anotherUserId,required String myUserId})async{
    return await _tryAndCatchBlock(
      message: "Failed To Folloe This Person", 
      functionToExcute: ()async {
        await fireStoreHelper.add(
          collectionPath: [KConst.followsCollection], 
          data: {
            KConst.date:DateTime.now(),
            KConst.from:myUserId,
            KConst.to:anotherUserId,
          },
        ); 
        return unit;
      },
    );
  }

  @override
  Future<Unit>unFollowPerson({required String anotherUserId,required String myUserId})async{
    return await _tryAndCatchBlock(
      message: "Failed To Unfollow This Person", 
      functionToExcute: () async{
        await fireStoreHelper.deleteCollection(
          collectionPath: [KConst.followsCollection], 
          fireStoreFilters: [
            WhereIsEqualTo(fieldName: KConst.from, value: myUserId),
            WhereIsEqualTo(fieldName: KConst.to, value: anotherUserId),
          ]
        );
        return unit;
      },
    );
  }

  @override
  Future<List<Person>>searchPersons({required String query ,required String myPersonId})async{
    return await _tryAndCatchBlock(
      message:"Failed To Get Results", 
      functionToExcute: ()async{
        final List<Person>toReturn=[];
        GetCollectionOutput result=await fireStoreHelper.getCollection(
          path: [KConst.personsCollection],
          fireStoreFilters: [
            WhereArrayContains(fieldName: KConst.searchTerms, value: query),
          ]
        );
        for (var i = 0; i < result.data.length; i++) {
          await _addPersonCounters(person: result.data[i], personId: result.data[i][KConst.id], myPersonId: myPersonId);
          toReturn.add(
            Person.fromMap(
              myPersonId: myPersonId, 
              person: result.data[i],
            )
          );
        }
        return toReturn;
      }
    );
  }

  @override  
  Future<MyPerson> updateMyPerson(NewPeronUpdateInfo newPeronUpdateInfo)async{
    return await _tryAndCatchBlock(
      message: "Failed To Update Your Profile", 
      functionToExcute: ()async {
        MyPerson toReturn;

        String? imageUrl=newPeronUpdateInfo.currentPeron.image;
        ProfileImageUpdate profileImageUpdate=newPeronUpdateInfo.profileImageUpdate;
        if(profileImageUpdate is AddProfileImage && profileImageUpdate.imageFile!=null ){
          imageUrl= await cloudStorageHelper.uploadFile(
            path: [newPeronUpdateInfo.currentPeron.id],
            file: profileImageUpdate.imageFile!, 
          );
        }

        toReturn=MyPerson.fromUploadedPeronUpdate(
          updateInfo: UploadedPeronUpdateInfo.fromNewPeronUpdate(
            imageUrl: imageUrl, 
            updateInfo: newPeronUpdateInfo
          ),
        );
        
        await fireStoreHelper.set(
          documentPath: [KConst.personsCollection,newPeronUpdateInfo.currentPeron.id], 
          data: toReturn.toFireStore(),
        );
        return toReturn;
      },
    );
  }

  Future<bool> _followedByMyPerson(String myPersonId) async{
    int count= await fireStoreHelper.numOfDocuments(
      path: [KConst.followsCollection],
      fireStoreFilters: [
        WhereIsEqualTo(fieldName: KConst.from, value: myPersonId),
      ],
    );
    return count==1;
  }

  Future<int> _likesCount(String userId) async{
    return await fireStoreHelper.numOfDocuments(
      path: [KConst.likesShortsCollection],
      fireStoreFilters: [
        WhereIsEqualTo(fieldName: KConst.to, value: userId),
      ],
    );
  }

  Future<int> _followersCount(String userId) async{
    return await fireStoreHelper.numOfDocuments(
      path: [KConst.followsCollection],
      fireStoreFilters: [
        WhereIsEqualTo(fieldName: KConst.to, value: userId),
      ],
    );
  }

  Future<int> _followingCount(String userId) async{
    return await fireStoreHelper.numOfDocuments(
      path: [KConst.followsCollection],
      fireStoreFilters: [
        WhereIsEqualTo(fieldName: KConst.from, value: userId),
      ],
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

  @override
  List<Object?> get props => [fireStoreHelper,cloudStorageHelper];
}