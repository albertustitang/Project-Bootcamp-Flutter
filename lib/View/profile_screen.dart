import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              // appBar: AppBar(
              //   elevation: 0.0,
              //   backgroundColor: Colors.blueAccent,
              //   leading: IconButton(
              //     icon: Icon(Icons.arrow_back),
              //     onPressed: () {
              //       Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsScreen()));
              //     },
              //   ),
              // ),
                body: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle.dark,
                  child: GestureDetector(
                    child: Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xff7289da),
                                    Color(0xBF7289da),
                                    Color(0x807289da),
                                    Color(0x407289da),
                                  ]
                              )
                          ),
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 120
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child:
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 115,
                                        width: 115,
                                        child: CircleAvatar(
                                          backgroundImage:
                                          AssetImage("assets/dasha.jpg"),
                                        ),
                                      ),
                                      SizedBox(height: 8,),
                                      Text(
                                          viewModel.dataProfile.nama.toString(),
                                          style:
                                          TextStyle(color: Color.fromARGB(
                                              255, 0, 0, 0),
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            );
              }
            );
          }
          )
    );
      }
  }

