
import 'package:shorts_app/dependancies/shorts/domain/models/short_Info.dart';

abstract class Failure {
  final String message;
  const Failure({required this.message});
}

class OfflineFailure extends Failure{
  const OfflineFailure({super.message="Please Check Your Network Connection"});
}

class AuthanticationFailure extends Failure{
  const AuthanticationFailure({required super.message});
}

class LocalDataBaseFailure extends Failure{
  const LocalDataBaseFailure({required super.message});
}

class RemoteDataBaseFailure extends Failure{
  const RemoteDataBaseFailure({required super.message});
}

class AddShortFailure extends Failure{
  final NewShortInfo newShortInfo;
  const AddShortFailure({required super.message,required this.newShortInfo});
}
