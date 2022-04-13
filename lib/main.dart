import 'package:flutter/material.dart';
import 'package:taniku/View/bottom_navigation.dart';
import 'package:taniku/View/login_screen.dart';
import 'package:taniku/View/news_screen.dart';
import 'package:taniku/View/profile_screen.dart';
import 'package:taniku/View/signup_screen.dart';
import 'package:taniku/View/ui_login1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen1(),
    );
  }
}
