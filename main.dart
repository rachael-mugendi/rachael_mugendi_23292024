import 'package:flutter/material.dart';
import 'CreateProfile.dart';
import 'package:rachael_mugendi23292024/Feed.dart';
import 'Profilepage.dart';
import 'game.dart';
import 'Allposts.dart';
import 'AllUsersScreen.dart';
import 'CreatePostScreen.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        initialRoute: '/',
        routes: {
          '/' :(context ) => const CreateProfile(),
          '/first': (context) => CreatePostScreen(),
          '/second': (context) => const Feed(),
          '/third': (context) => Profilepage(),
          '/fourth': (context) => const game(),
          '/fifth' : (context) => AllPostsScreen(),
          '/sixth' : (context) => AllUsersScreen(),

        }
    );
  }
}

