import 'package:campus360/services/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewComment extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  final UserService userService = Get.find();
  TextEditingController textController = TextEditingController();
  final String postId;

  CreateNewComment({required this.postId });

  
  publishComment() {
    final comment = <String, dynamic>{
      "text": textController.text,
      "postId": postId,
      "uid": userService.user.value?.uid,
      "displayName": userService.user.value?.displayName,
    };

    db.collection("Comment").add(comment).then((DocumentReference doc) {
      print("${doc.id} Comment Created..");
      textController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: EdgeInsets.all(15), child: Column(
        children: [
          TextField(decoration: InputDecoration(hintText: "Enter your comment"), controller: textController,),
          ElevatedButton(onPressed: publishComment, child: Text("Publish")),
        ],
      ),),
    );
  }
}