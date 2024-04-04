import "package:hive_flutter/hive_flutter.dart";
import "package:shorts_app/core/constants/constants.dart";


class HiveHelper {

  static Future<void>init()async{
    await Hive.initFlutter();
    await Hive.openBox(KConst.dataBoxName);
  }

  void put({
    required String boxName,
    required dynamic key,
    required dynamic value,
  }){
    Hive.box(boxName).put(key, value);
  }

  void putAt({
    required String boxName,
    required int index,
    required dynamic value,
  }){
    Hive.box(boxName).putAt(index,value);
  }

  void putAll({
    required String boxName,
    required Map<dynamic,dynamic>data,
  }){
    Hive.box(boxName).putAll(data);
  }

  void add({
    required String boxName,
    required dynamic value,
  }){
    Hive.box(boxName).add(value);
  }

  void addAll({
    required String boxName,
    required List<dynamic> values,
  }){
     Hive.box(boxName).addAll(values);
  }

  T get<T>({
    required String boxName,
    required dynamic key,
    dynamic defaultValue,
  }){
    return  Hive.box(boxName).get(key, defaultValue: defaultValue);
  }

  T getAt<T>({
    required String boxName,
    required int index,
  }){
    return Hive.box(boxName).getAt(index);
  }

  void delete({
    required String boxName,
    required dynamic key,
  }){
    Hive.box(boxName).delete(key);
  }

  void deleteAt({
    required String boxName,
    required int index,
  }){
    Hive.box(boxName).deleteAt(index);
  }

  void deleteAll({
    required String boxName,
    required List<dynamic> keys,
  }){
    Hive.box(boxName).deleteAll(keys);
  }

  Future<void>clear({
    required String boxName,
  })async{
    await Hive.box(boxName).clear();
  }

  Future<void>deleteFromDisk({
    required String boxName,
  })async{
    await Hive.box(boxName).deleteFromDisk();
  }


}