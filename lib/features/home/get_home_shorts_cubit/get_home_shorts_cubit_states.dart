import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';

abstract class GetHomeShortsStates {}

class GetHomeShortsInitialState extends GetHomeShortsStates{}
class GetHomeShortsLoadingState extends GetHomeShortsStates{
  GetHomeShortsLoadingState();
}
class GetHomeShortsFailedState extends GetHomeShortsStates{
  final String message;
  GetHomeShortsFailedState({required this.message});
}
class GetHomeShortsSuccessState extends GetHomeShortsStates{
  final List<Short>shorts;
  GetHomeShortsSuccessState({required this.shorts});
}