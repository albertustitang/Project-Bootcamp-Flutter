import 'package:flutter/material.dart';

import 'alamat_screen.dart';

class TabConrollerScreen extends StatefulWidget {
  const TabConrollerScreen({Key? key}) : super(key: key);

  @override
  State<TabConrollerScreen> createState() => _TabConrollerScreenState();
}

class _TabConrollerScreenState extends State<TabConrollerScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child:
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                backgroundColor: Colors.green,
                title: Text("Tambah Kebun",
                style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.bold
                ),),
                pinned: true,
                floating: true,
                bottom: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: Colors.deepOrange), isScrollable: true,
                  tabs: [
                    Tab(child: Text("Alamat",
                      style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold
                      ),),),
                    Tab(child: Text("Kebun",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold
                      ),),),
                    Tab(child: Text("Dokumen",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold
                      ),),),
                    Tab(child: Text("Sertifikat",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold
                      ),),),
                  ],
                  ),
                ),
              ];
          },
            body: TabBarView(
                children: <Widget>[
                  TambahAlamat(),
                  TambahAlamat(),
                  TambahAlamat(),
                  TambahAlamat(),
          ]
            ),
        )
    )
    );
  }
}
