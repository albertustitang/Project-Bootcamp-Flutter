import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taniku/ViewModel/tambahkebun_viewmodel.dart';

class TambahKebun extends StatefulWidget {
  const TambahKebun({ Key? key}) : super(key: key);

  @override
  State<TambahKebun> createState() => _TambahKebunState();
}

class _TambahKebunState extends State<TambahKebun>{
  int _currentTabIndex = 0;
  var selectProv;
  var selectKota;
  var selectCamat;
  var selectLurah;
  var selectPos;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double widht = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<TambahkebunViewModel>(
        create: (context) => TambahkebunViewModel(context),
        child: Builder(builder: (context) {
          return Consumer<TambahkebunViewModel>(builder: (context, viewAddKebun, child) {
            return DefaultTabController(
                length: 4,
                initialIndex: _currentTabIndex,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.green,
                    title: Text('Tambah Kebun'),
                    bottom: PreferredSize(
                      preferredSize: Size(height*0.15, widht*0.15),
                      child: Container(
                        color: Colors.white,
                        width: widht,
                        child: TabBar(
                          indicatorColor: Color.fromARGB(255, 4, 158, 83),
                          tabs: [
                            Container(
                              height: height*0.07,
                              child: Tab(child: Text("Alamat" ,style: TextStyle(color: Colors.green),),),
                            ),
                            Container(

                              child: Tab(child: Text("Kebun" ,style: TextStyle(color: Colors.green),),),
                            ),
                            Container(

                              child: Tab(child: Text("Dokumen" ,style: TextStyle(color: Colors.green),),),
                            ),
                            Container(

                              child: Tab(child: Text("Sertifikasi" ,style: TextStyle(color: Colors.green),),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: const TextSpan(
                                    text: 'Alamat',
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: ' *',
                                          style: TextStyle(
                                            color: Colors.red,))
                                    ]),
                              ),
                              SizedBox(
                                height: height*0.01,
                              ),
                              TextFormField(
                                minLines: 3,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "Deskripsi",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height*0.01,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: const TextSpan(
                                              text: 'RT',
                                              style: TextStyle(color: Colors.black),
                                              children: [
                                                TextSpan(
                                                    text: ' *',
                                                    style: TextStyle(
                                                      color: Colors.red,))
                                              ]),
                                        ),
                                        SizedBox(
                                          height: height*0.01,
                                        ),
                                        Container(
                                          height: height*0.05,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.all(10),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      width: widht*0.01
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: const TextSpan(
                                              text: 'RW',
                                              style: TextStyle(color: Colors.black),
                                              children: [
                                                TextSpan(
                                                    text: ' *',
                                                    style: TextStyle(
                                                      color: Colors.red,))
                                              ]),
                                        ),
                                        SizedBox(
                                          height: height*0.01,
                                        ),
                                        Container(
                                          height: height*0.05,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.all(10),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height*0.01,
                              ),
                              RichText(
                                text: const TextSpan(
                                    text: 'Provinsi',
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: ' *',
                                          style: TextStyle(
                                            color: Colors.red,))
                                    ]),
                              ),
                              SizedBox(
                                height: height*0.01,
                              ),
                              Container(
                                height: height*0.05,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(width: 1, color: Colors.grey)
                                  ),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                    isExpanded: true,
                                    hint: Text("Provinsi"),
                                    value: selectProv,
                                    items: viewAddKebun.listProvinsi.map((item) {
                                      return DropdownMenuItem(
                                        value: item.provinsiId.toString(),
                                        child: Text(item.provinsiName.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectProv = newValue!;
                                        selectKota = null;
                                        selectCamat = null;
                                        selectLurah = null;
                                      });
                                      viewAddKebun.getListKabupaten(selectProv, context);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height*0.01,
                              ),
                              RichText(
                                text: const TextSpan(
                                    text: 'Kabupaten / Kota',
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: ' *',
                                          style: TextStyle(
                                            color: Colors.red,))
                                    ]),
                              ),
                              SizedBox(
                                height: height*0.01,
                              ),
                              Container(
                                height: height*0.05,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(width: 1, color: Colors.grey)
                                  ),
                                  child: DropdownButtonFormField(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                    hint: Text("Kabupaten / Kota"),
                                    value: selectKota,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectKota = newValue!;
                                        selectCamat = null;
                                        selectLurah = null;
                                        viewAddKebun.getListKecamatan(selectKota, context);
                                      });

                                    },
                                    items: viewAddKebun.listKabupaten.map((item) {
                                      return DropdownMenuItem(
                                        value: item.kabupatenKotaId.toString(),
                                        child: Text(item.kabupatenKotaName.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height*0.01,
                              ),
                              RichText(
                                text: const TextSpan(
                                    text: 'Kecamatan',
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: ' *',
                                          style: TextStyle(
                                            color: Colors.red,))
                                    ]),
                              ),
                              SizedBox(
                                height: height*0.01,
                              ),
                              Container(
                                height: height*0.05,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(width: 1, color: Colors.grey)
                                  ),
                                  child: DropdownButtonFormField(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                    hint: Text("Kecamatan"),
                                    value: selectCamat,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectCamat = newValue!;
                                        selectLurah = null;
                                        viewAddKebun.getListKelurahan(selectCamat, context);
                                      });

                                    },
                                    items: viewAddKebun.listKecamatan.map((item) {
                                      return DropdownMenuItem(
                                        value: item.kecamatanId.toString(),
                                        child: Text(item.kecamatanName.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height*0.01,
                              ),
                              RichText(
                                text: const TextSpan(
                                    text: 'Kelurahan',
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: ' *',
                                          style: TextStyle(
                                            color: Colors.red,))
                                    ]),
                              ),
                              SizedBox(
                                height: height*0.01,
                              ),
                              Container(
                                height: height*0.05,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(width: 1, color: Colors.grey)
                                  ),
                                  child: DropdownButtonFormField(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                    hint: Text("Kelurahan"),
                                    value: selectLurah,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectLurah = newValue!;
                                        selectPos = null;
                                      });

                                    },
                                    items: viewAddKebun.listKelurahan.map((item) {
                                      return DropdownMenuItem(
                                        value: item.kelurahanDesaId.toString(),
                                        child: Text(item.kelurahanDesaName.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height*0.01,
                              ),
                              RichText(
                                text: const TextSpan(
                                    text: 'Kode Pos',
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: ' *',
                                          style: TextStyle(
                                            color: Colors.red,))
                                    ]),
                              ),
                              SizedBox(
                                height: height*0.01,
                              ),
                              Container(
                                height: height*0.05,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(width: 1, color: Colors.grey)
                                  ),
                                  child: DropdownButtonFormField(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                    hint: Text("Kode Pos"),
                                    value: selectLurah,
                                    onChanged: null,
                                    items: viewAddKebun.listKelurahan.map((item) {
                                      return DropdownMenuItem(
                                        value: item.kelurahanDesaId.toString(),
                                        child: Text(item.kodePos.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height*0.05,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  OutlinedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: OutlinedButton.styleFrom(
                                        fixedSize: Size(widht*0.45, height*0.06),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50)),
                                        side: BorderSide(color: Colors.deepOrange),
                                      ),
                                      child: Text(
                                        "Batal",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepOrange),
                                      )),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _currentTabIndex = 1;
                                      });
                                    },
                                    child: Container(
                                      width: widht*0.45,
                                      height: height*0.06,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [Colors.orange, Colors.deepOrange]),
                                          borderRadius: BorderRadius.all(Radius.circular(50))),
                                      child: Center(
                                          child: Text(
                                            "Selanjutnya",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Text("It's rainy here"),
                      ),
                      Center(
                        child: Text("It's sunny here"),
                      ),
                      Center(
                        child: Text("It's sunny here"),
                      ),
                    ],
                  ),
                ));
          }
          );
        }
        )
    );
  }
}