import 'package:campus360/models/post.dart';
import 'package:campus360/services/post.dart';
import 'package:campus360/services/user.dart';
import 'package:campus360/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCard extends StatelessWidget {
  final PostService postService = Get.find();
  final UserService userService = Get.find();
  final int index;

  PostCard({ required this.index });

  @override
  Widget build(BuildContext context) {

    Post post = postService.posts[index];

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
              Text(post.displayName)
              ],
            ),
            Text(
              post.title,
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(post.description),
            post.uid == userService.user.value?.uid ? Row(spacing: 10,children: [
              ElevatedButton(
                onPressed: () {
                  postService
                      .deletePost(post.path);
                },
                child: Text("Delete")),
            ElevatedButton(
            onPressed: () {
              // postService
              //     .editPost(postService.posts[index].path);
            },
            child: Text("Edit"))
            ],) : Row(
              children: [
                IconButton(onPressed: () {

                }, icon: Icon(Icons.favorite)),
                IconButton(onPressed: () {

                }, icon: Icon(Icons.comment)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
