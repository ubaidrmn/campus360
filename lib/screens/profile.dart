import 'package:campus360/services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        ElevatedButton(onPressed: () async {
          await userService.logout();
          Get.offNamed("/login");
        }, child: Text("Logout")),
      ],),
    );
  }
}