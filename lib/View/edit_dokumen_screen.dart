import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taniku/ViewModel/tambahkebun_viewmodel.dart';
import 'package:taniku/ViewModel/tambahkebun_viewmodel.dart';

import '../Service/local/db.dart';
import '../ViewModel/tambahkebun_viewmodel.dart';

class EditDokumen extends StatefulWidget {
  int id;

   EditDokumen({Key? key, required this.id}) : super(key: key);

  @override
  State<EditDokumen> createState() => _EditDokumenState();
}

class _EditDokumenState extends State<EditDokumen> {
  var selectDokumen;
  TextEditingController nomordokumen = TextEditingController();

  MyDb myDatabase = MyDb();

  @override
  void initState() {
    myDatabase.open();
    Future.delayed(const Duration(milliseconds: 500), () async {
      var data = await myDatabase.getDokumenById(widget.id);
      if (data != null) {
        selectDokumen = data["dokumen_name"];
        nomordokumen.text = data["nomer_dokumen"].toString();
        setState(() {});
      } else
        print("no any data in document" + widget.id.toString());
    }
    );
    super.initState();
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
                        height: 460.0,
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
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black54, width: 2),
                                            borderRadius:
                                            BorderRadius.circular(32),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black54, width: 2),
                                            borderRadius:
                                            BorderRadius.circular(32),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        dropdownColor: Colors.white,
                                        value: selectDokumen,
                                        onChanged: (newValue) {
                                          setState(() {
                                            print(newValue.toString());
                                            selectDokumen= newValue!;
                                          });
                                        },
                                        items: viewModel.listJenisDokumen
                                            .map((value) {
                                          return DropdownMenuItem(
                                            value: value.dokumenName.toString(),
                                            child: Text(
                                                value.dokumenJenis.toString()),
                                          );
                                        }).toList(),
                                      ),
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
                                          // child:( imageFile==null)?Icon(Icons.filter_drama_sharp, size: 30,): Image.file( File(  imageFile!.path)),
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
                                            myDatabase.db.rawInsert(
                                                "UPDATE dokumen SET dokumen_name = ?, nomer_dokumen = ? WHERE id = ?",
                                                [
                                                  selectDokumen,
                                                  nomordokumen.text,
                                                  widget.id
                                                ]);

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                content: const Text(
                                                    "Dokumen Data Updated")));

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

