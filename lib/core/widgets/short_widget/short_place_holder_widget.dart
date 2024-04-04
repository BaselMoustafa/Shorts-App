import 'package:flutter/material.dart';

import '../shimer_widget.dart';


class ShortPlaceHolderWidget extends StatelessWidget {
  const ShortPlaceHolderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        PositionedDirectional(
          start: 10,
          bottom: 30,
          child:_ShortInfoPlaceHolder(),
        ),
        PositionedDirectional(
          end: 10,
          bottom: 100,
          child:_ShortActionsPlaceHolderPlaceHolder(),
        )
      ],
    );
  }
}

class _ShortActionsPlaceHolderPlaceHolder extends StatelessWidget {
  const _ShortActionsPlaceHolderPlaceHolder();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(int i=0;i<3;i++)
        const Padding(
          padding: EdgeInsets.only(top: 30),
          child: ShimmerWidget.circular(),
        ),
      ],
    );
  }
}

class _ShortInfoPlaceHolder extends StatelessWidget {
  const _ShortInfoPlaceHolder();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _ShortOwnerInfoPlaceHolder(),
        SizedBox(height: 10,),
        _ShortDescribtionPlaceHolder(),
      ],
    );
  }
}

class _ShortOwnerInfoPlaceHolder extends StatelessWidget {
  const _ShortOwnerInfoPlaceHolder();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ShimmerWidget.circular(),
        const SizedBox(width: 8,),
        ShimmerWidget.rectangle(width: MediaQuery.of(context).size.width*.4,borderRadius: BorderRadius.circular(10),),
      ],
    );
  }
}

class _ShortDescribtionPlaceHolder extends StatelessWidget {
  const _ShortDescribtionPlaceHolder();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.75,
      child: Column(
        children: [
          ShimmerWidget.rectangle(borderRadius: BorderRadius.circular(10),),
          const SizedBox(height: 5,),
          ShimmerWidget.rectangle(borderRadius: BorderRadius.circular(10),),
        ],
      ),
    );
  }
}