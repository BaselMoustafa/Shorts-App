import 'package:shorts_app/dependancies/persons/domain/models/person.dart';
import 'package:shorts_app/dependancies/persons/domain/models/person_update_Info.dart';
import '../../../../core/constants/constants.dart';

class MyPerson extends Person{
  final bool emailIsVerified;

  const MyPerson({
    required this.emailIsVerified,
    required super.bio,
    required super.id,
    required super.name,
    required super.image,
    required super.likesCount,
    required super.followersCount,
    required super.followingCount,
  });

  factory MyPerson.newPerson({
    required String id,
    required String name,
    required bool emailIsVerified,
  }){
    return MyPerson(
      id: id, 
      name: name, 
      emailIsVerified: emailIsVerified, 
      bio: null, 
      image: null, 
      likesCount: 0, 
      followersCount: 0, 
      followingCount: 0,
    );
  }

  factory MyPerson.fromUploadedPeronUpdate({
    required UploadedPeronUpdateInfo updateInfo,
  }){
    return MyPerson(
      name: updateInfo.name, 
      bio: updateInfo.bio, 
      image: updateInfo.imageUrl, 
      id: updateInfo.currentPeron.id,
      emailIsVerified: updateInfo.currentPeron.emailIsVerified, 
      likesCount: updateInfo.currentPeron.likesCount, 
      followersCount: updateInfo.currentPeron.followersCount, 
      followingCount: updateInfo.currentPeron.followingCount,
    );
  }

  Map<String,dynamic>toMap()=>{
    KConst.emailIsVerified:emailIsVerified,
    KConst.bio:bio,
    KConst.id:id,
    KConst.name:name,
    KConst.image:image,
    KConst.likesCount:likesCount,
    KConst.followersCount:followersCount,
    KConst.followingCount:followingCount,
  };

  Map<String,dynamic>toFireStore()=>{
    KConst.emailIsVerified:emailIsVerified,
    KConst.bio:bio,
    KConst.id:id,
    KConst.name:name,
    KConst.image:image,
  };

  @override
  List<Object?> get props => [
    bio,
    id,
    name,
    image,
    likesCount,
    followersCount,
    followingCount,
  ];

}