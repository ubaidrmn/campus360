import 'package:campus360/services/user.dart';
import 'package:campus360/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(spacing: 10, children: [
        ClipRRect(
          child: Image(image: NetworkImage(defaultUserImageUrl), height: 70, width: 70,),
          borderRadius: BorderRadius.circular(100),
        ),
        Text("Email Address: ${userService.user.value?.email}", style: TextStyle(
          fontSize: 20
        ),),
        Text("Display Name: ${userService.user.value?.displayName}", style: TextStyle(
          fontSize: 20
        )),
        ElevatedButton(onPressed: () async {
          await userService.logout();
          Get.offNamed("/login");
        }, child: Text("Logout"), style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white
        ),),
      ]),
    );
  }
}