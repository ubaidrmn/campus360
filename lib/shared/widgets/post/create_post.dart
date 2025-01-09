import 'package:campus360/services/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewPost extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  final UserService userService = Get.find();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final Function goBackToHome;

  CreateNewPost({required this.goBackToHome});

  
  publishPost() {
    final post = <String, dynamic>{
      "title": titleController.text,
      "description": descriptionController.text,
      "displayName": userService.user.value?.displayName,
      "uid": userService.user.value?.uid,
      "createdAt": DateTime.now(),
      "totalLikes": 0
    };

    db.collection("Post").add(post).then((DocumentReference doc) {
      print("${doc.id} Post Created..");
      titleController.text = "";
      descriptionController.text = "";
      goBackToHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: EdgeInsets.all(15), child: Column(
        children: [
          TextField(decoration: InputDecoration(hintText: "Title"), controller: titleController,),
          TextField(decoration: InputDecoration(hintText: "Description"), controller: descriptionController,),
          ElevatedButton(onPressed: publishPost, child: Text("Publish")),
        ],
      ),),
    );
  }
}