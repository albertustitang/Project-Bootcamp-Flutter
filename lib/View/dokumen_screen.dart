import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../ViewModel/tambahkebun_viewmodel.dart';
import 'package:taniku/ViewModel/news_viewmodel.dart';

class TambahDokumen extends StatefulWidget {
  const TambahDokumen({Key? key}) : super(key: key);

  @override
  State<TambahDokumen> createState() => _TambahDokumenState();
}

class _TambahDokumenState extends State<TambahDokumen> {
  var selectDokumen;

  File? image;

  // get value => 'Gallery';
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
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
      child: Builder(
          builder: (context){
            return Consumer<TambahkebunViewModel>(
                builder: (context, viewModel, child){
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
                                  showDialog(context: (context), builder: (_)=>
                                      AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                        titlePadding: const EdgeInsets.all(0),
                                        title: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 2),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text("Tambah Dokumen Kepemilikan", style: TextStyle(color: Colors.white, fontSize: 18),),
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();},
                                                    icon: const Icon(Icons.close, color: Colors.white,))
                                              ],),
                                          ),
                                        ),
                                        content: Container(
                                          height: 320,
                                          width:  400,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                    children: [
                                                      const TextSpan(
                                                        text: 'Dokumen',
                                                        style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
                                                      WidgetSpan(child: Transform.translate(
                                                        offset: const Offset(2, -4),
                                                      ),
                                                      ),
                                                    ]),
                                              ),
                                              const SizedBox(height: 12,),
                                              SizedBox(
                                                width: 300,
                                                height: 60,
                                                child: DropdownButtonFormField(
                                                    decoration: const InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(32)),
                                                        borderSide: BorderSide(color: Colors.grey, width: 2),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(32)),
                                                        borderSide: BorderSide(color: Colors.grey, width: 2),
                                                      ),
                                                    ),
                                                    // borderRadius: BorderRadius.all(Radius.circular(32)),
                                                    hint: Text("Pilih Dokumen"),
                                                    isExpanded: true,
                                                    // value: selectedProvinsi,
                                                    items: viewModel.listJenisDokumen.map((value) {
                                                      return DropdownMenuItem(
                                                          value: value.dokumenId.toString(),
                                                          child: Text (value.dokumenName.toString())
                                                      );
                                                    }).toList(),
                                                    onChanged: (newValue){
                                                      setState(() {
                                                        selectDokumen = newValue!;
                                                      });
                                                      viewModel.getListDokumen(context);
                                                    }),
                                              ),
                                              const SizedBox(height: 12,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(
                                                        children: [
                                                          const TextSpan(
                                                            text: 'Nomor Dokumen',
                                                            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                                                          ),
                                                          WidgetSpan(
                                                            child: Transform.translate(
                                                              offset: const Offset(2, -4),
                                                            ),
                                                          )
                                                        ]),
                                                  ),
                                                  const SizedBox(height: 12,),
                                                  SizedBox(
                                                    width: 300,
                                                    height: 60,
                                                    child: TextFormField(
                                                      keyboardType: TextInputType.number,
                                                      style: const TextStyle(color: Colors.black45),
                                                      // controller: dataAlamatController,
                                                      decoration: const InputDecoration(
                                                        hintText: "Nomor Dokumen",
                                                        enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(32)),
                                                          borderSide: BorderSide(color: Colors.grey, width: 2),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(32)),
                                                          borderSide: BorderSide(color: Colors.grey, width: 2),
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
                                              SizedBox(height: 12,),
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                    children: [
                                                      const TextSpan(
                                                        text: 'Foto Dokumen',
                                                        style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                                                      ),
                                                      WidgetSpan(
                                                        child: Transform.translate(
                                                          offset: const Offset(2, -4),
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
                                                      SizedBox(height: 16,),
                                                      Container(
                                                        height: height*0.1,
                                                        width: widht*0.4,
                                                        decoration: BoxDecoration(
                                                          color: Colors.transparent,
                                                        ),
                                                        child: image != null ?
                                                        Container(
                                                          height: 50,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                            // shape: BoxShape.rectangle,
                                                            image: DecorationImage(
                                                                image: new FileImage(image!), fit: BoxFit.cover),
                                                          ),
                                                        ) : Icon(Icons.photo_size_select_actual_outlined,
                                                          size: 50,
                                                          color: Colors.black,),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 100,
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(16),
                                                          shape: BoxShape.rectangle,
                                                          border: Border.all(width: 2.0, color: Colors.deepOrange),
                                                        ),
                                                        child: TextButton(
                                                          child: const Text(
                                                            'Unggah',
                                                            style: TextStyle(color: Colors.deepOrange),
                                                          ),
                                                          onPressed: () async {
                                                            setState(() {
                                                              showDialog(
                                                                  context: context, builder: (_) =>
                                                                  AlertDialog(
                                                                    shape: const RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                                    title: Container(
                                                                      decoration: const BoxDecoration(
                                                                        // color: Colors.green,
                                                                          borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(0),
                                                                        child: Row(
                                                                          children: [
                                                                            const Text("Pilih Aksi", style: TextStyle(color: Colors.black),),
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
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          const Expanded(child: Divider(thickness: 2,color: Colors.red,)),
                                                                          TextButton(
                                                                            onPressed: (){
                                                                              pickImage(ImageSource.gallery);
                                                                            }, child: Text("Ambil Gambar dari Gallery",style:
                                                                          TextStyle(color: Colors.black),),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed: (){
                                                                              pickImage(ImageSource.camera);
                                                                            }, child: Text("Ambil Gambar dari Camera",style:
                                                                          TextStyle(color: Colors.black),),
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
                                        actions: [ Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                                width: 120,
                                                height: 50,
                                                child: OutlinedButton(
                                                    style: OutlinedButton.styleFrom(
                                                      side: const BorderSide(width: 2.0, color: Colors.orange),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(32.0)
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Tidak, Ubah", style: TextStyle(color: Colors.orange),)
                                                )
                                            ),
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
                                                borderRadius: BorderRadius.circular(32),
                                              ),
                                              child: TextButton(
                                                child: const Text('Ya,Benar',
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  // String noRes = viewModel.listPengiriman[index].noReservasi.toString();
                                                  // String petaniId = viewModel.listPengiriman[index].noReservasi.toString();
                                                  // String tanggal = dateController.text.toString();
                                                  // String waktu = timeController.text.toString();
                                                  // viewModel.getUpdateReservasi(noRes, petaniId, tanggal, waktu, context);
                                                  // Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                          const SizedBox(height: 16,)
                                        ],
                                      ),
                                  );
                                });
                              },
                            ),
                          ),

                        ],
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
                                    border: Border.all(width: 2.0, color: Colors.orange),
                                  ),
                                  child: TextButton(
                                    child: const Text(
                                      'Kembali',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                    onPressed: () {

                                    },
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
