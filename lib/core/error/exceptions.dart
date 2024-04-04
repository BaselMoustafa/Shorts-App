import 'package:shorts_app/dependancies/shorts/domain/models/short_Info.dart';

class AuthanticationException implements Exception{
  final String message;
  const AuthanticationException({required this.message});
}

class LocalDataBaseException implements Exception{
  final String message;
  const LocalDataBaseException({required this.message});
}

class RemoteDataBaseException implements Exception{
  final String message;
  const RemoteDataBaseException({required this.message});
}

class AddShortException implements Exception{
  final String message;
  final NewShortInfo newShortInfo;
  const AddShortException({required this.newShortInfo,required this.message});
}

