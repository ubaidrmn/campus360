import 'package:campus360/shared/widgets/post/create_post.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  final Function goBackToHome;

  CreateScreen({required this.goBackToHome});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreateNewPost(goBackToHome: goBackToHome),
      ],
    );
  }
}