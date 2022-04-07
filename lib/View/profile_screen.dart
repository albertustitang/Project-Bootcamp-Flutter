import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ViewModel/profile_viewmodel.dart';

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
                  backgroundColor: Colors.deepPurpleAccent,
                  title: Text("Profile"),
                ),
                body: Container(
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 60,),
                        Container(
                          width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: Decoration
                            ),
                            // NetworkImage("viewModel.getProfileList.foto.toString()"),
                        )
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
