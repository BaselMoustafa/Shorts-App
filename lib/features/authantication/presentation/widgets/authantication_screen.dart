import 'package:flutter/material.dart';
import 'package:shorts_app/features/authantication/presentation/widgets/google_and_email_bloc_listeners.dart';
import 'package:shorts_app/features/authantication/presentation/widgets/google_sign_in_button.dart';
import 'package:shorts_app/features/authantication/presentation/widgets/or_line_widget.dart';

import '../../../../core/managers/color_manager.dart';

class AuthanticationScreen extends StatelessWidget {
  const AuthanticationScreen({
    super.key,
    required this.textFormFields,
    required this.textButton,
    required this.authanticationButton,
    required this.formKey,
    required this.primaryText,
    required this.secondaryText,
  });
  final String primaryText;
  final String secondaryText;
  final GlobalKey<FormState> formKey;
  final List<Widget> textFormFields;
  final Widget authanticationButton;
  final Widget textButton;

  @override
  Widget build(BuildContext context) {
    return _ScreenDesign(widget: this);
  }
  
}

class _ScreenDesign extends StatefulWidget {
  const _ScreenDesign({
    required this.widget
  });

  final AuthanticationScreen widget;

  @override
  State<_ScreenDesign> createState() => _ScreenDesignState();
}

class _ScreenDesignState extends State<_ScreenDesign> {
  

  @override
  Widget build(BuildContext context) {
    return GoogleAndEmailBlocListeners(
      widget: SafeArea(
        child: Scaffold(
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: widget.widget.formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    widget.widget.primaryText,
                    style:const  TextStyle(color: ColorManager.primary,fontSize: 28,fontWeight: FontWeight.bold,),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.widget.secondaryText,
                    style: const TextStyle(color: ColorManager.grey),
                  ),
                  const SizedBox(height: 40,),
                  
                  for(int i=0;i<widget.widget.textFormFields.length;i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: i==widget.widget.textFormFields.length-1?0:10),
                    child: widget.widget.textFormFields[i],
                  ),
                    
                  const SizedBox(height: 20,),
                  widget.widget.authanticationButton,
                  widget.widget.textButton,
                  const OrLineWidget(),
                  const SizedBox(height: 10,),
                  const GoogleSignInButton(),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
