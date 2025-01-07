import 'package:campus360/services/post.dart';
import 'package:campus360/services/user.dart';
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
                return Card(
                  elevation: 1,
                  borderOnForeground: true,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          postService.posts[index].title,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(postService.posts[index].description),
                        ElevatedButton(
                            onPressed: () {
                              postService
                                  .deletePost(postService.posts[index].path);
                            },
                            child: Text("Delete")),
                        ElevatedButton(
                        onPressed: () {
                          // postService
                          //     .editPost(postService.posts[index].path);
                        },
                        child: Text("Edit"))
                      ],
                    ),
                  ),
                );
              });
        }),
      ],
    ));
  }
}
