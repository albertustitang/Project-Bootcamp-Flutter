
import 'dart:core';
// import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taniku/View/login_screen.dart';
import 'package:taniku/View/ui_login1.dart';
import 'package:taniku/ViewModel/register_viewmodel.dart';
// import 'package:taniku/View/login_screen.dart';
// import 'package:taniku/View/ui_login1.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool hidePassword = false;
  bool checkedValue = false;
  String _selectedGender = "male";
  List<String> dropdownList = [
    'Islam',
    'Kristen',
    'Katolik',
    'Hindu',
    'Budha',
    'Atheis',
  ];
  var selectedDropDown;
  var gender;

  final _formKey = GlobalKey<FormState>();
  var textController = new TextEditingController();
  var text2Controller = new TextEditingController();
  var text3Controller = new TextEditingController();
  var text4Controller = new TextEditingController();
  bool cekbox = false;

  void bukaPassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>(
      create: (context) => RegisterViewModel(context),
      child: Builder(
          builder: (context) {
            return Consumer<RegisterViewModel>(
                builder: (context, viewModel, child) {
                  return Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: SingleChildScrollView(
                      child:
                      Form(
                          key: _formKey,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 26, top: 70, right: 26),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    "assets/evos.png", width: 120, height: 120),
                                Text(
                                    "Evos E-Sport Membership", style: TextStyle(
                                    color: Colors.indigo, fontSize: 20)),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 350,
                                  child: TextFormField(
                                      style: const TextStyle(
                                          color: Colors.black45),
                                      controller: textController,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.black12,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        labelText: 'Full Name',
                                        labelStyle: TextStyle(
                                            color: Colors.grey),
                                        hintText: 'Ex Albertus Titan',
                                        hintStyle: TextStyle(
                                            color: Colors.grey),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Nama belum diisi";
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: 350,
                                  child: TextFormField(
                                      style: const TextStyle(
                                          color: Colors.black45),
                                      controller: text2Controller,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.black12,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        labelText: "No HP",
                                        labelStyle: TextStyle(
                                            color: Colors.grey),
                                        hintText: "08123456789",
                                        hintStyle: TextStyle(
                                            color: Colors.grey),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Nomer HP belum diisi";
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                SizedBox(height: 16,),
                                TextFormField(
                                  obscureText: viewModel.hidePassword ? false : true,
                                  style: const TextStyle(color: Colors.black45),
                                  controller: text3Controller,
                                  decoration: InputDecoration(
                                    // icon: const Icon(Icons.lock),
                                    filled: true,
                                    fillColor: Colors.black12,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    labelText: "Password",
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          viewModel.hidePassword ? Icons.visibility : Icons.visibility_off),
                                      onPressed: () => bukaPassword(),
                                      color: Colors.grey,
                                    ),
                                    labelStyle: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Password belum diisi";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  obscureText: viewModel.hidePassword ? false : true,
                                  style: const TextStyle(color: Colors.black45),
                                  controller: text4Controller,
                                  decoration: InputDecoration(
                                    // icon: const Icon(Icons.lock),
                                    filled: true,
                                    fillColor: Colors.black12,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    labelText: "Confirm Password",
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          viewModel.hidePassword ? Icons.visibility : Icons.visibility_off),
                                      onPressed: () => bukaPassword(),
                                      color: Colors.grey,
                                    ),
                                    labelStyle: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Password belum diisi";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Radio<String>(
                                          value: "Male",
                                          groupValue: _selectedGender,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedGender = value!;
                                              print(value);
                                            });
                                          },),
                                        Text('Male'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio<String>(
                                          value: 'Female',
                                          groupValue: _selectedGender,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedGender = value!;
                                              print(value);
                                            });
                                          },),
                                        Text('Female'),
                                      ],
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Agama", style: TextStyle(
                                      fontSize: 14),),
                                ),
                                DropdownButton(
                                  isExpanded: true,
                                  hint: Text("Pilih Agama"),
                                  value: selectedDropDown,
                                  onChanged: (newValue) {
                                    setState(() {
                                      print(newValue.toString());
                                      selectedDropDown = newValue;
                                    });
                                  },
                                  items: dropdownList.map((String value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                CheckboxListTile(
                                  title: Text(
                                    "Yes I agree to Twitter Priavcy Policy Terms and Services.",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  value: cekbox,
                                  onChanged: (newValue) {
                                    setState(() {
                                      cekbox = newValue!;
                                      print(newValue);
                                    });
                                  },
                                  contentPadding: EdgeInsets.only(left: 0.0),
                                  controlAffinity: ListTileControlAffinity
                                      .leading,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 10, 157, 224),
                                    onPrimary: Colors.white,
                                    fixedSize: Size(340, 40),
                                  ),
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => Index()),
                                    // );
                                    setState(() {
                                      if (_formKey.currentState!.validate()) {
                                        String nama = textController.text.toString();
                                        String hp = text2Controller.text.toString();
                                        String password = text3Controller.text.toString();
                                        String confirm = text4Controller.text.toString();
                                        viewModel.register(nama, hp, password, confirm, context);
                                        print("text 1 value => " +
                                            textController.text);
                                        print("text 2 value => " +
                                            text2Controller.text);
                                        print("text 3 value => " +
                                            text3Controller.text);
                                        print("text 4 value => " +
                                            selectedDropDown.toString());
                                        print(
                                            "text 5 value => " +
                                                cekbox.toString());
                                        print(
                                            "text 6 value => " +
                                                gender.toString());
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()));
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (_) =>
                                                AlertDialog(
                                                  title: Text('Informasi'),
                                                  content:
                                                  Text(
                                                      'Silahkan Lengkapi Data Anda'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          print(
                                                              "Lengkapi Data");
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('OK'))
                                                  ],
                                                ));
                                      }
                                    });
                                  },
                                  child: Text("Sign Up"),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            right: 10.0),
                                        child: Divider(
                                          color: Colors.grey,
                                          thickness: 1,
                                        ),
                                      ),
                                    ),
                                    Text(" or "),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 10.0),
                                        child: Divider(
                                          color: Colors.grey,
                                          thickness: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Container(
                                  color: Color.fromRGBO(59, 89, 152, 1),
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Image.asset("assets/facebook.png",
                                          width: 40, height: 30),
                                      OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            primary: Color.fromRGBO(
                                                59, 89, 152, 1),
                                            fixedSize: Size(298, 40),
                                          ),
                                          onPressed: () {
                                            // Navigator.push(
                                            //   context, MaterialPageRoute(builder: (context) => Signup()),
                                            // );
                                            print("Sign Up with Facebook");
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 20.0),
                                              child: new Text(
                                                "Sign Up with Facebook ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0),
                                              ))),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                                Container(
                                  color: Colors.white,
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                          "assets/google.png", width: 40,
                                          height: 30),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          primary: Colors.white,
                                          fixedSize: Size(299, 40),
                                        ),
                                        onPressed: () {
                                          // Navigator.push(
                                          //   context, MaterialPageRoute(builder: (context) => Signup()),
                                          // );
                                          print("Sign Up with Google");
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                right: 20.0),
                                            child: new Text(
                                              "Sign Up with Google ",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: 'By signing up you account the',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: ' Terms of Services',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 10, 157, 224),
                                                fontSize: 14),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            LoginScreen1())));
                                              }),
                                        TextSpan(
                                          text: ' and',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                        TextSpan(
                                            text: ' Privacy and Policy',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 10, 157, 224),
                                                fontSize: 14),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            LoginScreen1())));
                                              })
                                      ]),
                                ),
                                SizedBox(height: 50),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Already have an account",
                                        style: TextStyle(color: Colors.grey)),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()));
                                      },
                                      child: Text("Log In"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                      ),
                    ),
                  );
                });
          }
      ),
    );
  }
}



