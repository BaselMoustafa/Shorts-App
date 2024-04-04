import 'package:equatable/equatable.dart';

import 'update_method_type.dart';

abstract class UpdateMethod <T> extends Equatable {
  final T? value;
  final UpdateMethodType updateMethodType;
  const UpdateMethod({
    required this.updateMethodType,
    required this.value,
  });
  @override
  List<Object?> get props => [value,updateMethodType];
}

class SetValue <T> extends UpdateMethod<T>{
  const SetValue({
    required T value,
  }):super(
    value: value,
    updateMethodType: UpdateMethodType.set,
  );
}

abstract class UpdateCurrentValue <T> extends UpdateMethod<T>{
  const UpdateCurrentValue({
    required T value,
    required UpdateMethodType updateMethodType,
  }):super(
    value: value,
    updateMethodType: updateMethodType,
  );
}

class Increment extends UpdateCurrentValue<num>{
  const Increment({
    required num value,
  }):super(
    value: value,
    updateMethodType: UpdateMethodType.increment,
  );
}

class Delete extends UpdateCurrentValue{
  const Delete():super(
    value: null,
    updateMethodType: UpdateMethodType.delete,
  );
}

class ArrayUnion<T> extends UpdateCurrentValue<List<T>>{
  const ArrayUnion({
    required List<T> list,
  }):super(
    value: list,
    updateMethodType: UpdateMethodType.arrayUnion,
  );
}

class ArrayRemove<T> extends UpdateCurrentValue<List<T>>{
  const ArrayRemove({
    required List<T> list,
  }):super(
    value: list,
    updateMethodType: UpdateMethodType.arrayRemove,
  );
}