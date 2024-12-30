import 'package:campus360/models/post.dart';
import 'package:campus360/services/post.dart';
import 'package:campus360/services/user.dart';
import 'package:campus360/shared/widgets/base_screen.dart';
import 'package:campus360/shared/widgets/create_new_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedScreen extends StatelessWidget {
  UserService userService = Get.find();
  PostService postService = Get.find();

  @override
  Widget build(BuildContext context) {
    postService.fetchPosts();

    return BaseScreen(title: "Feed", child: SingleChildScrollView(child: Column(
      children: [
        ElevatedButton(onPressed: () async {
          await userService.logout();
          Get.offNamed("/login");
        }, child: Text("Logout")),
        CreateNewPost(),
        Obx(() {
          return ListView.builder(itemCount: postService.posts.length, shrinkWrap: true, itemBuilder: (context, index) {
            return Card(
              elevation: 1,
              borderOnForeground: true,
              child: Padding(padding: EdgeInsets.all(15), child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(postService.posts[index].title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  Text(postService.posts[index].description),
                ],
              ),),
            );
          });
        }),
      ],
    )));    
  }
}
