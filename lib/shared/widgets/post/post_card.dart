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
  final bool detail;

  PostCard({ required this.index, this.detail = false });

  @override
  Widget build(BuildContext context) {

    Post post = postService.posts[index];

    return Card(
      elevation: 1,
      borderOnForeground: true,
      color: index % 2 == 0 ? Colors.grey[300] : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text("Date Posted ${post.createdAt.toString().substring(0, 10)}"),
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

            // Like and Comment buttons

            Row(
              children: [
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    IconButton(onPressed: () {
                      postService.handlePostLikeClick(post.path);
                    }, icon: Icon(Icons.thumb_up, color: userService.user.value?.likedPosts.contains(post.path) == true ? Colors.blueAccent : Colors.grey[800],)),
                    Text(post.totalLikes.toString()),
                  ],
                ),
                Flex(direction: Axis.horizontal, children: [
                  IconButton(onPressed: () {
                  Get.offNamed("/post-thread", arguments: [index]);
                }, icon: Icon(Icons.comment)),
                ],),
              ],
            ),

            // Delete and Edit buttons
            !detail && post.uid == userService.user.value?.uid ? Row(spacing: 10,children: [
              ElevatedButton(
                onPressed: () {
                  postService
                      .deletePost(post.path);
                },
                child: Text("Delete")),
            // ElevatedButton(
            // onPressed: () {
            //   // postService
            //   // .editPost(postService.posts[index].path);
            //   Get.offNamed("/post-thread", arguments: [index]);
            // },
            // child: Text("Edit"))
            ],) : Container(),
          ],
        ),
      ),
    );
  }
}
