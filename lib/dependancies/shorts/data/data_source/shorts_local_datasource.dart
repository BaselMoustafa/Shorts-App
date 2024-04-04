import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/constants/constants.dart';
import 'package:shorts_app/core/error/exceptions.dart';
import 'package:shorts_app/core/network/hive/hive_helper.dart';

abstract class ShortsLocalDataSource extends Equatable{
  const ShortsLocalDataSource();
  String userId();
}

class ShortsLocalDataSourceImpl extends ShortsLocalDataSource{
  final HiveHelper hiveHelper;

  const ShortsLocalDataSourceImpl({
    required this.hiveHelper,
  });

  @override
  String userId(){
    return _tryAndCatchBlock(
      message: "Failed To Get Data", 
      functionToExcute: () {
        return hiveHelper.get(boxName: KConst.dataBoxName, key: KConst.userId);
      },
    );
  }

  T _tryAndCatchBlock<T>({
    required String message,
    required T Function()functionToExcute,
  }){
    try {
      return functionToExcute();
    }
    catch (e) {
      throw LocalDataBaseException(message: message);
    }
  }

  @override
  List<Object?> get props => [
    hiveHelper,
  ];

}