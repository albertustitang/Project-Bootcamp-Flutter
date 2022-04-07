import 'package:flutter/material.dart';
import 'package:taniku/View/login_screen.dart';
import 'package:taniku/View/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage("assets/rumah.jpg"), fit: BoxFit.cover),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/evos.png",
              width: 600,
              height: 300,
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              "EVOS E-SPORT",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => SignUp()));
                // print('Sign Up');
              },
              child: Text("Sign Up"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(100, 40),
                primary: Colors.black87,
                shape: StadiumBorder()),
            ),
            const SizedBox(
              height: 4,
            ),
            OutlinedButton(
              onPressed: () {
                // print("tes");
                Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen1()));
              },
              child: Text("Sign In"),
              style: OutlinedButton.styleFrom(
                  fixedSize: Size(100, 40),
                  primary: Colors.black87,
                  shape: StadiumBorder()),
            ),
            const SizedBox(
              height: 100,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Skip For Now",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
