import 'package:campus360/firebase_options.dart';
import 'package:campus360/screens/feed.dart';
import 'package:campus360/screens/login.dart';
import 'package:campus360/screens/register.dart';
import 'package:campus360/services/post.dart';
import 'package:campus360/services/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(UserService());
  Get.put(PostService());
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
        GetPage(name: '/feed', page: () => FeedScreen()),
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
