import 'package:campus360/services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final String title;
  final UserService userService = Get.find();

  BaseScreen({ required this.title, required this.child });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(padding: EdgeInsets.all(30), child: child),
    );
  }
}
