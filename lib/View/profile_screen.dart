
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
    final Color background = Color.fromARGB(255, 8, 49, 71);
    final Color fill = Colors.white;
    final List<Color> gradient = [
      background,
      background,
      fill,
      fill,
    ];
    final double fillPercent = 56.23; // fills 56.23% for container from bottom
    final double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];
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
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradient,
                      stops: stops,
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                    ),
                  ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    backgroundImage: AssetImage("assets/dasha.jpg") ,)
                                )
                                // Icon(Icons.person,
                                //   size: 100,color: Colors.white,),
                              ],
                            ),
                            // NetworkImage("viewModel.getProfileList.foto.toString()"),
                        ),
                        Container(
                          // margin: EdgeInsets.only(top: 200),
                          child: 
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(viewModel.dataProfile.nama.toString(),style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 20)),
                                const SizedBox(height: 8,),
                                Text(viewModel.dataProfile.mobile.toString(),style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),),
                            ],
                          ),
                        )
                      ],
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
