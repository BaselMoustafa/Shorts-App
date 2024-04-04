import 'package:flutter/material.dart';

enum NavigationAnimationType{
  normal,
  fading,
  rotation,
  scaling,
  sizing,
  sliding,
}

abstract class NavigatorManager{


  static Future<void> push({VoidCallback? toExcuteAfterPop,required BuildContext context,required Widget widget,NavigationAnimationType navigationAnimationType=NavigationAnimationType.sliding})async{
    Navigator.push(
      context,
      _selectMaterialPageRoute(navigationAnimationType: navigationAnimationType, widget: widget)
    ).then((value) {
      if(toExcuteAfterPop!=null){
        toExcuteAfterPop();
      }
    });
  }

  static void pushAndRemoveUntil({required BuildContext context,required Widget widget,NavigationAnimationType navigationAnimationType=NavigationAnimationType.sliding}){
    Navigator.pushAndRemoveUntil(
      context,
      _selectMaterialPageRoute(navigationAnimationType: navigationAnimationType, widget: widget),
      (route){
        return false;
      },
    );
  }

  static void pushReplacement({required BuildContext context,required Widget widget,NavigationAnimationType navigationAnimationType=NavigationAnimationType.sliding}){
    Navigator.pushReplacement(
      context, 
      _selectMaterialPageRoute(navigationAnimationType: navigationAnimationType, widget: widget),
    );
  }
  
  static void pop({required BuildContext context,}){
    Navigator.pop(context);
  }

  static Route _selectMaterialPageRoute({required NavigationAnimationType navigationAnimationType,required Widget widget}){
    if(navigationAnimationType==NavigationAnimationType.normal){
      return MaterialPageRoute(builder:((context) => widget) );
    }else if(navigationAnimationType==NavigationAnimationType.sliding){
      return SlideTransitionPageRoutrBuilder(page: widget);
    }else if(navigationAnimationType==NavigationAnimationType.rotation){
      return PageRotationTransRouteBuilder(page: widget);
    }else if(navigationAnimationType==NavigationAnimationType.scaling){
      return PageScaleTransitionRouteBuilder(page: widget);
    }else if(navigationAnimationType==NavigationAnimationType.sizing){
      return SizeTransitionPageRouteBuilder(page: widget);
    }else{
      return FadeTransitionPageRouteBuilder(page: widget);
    }
  }

}

class FadeTransitionPageRouteBuilder extends PageRouteBuilder{
  final Widget page;
  FadeTransitionPageRouteBuilder({required this.page}):super(
    pageBuilder: (context,animation,secondaryAnimation)=>page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0,end: 1).animate(animation),
        child: child,
      );
    },
  );
}

class PageRotationTransRouteBuilder extends PageRouteBuilder{
  final Widget page;
  PageRotationTransRouteBuilder({required this.page}):super(
    pageBuilder: (context,animation,secondaryAnimation)=>page,
    transitionsBuilder: (context,animation,secondaryAnimation,child){
      return ScaleTransition(
        scale: Tween<double>(begin: 0,end: 1).animate(animation),
        child: RotationTransition(
          turns: Tween<double>(begin: 0,end:2).animate(animation),
          child: child,
        ),
      );
    },
  );
}

class PageScaleTransitionRouteBuilder extends PageRouteBuilder{
  Widget page;

  PageScaleTransitionRouteBuilder({required this.page}):super(
    pageBuilder: (context,animation,secondaryAnimation)=>page,
    transitionsBuilder: (context,animation,secondaryAnimation,child){
      return ScaleTransition(
        scale: Tween<double>(begin: 0,end: 1).animate(animation),
        child: child,
      );
    },
  );
}

class SizeTransitionPageRouteBuilder extends PageRouteBuilder{
  final Widget page;
  SizeTransitionPageRouteBuilder({required this.page}):super(
    pageBuilder: (context,animation,secondaryAnimation)=>page,
    transitionsBuilder: (context,animation,secondaryAnimation,child){
      return Align(
        child: SizeTransition(
          sizeFactor: animation,
          child: child,
        ),
      );
    },
  );
}

class SlideTransitionPageRoutrBuilder extends PageRouteBuilder{
  final Widget page;
  SlideTransitionPageRoutrBuilder({required this.page}):super(
    pageBuilder: (conetext,animation,secondaryAnimation)=>page,
    transitionsBuilder: (conetext,animation,secondaryAnimation,child){
      return SlideTransition(
        position: Tween<Offset>(
          begin:const Offset(1,0),
          end:const Offset(0, 0)
        ).animate(animation),
        child: child,
      );
    },
  );
}