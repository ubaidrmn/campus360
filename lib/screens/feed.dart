import 'package:campus360/services/post.dart';
import 'package:campus360/services/user.dart';
import 'package:campus360/shared/widgets/post/post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedScreen extends StatelessWidget {
  UserService userService = Get.find();
  PostService postService = Get.find();

  @override
  Widget build(BuildContext context) {
    postService.fetchPosts();

    return SingleChildScrollView(
        child: Column(
      children: [
        Obx(() {
          return ListView.builder(
            itemCount: postService.posts.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return PostCard(index: index);
            });
        }),
      ],
    ));
  }
}
