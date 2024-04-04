import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/dependancies/persons/domain/models/my_person.dart';

abstract class PersonUpdateInfo extends Equatable{
  final String name;
  final String bio;
  final MyPerson currentPeron;
  const PersonUpdateInfo({
    required this.currentPeron,
    required this.bio,
    required this.name
  });
}

class NewPeronUpdateInfo extends PersonUpdateInfo{
  final ProfileImageUpdate profileImageUpdate;

  const NewPeronUpdateInfo({
    required super.currentPeron,
    required super.name,
    required super.bio,
    required this.profileImageUpdate,
  });

  @override
  List<Object?> get props => [profileImageUpdate,super.currentPeron,super.name,super.bio];
}

class UploadedPeronUpdateInfo extends PersonUpdateInfo{
  final String? imageUrl;

  const UploadedPeronUpdateInfo({
    required super.currentPeron,
    required super.name,
    required super.bio,
    required this.imageUrl,
  });

  factory UploadedPeronUpdateInfo.fromNewPeronUpdate({
    required String? imageUrl,
    required NewPeronUpdateInfo updateInfo,
  }){
    return UploadedPeronUpdateInfo(
      currentPeron: updateInfo.currentPeron, 
      name: updateInfo.name, 
      bio: updateInfo.bio, 
      imageUrl: imageUrl,
    );
  }

  @override
  List<Object?> get props => [imageUrl,super.currentPeron,super.name,super.bio];
}

abstract class ProfileImageUpdate {
  const ProfileImageUpdate();
}

class RemoveProfileImage extends ProfileImageUpdate{}

class AddProfileImage extends ProfileImageUpdate{
  final File? imageFile;
  const AddProfileImage({required this.imageFile});
}