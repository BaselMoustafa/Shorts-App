import 'package:flutter/material.dart';

String? hasToBeInt({required BuildContext context,String? value,int? maxValue}){
  String? result=hasNotToBeEmpty(value);
  if(result!=null){
    return result;
  }
  int? number= int.tryParse(value!);
  
  if(number==null){
    return "Have To Be Int";
  }

  if(maxValue!=null && number>maxValue){
    return "Max Value Is $maxValue";
  }

  return null;
}

String? hasNotToBeEmpty(String? value){
  if(value==null||value.trim().length==0){
    return "Requierd Field";
  }
  return null; 
}

String fromCounterToString(int counter){
  if(counter<1000){
    return counter.toString();
  }
  if(counter<1000000){
    return "${(counter/1000).toStringAsFixed(1)}K";  
  }
  return "${(counter/1000000).toStringAsFixed(1)}M";
}

String timeDifferenceAsString({required DateTime date}){
  Duration difference=DateTime.now().difference(date);
  if(difference.inMinutes==0){
    return "1m";
  }
  if(difference.inMinutes<60){
    return "${difference.inMinutes}m";
  }
  if(difference.inHours<24){
    return "${difference.inHours}h";
  }
  if(difference.inDays<7){
    return "${difference.inDays}d";
  }
  
  if(difference.inDays<365){
    return "${(difference.inDays/30).floor()}mon";
  }
  return "${(difference.inDays/365).floor()}y";
}