import 'package:shorts_app/dependancies/persons/domain/models/person.dart';

class AnotherPerson extends Person{
  final bool followedByMyPerson;

  const AnotherPerson({
    required this.followedByMyPerson,
    required super.bio,
    required super.id,
    required super.name,
    required super.image,
    required super.likesCount,
    required super.followersCount,
    required super.followingCount,
  });

  @override
  List<Object?> get props => [
    followedByMyPerson,
    bio,
    id,
    name,
    image,
    likesCount,
    followersCount,
    followingCount,
  ];

}