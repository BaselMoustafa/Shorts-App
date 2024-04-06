import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts_app/core/functions/functions.dart';
import 'package:shorts_app/core/managers/color_manager.dart';
import 'package:shorts_app/core/widgets/short_widget/base_short_action_button.dart';
import 'package:shorts_app/dependancies/shorts/controllers/add_or_remove_short_like_cubit/add_or_remove_short_like_cubit.dart';
import 'package:shorts_app/dependancies/shorts/controllers/add_or_remove_short_like_cubit/add_or_remove_short_like_cubit_states.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/short.dart';

class LikeShortButton extends StatefulWidget {
  const LikeShortButton({super.key,required this.short});
  final Short short;

  @override
  State<LikeShortButton> createState() => _LikeShortButtonState();
}

class _LikeShortButtonState extends State<LikeShortButton> {

  late Short _short;

  @override
  void initState() {
    super.initState();
    _short=widget.short;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddOrRemoveShortLikeCubit,AddOrRemoveShortLikeStates>(
      listener: _addOrRemoveShortLikeBlocListener,
      child: BaseShortActionButton(
        onTap: _onTap, 
        text: fromCounterToString(_short.likesCount), 
        icon: _short.likedByMyPerson?
          const Icon(Icons.favorite,color: ColorManager.red,size: 40,)
          :const Icon(Icons.favorite_outline,size: 40,),
      ),
    );
  }

  void _addOrRemoveShortLikeBlocListener(context, state) {
    if(state is AddOrRemoveShortLikeLoading && state.short.id==_short.id){
      _refreshScreen(state.short);
    }
    else if(state is AddOrRemoveShortLikeFailed && state.short.id==_short.id){
      _refreshScreen(state.short);
    }
  }

  void _refreshScreen(Short short){
    setState(() {
      _short=short;
    });
  }

  void _onTap(){
    AddOrRemoveShortLikeCubit.get(context).addOrRemoveShortLike (_short);
  }
}