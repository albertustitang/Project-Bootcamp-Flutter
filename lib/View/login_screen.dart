import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taniku/View/bottom_navigation.dart';
import 'package:taniku/View/signup_screen.dart';

import '../ViewModel/login_viewmodel.dart';

class LoginScreen1 extends StatefulWidget {
  const LoginScreen1({Key? key}) : super(key: key);

  @override
  State<LoginScreen1> createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen1> {
  final _formKey = GlobalKey<FormState>();
  var textController = new TextEditingController();
  var text2Controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<LoginViewModel>(
      create : (context) =>LoginViewModel(context),
      child : Builder(
        builder: (context) {
          return Consumer<LoginViewModel>(
            builder: (context, viewModel, child) {
              return Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Form(
                    key: _formKey,
                    child: Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/evos.png",
                              width: 200,
                              height: 150,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              controller: textController,
                              decoration: const InputDecoration(
                                  labelText: "Email",
                                  hintText: "contoh : albertustitan@gmail.com",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(16)),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.8,
                                      ))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email tidak boleh kosong";
                                }
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              controller: text2Controller,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  labelText: "Password",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(16)),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.8,
                                      ))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password tidak boleh kosong";
                                }
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: 350,
                              height: 45,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Color(0xff2196f3)),
                                onPressed: () {
                                  String username = textController.text.toString();
                                  String password = text2Controller.text.toString();

                                  setState(() {
                                    if (_formKey.currentState!.validate()) {
                                      viewModel.login(username, password, context);
                                      print("Email value => " + textController.text);
                                      print("Password value => " + text2Controller.text);
                                    } else {
                                      print("Lengkapi data");
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: Text("Informasi"),
                                            content:
                                            Text("Silahkan Lengkapi Data Anda"),
                                            actions: [
                                              TextButton(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }),
                                            ],
                                          ));
                                    }
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      "Log in",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              "or",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: 350,
                              height: 45,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Color(0xff03de37)),
                                onPressed: () {},
                                child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/facebook1.png", height: 20, width: 20,),
                                      SizedBox(width: 16,),
                                      Text(
                                        "Log in with Facebook",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: 350,
                              height: 45,
                              child: TextButton(
                                style:
                                TextButton.styleFrom(backgroundColor: Colors.indigo),
                                onPressed: () {},
                                child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/google.png",height: 20, width: 20,),
                                      SizedBox(width: 16,),
                                      Text(
                                        "Log in with Google ",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?"),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SignUp()),
                                      );
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        )),
                  ));
            });
        },
      ),
    );
  }
}
