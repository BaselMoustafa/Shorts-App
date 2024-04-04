import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/widgets/show_my_snackbar.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/managers/navigator_manager.dart';
import '../../../../core/widgets/main_layout_widget.dart';
import '../controllers/email_authantication_cubit/email_authantication_cubit.dart';
import '../controllers/email_authantication_cubit/email_authantication_cubit_states.dart';

class WaitForVerificationScreen extends StatelessWidget {
  const WaitForVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const _WidgetDesign();
  }
}

class _WidgetDesign extends StatelessWidget {
  const _WidgetDesign();

  @override
  Widget build(BuildContext context) {
    return  BlocListener<EmailAuthanticationCubit,EmailAuthanticationCubitStates>(
      listener: _listener,
      child: _scaffoldDesign(),
    );
  }

 void _listener(context, state) {
    if(state is EmailAuthanticationSuccessState){
      NavigatorManager.pushAndRemoveUntil(context: context, widget: const MainLayoutWidget());
    }
    if (state is EmailAuthanticationFailedState) {
      showMySnackBar(context: context, content: Text(state.message));
      EmailAuthanticationCubit.get(context).init();
      NavigatorManager.pop(context: context);
    }
  }

  Widget _scaffoldDesign() {
    return const _ScaffoldDesign();
  }
}

class _ScaffoldDesign extends StatelessWidget {
  const _ScaffoldDesign();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(didPop){
          return ;
        }
        EmailAuthanticationCubit.get(context).init();
        NavigatorManager.pop(context: context);
      },
      child: Scaffold(
      appBar: AppBar(
        foregroundColor: ColorManager.white,
        backgroundColor: ColorManager.green,
        elevation: 0,
        title:const Text("Verifiy Account"),
      ),
      body:const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.verified_user_rounded,
              color: ColorManager.green,
              size: 150,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Verification Link Sent To Your Email, Please Check Your Email To Verifiy Your Account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  wordSpacing: 2
                ),
              ),
            ),
          ],
        ),
      ),
        ),
    );
  }
}


