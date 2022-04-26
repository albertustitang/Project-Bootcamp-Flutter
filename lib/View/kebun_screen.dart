import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// import 'package:taniku/viewmodel/AlamatViewModel.dart';
import 'package:taniku/ViewModel/tambahkebun_viewmodel.dart';

import '../ViewModel/tabbar_viewmodel.dart';

class TambahKebun extends StatefulWidget {
  final TabViewModel parentViewModel;

  const TambahKebun({Key? key, required this.parentViewModel})
      : super(key: key);

  @override
  State<TambahKebun> createState() => _TambahKebunState();
}

class _TambahKebunState extends State<TambahKebun> {
  var selectJenisBibit;
  var selectTipeLahan;

  TextEditingController luaskebun = TextEditingController();
  TextEditingController tahuntanam = TextEditingController();
  TextEditingController jumlahpohon = TextEditingController();
  TextEditingController produksiperbulan = TextEditingController();

  File? image;
  String? fotolokal;

  // get value => 'Gallery';
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      final fotostring = File(image.path).readAsBytesSync();
      fotolokal = base64.encode(fotostring);
      setState(() => this.image = imageTemp);
      print(fotolokal);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double widht = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider<TambahkebunViewModel>(
      create: (context) => TambahkebunViewModel(context),
      child: Builder(builder: (context) {
        return Consumer<TambahkebunViewModel>(
            builder: (context, viewModel, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: 'Luas Kebun',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                WidgetSpan(
                                  child: Transform.translate(
                                    offset: const Offset(2, -4),
                                    child: const Text(
                                      '*',
                                      //superscript is usually smaller in size
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: 170,
                              height: 60,
                              child: TextFormField(
                                controller: luaskebun,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.black45),
                                decoration: const InputDecoration(
                                  hintText: "Luas Kebun",
                                  suffixText: "HA",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                ),
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Data Tidak Boleh Kosong !";
                                //   } else {
                                //     return null;
                                //   }
                                // },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: 'Jenis Bibit',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                WidgetSpan(
                                  child: Transform.translate(
                                    offset: const Offset(2, -4),
                                    child: const Text(
                                      '*',
                                      //superscript is usually smaller in size
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: 170,
                              height: 60,
                              child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(32)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(32)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                  ),
                                  // borderRadius: BorderRadius.all(Radius.circular(32)),
                                  hint: Text("Pilih Jenis Bibit"),
                                  isExpanded: true,
                                  // value: selectedProvinsi,
                                  items: viewModel.listBibit.map((value) {
                                    return DropdownMenuItem(
                                        value: value.jenisBibitId.toString(),
                                        child: Text(
                                            value.jenisBibitName.toString()));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      // print(newValue.toString());
                                      selectJenisBibit = newValue!;
                                      // selectedKec = null;
                                      // selectedKel = null;
                                    });
                                    // viewModel.getKabKota(selectedProvinsi, context);
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: 'Tipe Lahan',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                WidgetSpan(
                                  child: Transform.translate(
                                    offset: const Offset(2, -4),
                                    child: const Text(
                                      '*',
                                      //superscript is usually smaller in size
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: 170,
                              height: 60,
                              child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(32)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(32)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                  ),
                                  // borderRadius: BorderRadius.all(Radius.circular(32)),
                                  hint: Text("Pilih Tipe Lahan"),
                                  isExpanded: true,
                                  // value: selectedProvinsi,
                                  items: viewModel.listTipeLahan.map((value) {
                                    return DropdownMenuItem(
                                        value: value.statusLahanId.toString(),
                                        child: Text(
                                            value.statusLahanName.toString()));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      // print(newValue.toString());
                                      selectTipeLahan = newValue!;
                                      // selectedKabKota = null;
                                      // selectedKec = null;
                                      // selectedKel = null;
                                    });
                                    // viewModel.getKabKota(selectedProvinsi, context);
                                  }),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: 'Tahun Tanam',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                WidgetSpan(
                                  child: Transform.translate(
                                    offset: const Offset(2, -4),
                                    child: const Text(
                                      '*',
                                      //superscript is usually smaller in size
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: 170,
                              height: 60,
                              child: TextFormField(
                                controller: tahuntanam,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.black45),
                                // controller: dataAlamatController,
                                decoration: const InputDecoration(
                                  hintText: "Tahun Tanam",
                                  hintStyle: TextStyle(),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                ),
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Data Tidak Boleh Kosong !";
                                //   } else {
                                //     return null;
                                //   }
                                // },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: 'Jumlah Pohon',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                WidgetSpan(
                                  child: Transform.translate(
                                    offset: const Offset(2, -4),
                                    child: const Text(
                                      '*',
                                      //superscript is usually smaller in size
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: 170,
                              height: 60,
                              child: TextFormField(
                                controller: jumlahpohon,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.black45),
                                // controller: dataAlamatController,
                                decoration: const InputDecoration(
                                  hintText: "Jumlah Pohon",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                ),
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Data Tidak Boleh Kosong !";
                                //   } else {
                                //     return null;
                                //   }
                                // },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: 'Produksi Per Bulan',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                WidgetSpan(
                                  child: Transform.translate(
                                    offset: const Offset(2, -4),
                                    child: const Text(
                                      '*',
                                      //superscript is usually smaller in size
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: 170,
                              height: 60,
                              child: TextFormField(
                                controller: produksiperbulan,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.black45),
                                // controller: dataAlamatController,
                                decoration: const InputDecoration(
                                  // prefixIcon: Padding(padding: EdgeInsets.fromLTRB(4, 20, 4, 20),
                                  //     child: Text('Ton/Bulan',)
                                  // ),
                                  hintText: "Produksi Per Bulan",
                                  suffixText: "Ton/Bulan",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                ),
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Data Tidak Boleh Kosong !";
                                //   } else {
                                //     return null;
                                //   }
                                // },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        const TextSpan(
                          text: 'Foto Kebun',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        WidgetSpan(
                          child: Transform.translate(
                            offset: const Offset(2, -4),
                            child: const Text(
                              '*',
                              //superscript is usually smaller in size
                              textScaleFactor: 1,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            // Icon(Icons.add_photo_alternate_outlined, size: 150,),
                            Container(
                              height: height * 0.2,
                              width: widht * 0.5,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: image != null
                                  ? Container(
                                      height: 100,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        // shape: BoxShape.rectangle,
                                        image: DecorationImage(
                                            image: new FileImage(image!),
                                            fit: BoxFit.cover),
                                      ),
                                    )
                                  : Icon(
                                      Icons.photo_size_select_actual_outlined,
                                      size: 150,
                                      color: Colors.black,
                                    ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                    width: 2.0, color: Colors.orange),
                              ),
                              child: TextButton(
                                child: const Text(
                                  'Unggah',
                                  style: TextStyle(color: Colors.orange),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                              title: Container(
                                                decoration: const BoxDecoration(
                                                    // color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(10),
                                                            topLeft:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        "Pilih Aksi",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      // IconButton(
                                                      //     onPressed: () {
                                                      //       Navigator.of(context).pop();},
                                                      //     icon: const Icon(Icons.close, color: Colors.white,))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              content: SizedBox(
                                                width: 400,
                                                height: 100,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Expanded(
                                                        child: Divider(
                                                      thickness: 2,
                                                      color: Colors.red,
                                                    )),
                                                    TextButton(
                                                      onPressed: () {
                                                        pickImage(ImageSource
                                                            .gallery);
                                                      },
                                                      child: Text(
                                                        "Ambil Gambar dari Gallery",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        pickImage(
                                                            ImageSource.camera);
                                                      },
                                                      child: Text(
                                                        "Ambil Gambar dari Camera",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    // DropdownMenuItem(
                                                    //   child: Text("Ambil Gambar dari Gallery"),
                                                    //   value: 'Gallery',
                                                    // ),
                                                    // DropdownMenuItem(
                                                    //   child: Text("Ambil Gambar dari Camera"),
                                                    //   value: 'Camera',
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ));
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            persistentFooterButtons: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            shape: BoxShape.rectangle,
                            border:
                                Border.all(width: 2.0, color: Colors.orange),
                          ),
                          child: TextButton(
                            child: const Text(
                              'Kembali',
                              style: TextStyle(color: Colors.orange),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          // margin: EdgeInsets.all(20),
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.orange, Colors.deepOrange],
                              begin: FractionalOffset.bottomLeft,
                              end: FractionalOffset.topRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextButton(
                            child: const Text(
                              'Selanjutnya',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              widget.parentViewModel.addKebunModel.luasKebun =
                                  luaskebun.text;
                              widget.parentViewModel.addKebunModel
                                  .tahunTanamId = tahuntanam.text;
                              widget.parentViewModel.addKebunModel.jumlahPohon =
                                  jumlahpohon.text;
                              widget.parentViewModel.addKebunModel
                                  .potensiProduksi = produksiperbulan.text;
                              widget.parentViewModel.addKebunModel
                                  .jenisBibitId = selectJenisBibit;
                              widget.parentViewModel.addKebunModel
                                  .statusLahanId = selectTipeLahan;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        });
      }),
    );
  }
}
