import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';

abstract class GetProfileShortsStates {}

class GetProfileShortsInitialState extends GetProfileShortsStates{}
class GetProfileShortsLoadingState extends GetProfileShortsStates{
  GetProfileShortsLoadingState();
}
class GetProfileShortsFailedState extends GetProfileShortsStates{
  final String message;
  GetProfileShortsFailedState({required this.message});
}
class GetProfileShortsSuccessState extends GetProfileShortsStates{
  final List<Short>shorts;
  GetProfileShortsSuccessState({required this.shorts});
}