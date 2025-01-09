import 'package:campus360/models/comment.dart';
import 'package:campus360/models/post.dart';
import 'package:campus360/services/comment.dart';
import 'package:campus360/services/post.dart';
import 'package:campus360/shared/widgets/comment/comment_card.dart';
import 'package:campus360/shared/widgets/comment/create_comment.dart';
import 'package:campus360/shared/widgets/post/post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostThread extends StatelessWidget {
  dynamic arguments = Get.arguments;
  final PostService postService = Get.find();
  final CommentService commentService = Get.find();

  @override
  Widget build(BuildContext context) {
    Post post = postService.posts[arguments[0]];

    return Scaffold(
      appBar: AppBar(
        title: Text("Post Thread"),
      ),
      body: SingleChildScrollView(
        child: Column(
      children: [
        PostCard(index: arguments[0], detail: true),
        CreateNewComment(postId: post.path),
        FutureBuilder(future: commentService.fetchCommentsForPost(post.path), builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            List<dynamic> comments = snapshot.data.docs.map((doc) => Comment.fromDoc(doc)).toList();
            
            return ListView.builder(
                itemCount: comments.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CommentCard(comment: comments[index]);
              });
            }
          
          return Text("Error");
          
        }),
        ElevatedButton(onPressed: () {
          Get.offNamed("/authenticated-screen");
        }, child: Text("Back")),
      ],
    ))
      
      // Container(
      //   child: Column(
      //     children: [
      //       PostCard(index: arguments[0], detail: true),
      //       CreateNewComment(postId: post.path),
      //     ],
      //   ),
      // ),
    );
  }
}