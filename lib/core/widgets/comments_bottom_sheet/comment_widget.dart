import 'package:flutter/material.dart';
import 'package:shorts_app/dependancies/shorts/domain/models/comment.dart';
import '../../functions/functions.dart';
import '../../models/image_details.dart';
import '../profile_image_widget.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key,required this.comment});
  final Comment comment;
  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PersonImage(comment: comment,),
        const SizedBox(width: 10,),
        _CommentDetails(comment: comment,),
      ],
    );
  }
}

class _PersonImage extends StatelessWidget {
  const _PersonImage({required this.comment});
  final Comment comment;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:const EdgeInsets.only(top: 3),
      child: ProfileImageWidget(
        imageDetails:comment.from.image==null?null:NetworkImageDetails(url: comment.from.image!),
      ),
    );
  }
}

class _CommentDetails extends StatelessWidget {
  const _CommentDetails({required this.comment});
  final Comment comment;
  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PersonNameAndDate(comment: comment,),
          const SizedBox(height: 2,),
          Text(comment.content),
        ],
      ),
    );
  }
}

class _PersonNameAndDate extends StatelessWidget {
  const _PersonNameAndDate({required this.comment});
  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          comment.from.name,
          style:Theme.of(context).textTheme.headlineLarge,
        ),
        const Spacer(),
        Text(timeDifferenceAsString(date: comment.date))
      ],
    );
  }
}