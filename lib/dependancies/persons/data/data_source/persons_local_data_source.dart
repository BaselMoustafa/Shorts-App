import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/constants/constants.dart';
import 'package:shorts_app/core/error/exceptions.dart';
import 'package:shorts_app/core/network/hive/hive_helper.dart';

abstract class PersonsLocalDataSource extends Equatable{
  const PersonsLocalDataSource();
  String userId();
}

class PersonsLocalDataSourceImpl extends PersonsLocalDataSource{
  final HiveHelper hiveHelper;

  const PersonsLocalDataSourceImpl({
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