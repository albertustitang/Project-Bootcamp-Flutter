import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:taniku/viewmodel/pengiriman_viewmodel.dart';

class Pengiriman_screen extends StatefulWidget {
  const Pengiriman_screen({Key? key}) : super(key: key);

  @override
  State<Pengiriman_screen> createState() => _Pengiriman_screenState();
}

class _Pengiriman_screenState extends State<Pengiriman_screen> {

  bool _isVisible = true;

  void ShowButton() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PengirimanViewModel>(
      create: (context) => PengirimanViewModel(context),
      child: Builder(
        builder: (context) {
          return Consumer<PengirimanViewModel>(
              builder: (context, viewModel, child) {
                return Scaffold(
                    appBar: AppBar(
                      title: Text("Daftar Reservasi Pengiriman TBS"),
                      backgroundColor: Colors.green,
                      actions: [
                        IconButton(
                            onPressed: () {

                            },
                            icon: Icon(
                              Icons.notifications,
                              color: Colors.white,
                            )
                        ),
                      ],
                    ),
                    body: Container(
                      margin: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: viewModel.listPengiriman.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {},
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Card(
                                          child: Row(
                                            children: [
                                              Column(),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(width: 8,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(bottom: 100),
                                                        child: Icon(Icons.apartment_rounded, size: 60,),
                                                      ),
                                                      SizedBox(width: 18,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          SizedBox(height: 16,),
                                                          Row(
                                                            children: [
                                                              Text(viewModel.listPengiriman[index].tanggalPengiriman.toString(), style: const TextStyle(fontSize: 16)),
                                                              SizedBox(width: 50,),
                                                              Text(viewModel.listPengiriman[index].statusName.toString(),
                                                                  style: const TextStyle(
                                                                      fontSize: 14, fontStyle: FontStyle.italic, color: Colors.lightGreen
                                                                  )
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 8,),
                                                          Text(viewModel.listPengiriman[index].noReservasi.toString(),
                                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                                          SizedBox(height: 8,),
                                                          Text(viewModel.listPengiriman[index].namaPabrik.toString(),
                                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                                          SizedBox(height: 8,),
                                                          Row(
                                                            children: [
                                                              Text(viewModel.listPengiriman[index].tonasi.toString(),
                                                                  style: const TextStyle(fontSize: 16, color: Colors.lightGreen, fontWeight: FontWeight.bold)),
                                                              SizedBox(width: 10,),
                                                              Text("kg", style: const TextStyle(fontSize: 16, color: Colors.lightGreen, fontWeight: FontWeight.bold)),
                                                            ],
                                                          ),
                                                          SizedBox(height: 8,),
                                                          Row(children: [
                                                            if(viewModel.listPengiriman[index].status.toString() == "1") ... [
                                                              ElevatedButton.icon(
                                                                  onPressed: () async {
                                                                    setState(() {
                                                                    showDialog(
                                                                        context: context,
                                                                        builder: (BuildContext context) => new AlertDialog(
                                                                            contentPadding: EdgeInsets.only(left: 100, right: 100, top: 100, bottom: 100),
                                                                            titlePadding: EdgeInsets.all(0),
                                                                            title: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                    height: 50,
                                                                                    width: 264,
                                                                                    color: Colors.green,
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.only(left: 15, top: 15),
                                                                                      child: Text('Lihat QR', style: TextStyle(color: Colors.white),),
                                                                                    )),
                                                                                Container(
                                                                                  height: 50,
                                                                                  width: 112,
                                                                                  color: Colors.green,
                                                                                  child: IconButton(
                                                                                      icon: new Icon(Icons.close, color: Colors.white,),
                                                                                      onPressed: ()  {
                                                                                        Navigator.pop(context);
                                                                                      }),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            content:
                                                                            SizedBox(
                                                                              width: 200,
                                                                              height: 200,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  QrImage(
                                                                                    data: viewModel.listPengiriman[index].noReservasi.toString(),
                                                                                    version: QrVersions.auto,
                                                                                    size: 150,
                                                                                  ),
                                                                                  SizedBox(height: 12,),
                                                                                  Text(viewModel.listPengiriman[index].noReservasi.toString(), style: TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          actions: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  width: 250,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                                                                    gradient: LinearGradient(colors: [Colors.orange, Colors.deepOrange]
                                                                                    ),
                                                                                  ),
                                                                                  child: ElevatedButton(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    style: ElevatedButton.styleFrom(primary: Colors.transparent, shadowColor: Colors.transparent),
                                                                                    child: Text('Kembali', style: TextStyle(fontWeight: FontWeight.bold),),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ));
                                                                    });
                                                                  },
                                                                  icon: Icon(Icons.qr_code,
                                                                    color: Colors.orange,
                                                                    size: 30,
                                                                  ),
                                                                  label: Text(""),
                                                                  style: ElevatedButton.styleFrom(
                                                                      primary: Colors.white)
                                                              ),
                                                              SizedBox(width: 10,),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    showDialog(
                                                                        context: context,
                                                                        builder: (_) => AlertDialog(
                                                                          shape: const RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(20),),),
                                                                          titlePadding: const EdgeInsets.all(0),
                                                                          title: Container(
                                                                            decoration: BoxDecoration(
                                                                              color: Colors.green,
                                                                              borderRadius: BorderRadius.all(Radius.circular(20),),),
                                                                            child: Padding(padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  const Text("Reschedule Pengiriman TBS", style: TextStyle(color: Colors.white,),),
                                                                                  IconButton(onPressed: (){
                                                                                    Navigator.of(context).pop();
                                                                                  }, icon: const Icon(Icons.close, color:Colors.white,),),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          content:
                                                                          SizedBox(
                                                                            width: 100,
                                                                            child: TextFormField(

                                                                            ),
                                                                          ),
                                                                          actions: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  width: 250,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                                                                    gradient: LinearGradient(colors: [Colors.orange, Colors.deepOrange]
                                                                                    ),
                                                                                  ),
                                                                                  child: ElevatedButton(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    style: ElevatedButton.styleFrom(primary: Colors.transparent, shadowColor: Colors.transparent),
                                                                                    child: Text('Kembali', style: TextStyle(fontWeight: FontWeight.bold),),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ));
                                                                  });
                                                                },
                                                                child: Text("Jadwal Ulang"),
                                                                style: ElevatedButton.styleFrom(
                                                                  primary: Colors.orange,
                                                                  shape: new RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(16),
                                                                  ),
                                                                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                                                ),
                                                              ),
                                                            ]
                                                            else if(viewModel.listPengiriman[index].status.toString() == "2") ... [
                                                              ElevatedButton(
                                                                onPressed: () {

                                                                },
                                                                child: Text("Faktur"),
                                                                style: ElevatedButton.styleFrom(
                                                                  primary: Colors.lightGreen,
                                                                  shape: new RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(16),
                                                                  ),
                                                                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                                                ),
                                                              ),
                                                            ],
                                                          ],
                                                          ),
                                                          SizedBox(height: 16,),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                );
              });
        },
      ),
    );
  }
}
