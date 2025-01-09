import 'package:campus360/firebase_options.dart';
import 'package:campus360/models/comment.dart';
import 'package:campus360/screens/authenticated.dart';
import 'package:campus360/screens/login.dart';
import 'package:campus360/screens/post_thread.dart';
import 'package:campus360/screens/register.dart';
import 'package:campus360/services/comment.dart';
import 'package:campus360/services/post.dart';
import 'package:campus360/services/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// flutter run -d chrome --web-renderer html

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(UserService());
  Get.put(PostService());
  Get.put(CommentService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UserService userService = Get.find();
    userService.setupListener();

    return GetMaterialApp(
      getPages: [
        GetPage(name: '/authenticated-screen', page: () => AuthenticatedScreen()),
        GetPage(name: '/post-thread', page: () => PostThread()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
      ],
      title: 'Campus360',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: "/login",
      
    );
  }
}
