import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/constants/constants.dart';
import 'package:shorts_app/dependancies/persons/domain/models/another_person.dart';
import 'package:shorts_app/dependancies/persons/domain/models/my_person.dart';

abstract class Person extends Equatable{
  final String id;
  final String name;
  final String? bio;
  final String? image;
  final int likesCount;
  final int followingCount;
  final int followersCount;

  const Person({
    required this.bio,
    required this.id,
    required this.name,
    required this.image,
    required this.likesCount,
    required this.followersCount,
    required this.followingCount,
  });

  factory Person.fromMap({
    required String myPersonId,
    required Map<String,dynamic> person,
  }){
    if(person[KConst.id]==myPersonId){
      return MyPerson(
        emailIsVerified: person[KConst.emailIsVerified],
        id: person[KConst.id], 
        name: person[KConst.name],
        bio: person[KConst.bio], 
        image: person[KConst.image], 
        likesCount: person[KConst.likesCount], 
        followersCount: person[KConst.followersCount], 
        followingCount: person[KConst.followingCount],
      );
    }
    return AnotherPerson(
      followedByMyPerson: person[KConst.followedByMyPerson],
      id: person[KConst.id], 
      name: person[KConst.name],
      bio: person[KConst.bio], 
      image: person[KConst.image], 
      likesCount: person[KConst.likesCount], 
      followersCount: person[KConst.followersCount], 
      followingCount: person[KConst.followingCount],
    );
  }
}