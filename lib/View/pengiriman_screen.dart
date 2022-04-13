import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
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
                                  onTap: () {
                                    // Navigator.push(context, MaterialPageRoute(
                                    //   builder: (context) => Detailscreen_news(value: viewModel.getKebun[index].id.toString()), ));
                                    //
                                  },
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
