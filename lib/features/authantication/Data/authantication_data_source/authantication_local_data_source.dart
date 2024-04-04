import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shorts_app/core/error/exceptions.dart';
import 'package:shorts_app/dependancies/persons/domain/models/authantication_mehod_enum.dart';
import 'package:shorts_app/dependancies/persons/domain/models/my_person.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../core/network/hive/hive_helper.dart';

abstract class AuthanticationLocalDataSource extends Equatable{
  const AuthanticationLocalDataSource();
  Unit setUserId(String userId);
  Unit setAuthanticationMethod(AuthanticationMethod authanticationMethod);
  Unit setPerson(MyPerson myPerson);
  @override
  List<Object?> get props => [];
}

class AuthanticationLocalDataSourceImpl extends AuthanticationLocalDataSource{
  final HiveHelper hiveHelper;
  const AuthanticationLocalDataSourceImpl({required this.hiveHelper});
  @override
  Unit  setUserId(String userId) {
    return _tryAndCatchBlock(
      functionToExcute: (){
        hiveHelper.put(boxName: KConst.dataBoxName, key: KConst.userId, value: userId);
        return unit;
      },
    );
  }
  
  @override
  Unit setAuthanticationMethod(AuthanticationMethod authanticationMethod){
    return _tryAndCatchBlock(
      functionToExcute: (){
        hiveHelper.put(
          boxName: KConst.dataBoxName, 
          key: KConst.authanticationMethod, 
          value: fromAuthanticationMethodToString(authanticationMethod),
        );
        return unit;
      },
    );
  }

  @override
  Unit setPerson(MyPerson myPerson){
    return _tryAndCatchBlock(
      functionToExcute: (){
        hiveHelper.put(
          boxName: KConst.dataBoxName, 
          key: KConst.myPerson, 
          value: myPerson.toMap(),
        );
        return unit;
      },
    );
  }

  

  T _tryAndCatchBlock<T>({
    required Function() functionToExcute,
    String? message,
  }){
    try {
      return functionToExcute();
    } catch (e) {
      throw  LocalDataBaseException(message: message ?? "We have a problem, Please try again");
    }
  }
  
}