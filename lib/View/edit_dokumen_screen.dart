import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taniku/ViewModel/editdokumen_viewmodel.dart';
import 'package:taniku/ViewModel/tambahkebun_viewmodel.dart';

import '../Service/local/db.dart';
import '../ViewModel/tambahdokumen_viewmodel.dart';
import '../ViewModel/tambahkebun_viewmodel.dart';

class EditDokumen extends StatefulWidget {
  final id;

   EditDokumen({Key? key, required this.id}) : super(key: key);

  @override
  State<EditDokumen> createState() => _EditDokumenState();
}

class _EditDokumenState extends State<EditDokumen> {
  var selectDokumen;
  TextEditingController nomordokumen = TextEditingController();
  String? fotolokal;
  File? image;


  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      final fotostring = File(image.path).readAsBytesSync();
      fotolokal = base64.encode(fotostring);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<ViewModelEditDokumen>(
      create: (context) => ViewModelEditDokumen(widget.id, context),
      child: Builder(builder: (context) {
        return Consumer<ViewModelEditDokumen>(
            builder: (context, viewModel, child) {
              selectDokumen = viewModel.dataUser.nama_dokumen.toString();
              nomordokumen.text = viewModel.dataUser.no_dokumen.toString();
              fotolokal = viewModel.dataUser.foto.toString();
              return Scaffold(
                  appBar: AppBar(
                    title: const Text("Edit Document"),
                    backgroundColor: Colors.green,
                  ),
                  body: Container(
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0))),
                      contentPadding: EdgeInsets.only(top: 0.0),
                      content: Container(
                        width: 400.0,
                        height: 480.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(32.0),
                                      topRight: Radius.circular(32.0)),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Tambah Dokumen Kepemilikan",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ))
                                  ],
                                )),
                            SizedBox(
                              height: 5.0,
                            ),
                            Divider(
                              color: Colors.grey,
                              height: 4.0,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Dokumen",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 300,
                                      height: 54,
                                      child:
                                        TextFormField(
                                          decoration:
                                          InputDecoration(
                                            hintText: selectDokumen
                                          ),
                                        ),
                                      // DropdownButtonFormField(
                                      //   decoration: InputDecoration(
                                      //     enabledBorder: OutlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //           color: Colors.black54, width: 2),
                                      //       borderRadius:
                                      //       BorderRadius.circular(32),
                                      //     ),
                                      //     border: OutlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //           color: Colors.black54, width: 2),
                                      //       borderRadius:
                                      //       BorderRadius.circular(32),
                                      //     ),
                                      //     filled: true,
                                      //     fillColor: Colors.white,
                                      //   ),
                                      //   dropdownColor: Colors.white,
                                      //   value: selectDokumen,
                                      //   onChanged: (newValue) {
                                      //     setState(() {
                                      //       print(newValue.toString());
                                      //       selectDokumen= newValue!;
                                      //     });
                                      //   },
                                      //   items: viewModel.dataDokumen
                                      //       .map((value) {
                                      //     return DropdownMenuItem(
                                      //       value: value.dokumenName.toString(),
                                      //       child: Text(
                                      //           value.dokumenName.toString()),
                                      //     );
                                      //   }).toList(),
                                      // ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      "Nomor Dokumen",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 300,
                                      height: 46,
                                      child: TextFormField(
                                        // readOnly: true,
                                        controller: nomordokumen,
                                        decoration: InputDecoration(
                                            focusedBorder:
                                            const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32)),
                                              borderSide: BorderSide(
                                                color: Colors.black54,
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder:
                                            const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32)),
                                              borderSide: BorderSide(
                                                color: Colors.black54,
                                                width: 2,
                                              ),
                                            ),
                                            hintText: ("Nomor Dokumen"),
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      "Foto Dokumen",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Card(
                                          child:( image==null)?Icon(Icons.filter_drama_sharp, size: 30,): Image.memory(base64Decode(fotolokal!)),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Unggah",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.orange),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(28)),
                                              ),
                                              primary: Colors.white,
                                              side: BorderSide(
                                                width: 2,
                                                color: Colors.orange,
                                              ),
                                              fixedSize: Size(100, 50)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Tidak,Ubah'),
                                              child: Text("Tidak, Ubah"),
                                              style: ElevatedButton.styleFrom(
                                                shape: new RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(16),
                                                ),
                                                primary: Colors.orange,
                                                shadowColor: Colors.transparent,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15, vertical: 16),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                viewModel.editUser(widget.id, selectDokumen, nomordokumen.text, fotolokal!, context);
                                                Navigator.pop(context, 'Benar');
                                              },
                                              child: Text("Ya, Benar"),
                                              style: ElevatedButton.styleFrom(
                                                shape: new RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(16),
                                                ),
                                                primary: Colors.orange,
                                                shadowColor: Colors.transparent,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15, vertical: 16),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ));

            });
      }),
    );
  }
}

