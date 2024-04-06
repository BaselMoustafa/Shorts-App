import 'package:flutter/material.dart';
import 'package:shorts_app/core/widgets/there_are_no_widget.dart';


class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {


  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      body:SafeArea(
        child: Column(
          children: [
            ThereAreNoWidget(label: "Shorts"),
          ],
        ),
      )
    );
  
  }
}
