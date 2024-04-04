import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short_Info.dart';
import '../../features/add_short/screens/add_details_screen.dart';
import '../../features/profile/screens/short_screen.dart';
import '../managers/color_manager.dart';
import '../managers/navigator_manager.dart';

void showMySnackBar({
  required BuildContext context,
  required Widget content,
  SnackBarAction? snackBarAction,
  Color color=ColorManager.red,
}){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      action: snackBarAction,
      backgroundColor: color,
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
      padding:const EdgeInsets.all(10),
      content: DefaultTextStyle(
        style: Theme.of(context).textTheme.headlineMedium!, 
        child: content,
      ),
    )
  );
}

void showAddShortSuccessSnackBar({required BuildContext context,required Short short}){
  showMySnackBar(
    context: context, 
    color: ColorManager.green,
    content:const Text("Successs At Upload"),
    snackBarAction: SnackBarAction(
      label: "Show", 
      onPressed: ()=>NavigatorManager.push(context: context, widget: ShortScreen(short: short,)),
    ),
  );
}

void showAddShortFailedSnackBar({required BuildContext context,required String message,required NewShortInfo newShortInfo}){
  showMySnackBar(
    context: context, 
    content: Text(message),
    snackBarAction: SnackBarAction(
      textColor: ColorManager.white,
      label: "Show", 
      onPressed: ()=>NavigatorManager.push(
        context: context, 
        widget: AddDetailsScreen(newShortInfo: newShortInfo)
      ),
    ),
  );
}