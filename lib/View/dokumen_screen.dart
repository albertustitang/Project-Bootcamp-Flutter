import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taniku/View/edit_dokumen_screen.dart';
import '../Service/local/db.dart';
import '../ViewModel/tambahdokumen_viewmodel.dart';

class TambahDokumen extends StatefulWidget {
  const TambahDokumen({Key? key}) : super(key: key);

  @override
  State<TambahDokumen> createState() => _TambahDokumenState();
}

class _TambahDokumenState extends State<TambahDokumen> {
  var selectDokumen;
  TextEditingController nomordokumen = TextEditingController();
  String? fotolokal;
  File? image;

  List<Map> listData = [];

  // get value => 'Gallery';
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      final fotostring = File(image.path).readAsBytesSync();
      fotolokal = base64.encode(fotostring);
      print(fotolokal);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double widht = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<ViewModelTambahDokumen>(
      create: (context) => ViewModelTambahDokumen(context),
      child: Builder(builder: (context) {
        return Consumer<ViewModelTambahDokumen>(
            builder: (context, viewModel, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 800,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(42),
                      border: Border.all(width: 2.0, color: Colors.deepOrange),
                    ),
                    child: TextButton(
                      child: const Text(
                        'Tambah Dokumen Kepemilikan',
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                      onPressed: () async {
                        setState(() {
                          showDialog(
                            context: (context),
                            builder: (_) => AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              titlePadding: const EdgeInsets.all(0),
                              title: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Tambah Dokumen Kepemilikan",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              content: Container(
                                height: height*0.4,
                                width: 400,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        const TextSpan(
                                          text: 'Dokumen',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        WidgetSpan(
                                          child: Transform.translate(
                                            offset: const Offset(2, -4),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: 300,
                                      height: 60,
                                      child: DropdownButtonFormField(
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey, width: 2),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey, width: 2),
                                            ),
                                          ),
                                          // borderRadius: BorderRadius.all(Radius.circular(32)),
                                          hint: Text("Pilih Dokumen"),
                                          isExpanded: true,
                                          value: selectDokumen,
                                          items: viewModel.dataDokumen
                                              .map((value) {
                                            return DropdownMenuItem(
                                                value: value.dokumenName
                                                    .toString(),
                                                child: Text(value.dokumenName
                                                    .toString()));
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectDokumen = newValue!;
                                            });
                                            viewModel.getListDokumen(context);
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            const TextSpan(
                                              text: 'Nomor Dokumen',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            WidgetSpan(
                                              child: Transform.translate(
                                                offset: const Offset(2, -4),
                                              ),
                                            )
                                          ]),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          height: 60,
                                          child: TextFormField(
                                            controller: nomordokumen,
                                            keyboardType: TextInputType.number,
                                            style: const TextStyle(
                                                color: Colors.black45),
                                            decoration: const InputDecoration(
                                              hintText: "Nomor Dokumen",
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(32)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 2),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(32)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 2),
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
                                    SizedBox(
                                      height: 12,
                                    ),
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        const TextSpan(
                                          text: 'Foto Dokumen',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        WidgetSpan(
                                          child: Transform.translate(
                                            offset: const Offset(2, -4),
                                          ),
                                        )
                                      ]),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Container(
                                              height: height * 0.1,
                                              width: widht * 0.4,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                              ),
                                              child: image != null
                                                  ? Container(
                                                      height: 50,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        // shape: BoxShape.rectangle,
                                                        image: DecorationImage(
                                                            image:
                                                                new FileImage(
                                                                    image!),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .photo_size_select_actual_outlined,
                                                      size: 50,
                                                      color: Colors.black,
                                                    ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    width: 2.0,
                                                    color: Colors.deepOrange),
                                              ),
                                              child: TextButton(
                                                child: const Text(
                                                  'Unggah',
                                                  style: TextStyle(
                                                      color: Colors.deepOrange),
                                                ),
                                                onPressed: () async {
                                                  setState(() {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (_) => AlertDialog(
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10.0))),
                                                                  title:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                            // color: Colors.green,
                                                                            borderRadius:
                                                                                BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Text(
                                                                            "Pilih Aksi",
                                                                            style:
                                                                                TextStyle(color: Colors.black),
                                                                          ),
                                                                          // IconButton(
                                                                          //     onPressed: () {
                                                                          //       Navigator.of(context).pop();},
                                                                          //     icon: const Icon(Icons.close, color: Colors.white,))
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  content:
                                                                      SizedBox(
                                                                    width: 400,
                                                                    height: 150,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        const Expanded(
                                                                            child:
                                                                                Divider(
                                                                          thickness:
                                                                              2,
                                                                          color:
                                                                              Colors.red,
                                                                        )),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            pickImage(ImageSource.gallery);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            "Ambil Gambar dari Gallery",
                                                                            style:
                                                                                TextStyle(color: Colors.black),
                                                                          ),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            pickImage(ImageSource.camera);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            "Ambil Gambar dari Camera",
                                                                            style:
                                                                                TextStyle(color: Colors.black),
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
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width: 120,
                                        height: 50,
                                        child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                  width: 2.0,
                                                  color: Colors.orange),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          32.0)),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Tidak, Ubah",
                                              style: TextStyle(
                                                  color: Colors.orange),
                                            ))),
                                    Container(
                                      // margin: EdgeInsets.all(20),
                                      width: 120,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Colors.orange,
                                            Colors.deepOrange
                                          ],
                                          begin: FractionalOffset.bottomLeft,
                                          end: FractionalOffset.topRight,
                                        ),
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      child: TextButton(
                                        child: const Text(
                                          'Ya,Benar',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          viewModel.addDokumen(selectDokumen, nomordokumen.text, fotolokal!, context);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "New Dokumen Added")));
                                          selectDokumen = "";
                                          nomordokumen.text = "";
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                )
                              ],
                            ),
                          );
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 16,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.listDokumen.length,
                    itemBuilder: (context,index) {
                      return Container(
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(viewModel.listDokumen[index].nama_dokumen.toString(),
                              style: TextStyle(fontSize: 16, color: Colors.green),),
                            SizedBox(height: 12,),
                            Text(viewModel.listDokumen[index].no_dokumen.toString() ,
                              style: TextStyle(fontSize: 16, color: Colors.grey),),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                        return EditDokumen (id: viewModel.listDokumen[index].id.toString());
                                      }));
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      viewModel.deleteDokumen(viewModel.listDokumen[index].id!, context);
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red))
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: 120,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                    width: 2.0, color: Colors.orange),
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
                              width: 120,
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
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      }),
    );
  }
}
