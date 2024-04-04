import 'package:flutter/cupertino.dart';
import 'package:shorts_app/core/managers/box_decoration_manager.dart';
import 'package:shorts_app/core/managers/color_manager.dart';

class ShortMaxDurationSelector extends StatelessWidget {
  const ShortMaxDurationSelector({super.key,required this.maxDurationValueNotifier});
  final ValueNotifier maxDurationValueNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecorationManager.solid.copyWith(
        color: ColorManager.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child:_SelectorDesign(maxDurationValueNotifier: maxDurationValueNotifier,),
    );
  }
}

class _SelectorDesign extends StatefulWidget {
  const _SelectorDesign({required this.maxDurationValueNotifier});
  final ValueNotifier maxDurationValueNotifier;
  @override
  State<_SelectorDesign> createState() => _SelectorDesignState();
}

class _SelectorDesignState extends State<_SelectorDesign> {
  final List<int>_values=[15,30,60];
  int _selectedIndex=0;
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for(int i=0;i<_values.length;i++)
            GestureDetector(
              onTap: ()=>_onTap(i),
              child: Container(
                width: constraints.maxWidth/3,
                color: ColorManager.transparent,
                child: _MaxDurationOption(
                  isSelected: _selectedIndex==i, 
                  value: _values[i].toString(),
                ),
              ),
            ) ,
          ],
        );
      },
    );
  }

  void _onTap(int index){
    setState(() {   
      _selectedIndex=index;
      widget.maxDurationValueNotifier.value=Duration(seconds: _values[_selectedIndex]);
    });
  }

}

class _MaxDurationOption extends StatelessWidget {

  final bool isSelected;
  final String value;

  const _MaxDurationOption({
    required this.isSelected,
    required this.value,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style:TextStyle(
            fontSize: 16,
            color: isSelected?ColorManager.white:ColorManager.grey,
          ),
        ),
        const SizedBox(height: 3,),
        Container(
          height: 4,
          decoration: BoxDecorationManager.solidCircle.copyWith(
            color: isSelected?ColorManager.white:ColorManager.transparent,
          ),
        ),
      ],
    );
  }
}