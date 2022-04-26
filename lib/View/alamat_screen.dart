import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:taniku/ViewModel/tabbar_viewmodel.dart';
import 'package:taniku/ViewModel/tambahkebun_viewmodel.dart';

class TambahAlamat extends StatefulWidget {
  final id, petaniId;
  final TabViewModel parentViewModel;
  const TambahAlamat({ Key? key, required this.parentViewModel, required this.id, required this.petaniId}) : super(key: key);

  @override
  State<TambahAlamat> createState() => _TambahAlamatState();
}

class _TambahAlamatState extends State<TambahAlamat>{
  int _currentTabIndex = 0;
  var selectProv;
  var selectKota;
  var selectCamat;
  var selectLurah;
  var selectPos;

  TextEditingController alamat = TextEditingController();
  TextEditingController RT = TextEditingController();
  TextEditingController RW = TextEditingController();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _userLocation;
  Future<void> _getUserLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final _locationData = await location.getLocation();
    setState(() {
      _userLocation = _locationData;
    });
  }


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<TambahkebunViewModel>(
        create: (context) => TambahkebunViewModel(context),
        child: Builder(builder: (context) {
          return Consumer<TambahkebunViewModel>(builder: (context, viewModel, child) {
            return Scaffold(
              body: SingleChildScrollView(
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
                        controller: alamat,
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
                                SizedBox(
                                  height: height*0.05,
                                  child: TextFormField(
                                    controller: RT,
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
                              width: width*0.01
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
                                    controller: RW,
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
                            items: viewModel.listProvinsi.map((item) {
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
                              viewModel.getListKabupaten(selectProv, context);
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
                                viewModel.getListKecamatan(selectKota, context);
                              });

                            },
                            items: viewModel.listKabupaten.map((item) {
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
                                viewModel.getListKelurahan(selectCamat, context);
                              });

                            },
                            items: viewModel.listKecamatan.map((item) {
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
                            items: viewModel.listKelurahan.map((item) {
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
                            items: viewModel.listKelurahan.map((item) {
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
                                fixedSize: Size(width*0.45, height*0.06),
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
                              widget.parentViewModel.addKebunModel.alamat = alamat.text;
                              widget.parentViewModel.addKebunModel.rt = RT.text;
                              widget.parentViewModel.addKebunModel.rw = RW.text;
                              widget.parentViewModel.addKebunModel.provinsiId = selectProv;
                              widget.parentViewModel.addKebunModel.kabupatenKotaId = selectKota;
                              widget.parentViewModel.addKebunModel.kecamatanId = selectCamat;
                              widget.parentViewModel.addKebunModel.kelurahanId = selectLurah;
                              widget.parentViewModel.addKebunModel.kodePos = selectPos;
                              widget.parentViewModel.addKebunModel.userId = widget.id;
                              widget.parentViewModel.addKebunModel.petaniId = widget.petaniId;

                            },
                            child: Container(
                              width: width*0.45,
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
            );
          }
          );
        }
        )
    );
  }
}