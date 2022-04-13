import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taniku/Model/response_listdetail_model.dart';
import 'package:taniku/ViewModel/detailkebun_viewmodel.dart';
class KebunDetail extends StatefulWidget {
  String value;
  KebunDetail({ Key? key, required this.value,}) : super(key: key);

  @override
  State<KebunDetail> createState() => _KebunDetailState();
}

class _KebunDetailState extends State<KebunDetail> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModelDetailKebun>(
      create: (context) => ViewModelDetailKebun(context, widget.value),
      child: Builder(builder: (context) {
        return Consumer<ViewModelDetailKebun>(
            builder: (context, viewDetailKebun, child) {
              return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.green,
                    title: Text("Detail Kebun"),
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            child: Container(
                                margin: const EdgeInsets.only(left: 18, right: 18, top: 20),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 300,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount:
                                        viewDetailKebun.dataDetailKebun.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("Alamat",
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold)),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(viewDetailKebun.dataDetailKebun[index].alamat.toString()
                                                    + ", " + viewDetailKebun.dataDetailKebun[index].kelurahanName.toString()
                                                    + ", " + viewDetailKebun.dataDetailKebun[index].kecamatanName.toString()
                                                    + ", "  + "\n" + viewDetailKebun.dataDetailKebun[index].kabupatenKotaName.toString()
                                                    + ", " + viewDetailKebun.dataDetailKebun[index].provinsiName.toString()
                                                    + ", " + viewDetailKebun.dataDetailKebun[index].kodePos.toString()),
                                                SizedBox(height: 20),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Luas Kebun", style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold)),
                                                        Text(viewDetailKebun.dataDetailKebun[index].luasKebun.toString()),
                                                      ],
                                                    ),
                                                    SizedBox(width: 90),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Jenis Bibit", style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold)),
                                                        Text(viewDetailKebun.dataDetailKebun[index].jenisBibitName.toString()),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Tipe Lahan", style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold)),
                                                        Text(viewDetailKebun.dataDetailKebun[index].statusLahanName.toString()),
                                                      ],
                                                    ),
                                                    SizedBox(width: 90),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Tahun Tanam", style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold)),
                                                        Text(viewDetailKebun.dataDetailKebun[index].tahunTanamId.toString()),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Jumlah Pohon", style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold)),
                                                        Text(viewDetailKebun.dataDetailKebun[index].jumlahPohon.toString()),
                                                      ],
                                                    ),
                                                    SizedBox(width: 70),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Produksi Per Bulan", style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold)),
                                                        Text(viewDetailKebun.dataDetailKebun[index].potensiProduksi.toString()
                                                            + " " + "Ton/Bulan"),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10,),
                                                Text("Foto", style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Card(
                            child: Container(
                                margin: const EdgeInsets.only(left: 18, right: 18, top: 20),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Dokumen",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(height: 10,),
                                    SizedBox(
                                      height: 150,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount:
                                        viewDetailKebun.dataDocument.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            child:
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.credit_card, size: 50,),
                                                SizedBox(width: 10,),
                                                Card(
                                                    child: SizedBox(
                                                      height: 55,
                                                      width: 245,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(viewDetailKebun.dataDocument[index].dokumenName.toString()),
                                                          SizedBox(height: 8,),
                                                          Text(viewDetailKebun.dataDocument[index].nomor.toString()),
                                                        ],
                                                      ),
                                                    )
                                                ),

                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Card(
                            child: Container(
                                margin: const EdgeInsets.only(left: 18, right: 18, top: 20),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Sertifikat",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(height: 10,),
                                    SizedBox(
                                      height: 50,
                                      child: ListView.builder(
                                        itemCount:
                                        viewDetailKebun.dataSertif.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            child:
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.credit_card, size: 50,),
                                                SizedBox(width: 10,),
                                                Card(
                                                    child: SizedBox(
                                                      height: 50,
                                                      width: 245,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(viewDetailKebun.dataSertif[index].sertifikasiName.toString()),
                                                          SizedBox(height: 8,),
                                                          Text(viewDetailKebun.dataSertif[index].sertifikasiNo.toString()),
                                                        ],
                                                      ),
                                                    )
                                                ),

                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),

                  )
              );
            });
      }),
    );
  }
}
