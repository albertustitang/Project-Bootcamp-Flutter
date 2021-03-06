import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taniku/View/bottom_navigation.dart';
import 'package:taniku/View/login_screen.dart';
import 'package:taniku/View/news_screen.dart';
import 'package:taniku/View/profile_screen.dart';
import 'package:taniku/View/signup_screen.dart';
import 'package:taniku/View/ui_login1.dart';

import 'View/alamat_screen.dart';
import 'View/dokumen_screen.dart';
import 'View/kebun_screen.dart';
import 'View/tab_controller_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
