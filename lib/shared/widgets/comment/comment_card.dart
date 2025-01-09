import 'package:campus360/models/comment.dart';
import 'package:campus360/models/post.dart';
import 'package:campus360/services/comment.dart';
import 'package:campus360/services/post.dart';
import 'package:campus360/services/user.dart';
import 'package:campus360/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;

  CommentCard({ required this.comment });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      borderOnForeground: true,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10,
              children: [ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                height: 30,
                width: 30,
                image: NetworkImage(
                defaultUserImageUrl
              )),
              ),
              Text(comment.displayName)
              ],
            ),
            Text(comment.text),
          ],
        ),
      ),
    );
  }
}
