import 'dart:io';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:taniku/Service/local/shared_pref_service.dart';
import 'package:taniku/View/kebunDetail.dart';
import 'package:taniku/View/tambahkebun_screen.dart';
import '../ViewModel/profile_viewmodel.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_stat_ic_notification');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidRecieveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        print('on message ${notification}');
        displayNotification(notification);
      }
    });

    if (Platform.isIOS) {
      _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    _firebaseMessaging.getToken().then((String? token) async {
      assert(token != null);
      print("fcm_token => " + token.toString());
    });

    _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true
    );

  }

  Future displayNotification(RemoteNotification notification) async{
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channelid', 'flutterfcm',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      platformChannelSpecifics,
      payload: 'hello',);
  }

  Future onSelectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  Future onDidRecieveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          CupertinoAlertDialog(
            title: Text(title!),
            content: Text(body!),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Ok'),
                onPressed: () async {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          ),
    );
  }
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
                                SizedBox(width: 98,),
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
                                SizedBox(width: 80,),
                                ElevatedButton.icon(onPressed: () {
                                  Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                      builder: (_) => TambahKebun())
                                  );
                                },
                                    icon: Icon(Icons.add),
                                    label: Text("Tambah Kebun", style: TextStyle(fontSize: 12),),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                ),),
                              ],
                            ),
                            SizedBox(height: 16,),
                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  ListView.builder(
                                    shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: viewModel.listKebun.length,
                                      itemBuilder: (context,index) {
                                      return Container(
                                        child: 
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Luas Kebun " + viewModel.listKebun[index].luasKebun.toString() + " Hektar ",
                                                style: TextStyle(fontSize: 16, color: Colors.green),),
                                                PopupMenuButton(
                                                  offset: Offset(45, 45),
                                                  onSelected: (value) {
                                                    setState(() {
                                                      if (value == "Detail") {
                                                        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                          builder: (_) => KebunDetail(value: viewModel.listKebun[index].id
                                                              .toString())
                                                        ));
                                                      }else if (value == "Ubah") {

                                                      } else {

                                                      }
                                                    });
                                                  },
                                                  child: Center(
                                                    child: Icon(Icons.more_horiz, color: Colors.deepOrange, size: 30,)),
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem(
                                                        child: Container(
                                                            width: 90,
                                                            child: Text("Lihat Detail")),
                                                        value: 'Detail',
                                                      ),
                                                      PopupMenuItem(
                                                        child: Text("Ubah Data"),
                                                        value: 'Ubah',
                                                      ),
                                                      PopupMenuItem(
                                                        child: Text("Hapus"),
                                                        value: 'Hapus',
                                                      )
                                                    ];
                                                  },
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 12,),
                                            Text("Potensi Produk " + viewModel.listKebun[index].potensiProduksi.toString() + " Kg/Bulan",
                                              style: TextStyle(fontSize: 16, color: Colors.grey),),
                                            SizedBox(height: 10,),
                                            Text("Kondisi Lahan " + viewModel.listKebun[index].statusLahanId.toString(),
                                              style: TextStyle(fontSize: 16, color: Colors.grey),),
                                            SizedBox(height: 10,),
                                            Divider(
                                              thickness: 1,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      );
                                      },
                                  ),
                                ],
                              ),
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
