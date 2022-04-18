import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taniku/Service/local/shared_pref_service.dart';
import '../ViewModel/profile_viewmodel.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>(
        create: (context) => ProfileViewModel(context),
        child: Builder(
          builder: (context){
            return Consumer<ProfileViewModel>(
                builder: (context, viewModel, child) {
                  return Scaffold(
                    resizeToAvoidBottomInset: false,
                    appBar: AppBar(
                      backgroundColor: Colors.green,
                      title: Text("Profile"),
                    ),
                    body: Container(
                      margin: EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    const CircleAvatar(
                                      backgroundImage: AssetImage("assets/dasha.jpg"),
                                      radius: 50,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 16,),
                                Column(
                                  children: [
                                    Text(viewModel.dataProfile.nama.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                SizedBox(width: 124,),
                                Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.orange
                                      ),
                                      onPressed: () {
                                        SharedPreferenceService().removeSharedPref();
                                        // Navigator.pop(context);
                                        Navigator.of(context, rootNavigator: true,).pushAndRemoveUntil(
                                          MaterialPageRoute(builder: (BuildContext context){ return LoginScreen1();
                                          },
                                          ),
                                              (_) => false,);
                                      },
                                        child:
                                    Text('>', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16,),
                            Row(
                              children: [
                                Text("Kebun Saya", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                SizedBox(width: 110,),
                                ElevatedButton.icon(onPressed: () {},
                                    icon: Icon(Icons.add),
                                    label: Text("Tambah Kebun", style: TextStyle(fontSize: 12),),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                ),),
                              ],
                            ),
                          ],
                        ),
                          ),
                      ),
                    );
                }
            );
          },
        )
    );
  }
}
