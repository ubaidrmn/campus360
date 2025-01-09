import 'package:campus360/screens/create.dart';
import 'package:campus360/screens/feed.dart';
import 'package:campus360/screens/profile.dart';
import 'package:campus360/services/user.dart';
import 'package:campus360/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticatedScreen extends StatefulWidget {
  const AuthenticatedScreen({super.key});

  @override
  State<AuthenticatedScreen> createState() => _AuthenticatedScreenState();
}

class _AuthenticatedScreenState extends State<AuthenticatedScreen> {
  UserService userService = Get.find();
  Widget activeScreen = FeedScreen();
  String activeScreenTitle = "Home";

  void goBackToHome() {
    setState(() {
      activeScreen = FeedScreen();
      activeScreenTitle = "Home";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreenTitle),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(child: Padding(padding: EdgeInsets.all(15), child: activeScreen)),
          Container(
            height: 70,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(child: Padding(padding: EdgeInsets.only(top: 4, left: 25, right: 25), child: Icon(Icons.home, size: 40,)), onTap: () {
                    setState(() {
                      activeScreen = FeedScreen();
                      activeScreenTitle = "Home";
                    });
                  }),
                  GestureDetector(child: Padding(padding: EdgeInsets.only(top: 4, left: 25, right: 25), child: Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                      height: 40,
                      width: 40,
                      image: NetworkImage(defaultUserImageUrl, 
                  ),
                  ),
                    ),
                  )), onTap: () {
                    setState(() {
                      activeScreen = ProfileScreen();
                      activeScreenTitle = "Profile";
                    });
                  }),
                  GestureDetector(child: Padding(padding: EdgeInsets.only(top: 4, left: 25, right: 25), child: Container(
                    child: Padding(padding: EdgeInsets.all(5), child: Icon(Icons.add, size: 30,),),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.lightBlueAccent
                    ),
                  )), onTap: () {
                    setState(() {
                      activeScreen = CreateScreen(goBackToHome: goBackToHome);
                      activeScreenTitle = "Create";
                    });
                  },)
                ],
              )
            )
        ],
      )
    );
  }
}


// BottomNavigationBar(
//                     currentIndex: activeScreenIndex,
//                     onTap: (value) {
//                       setState(() {
//                         activeScreenIndex = value;
//                       });
//                       ;
//                     },
//                     items: <BottomNavigationBarItem>[
//                       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//                       BottomNavigationBarItem(
//                           icon: Icon(Icons.person), label: 'Profile'),
//                       BottomNavigationBarItem(
//                           icon: Icon(Icons.no_accounts), label: 'Notifications'),
//                       BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Create')
//                     ],
//                   )

// BottomNavigationBar(currentIndex: activeScreenIndex, items: [
//         BottomNavigationBarItem(label: "Feed", icon: IconButton(onPressed: () {
//           setState(() {
//activeScreenIndex = 0;
//           });
//         }, icon: Icon(Icons.home))),
//         BottomNavigationBarItem(label: "Profile", icon: IconButton(onPressed: () {
//           setState(() {
//activeScreenIndex = 1;
//           });
//         }, icon: Icon(Icons.verified_user_rounded),))
//       ])
