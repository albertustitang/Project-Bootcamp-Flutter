import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taniku/ViewModel/tambahsertifikasi_viewmodel.dart';
import '../ViewModel/tabbar_viewmodel.dart';
import 'addsertif_screen.dart';
import 'edit_sertifikat_screen.dart';

class TambahSertifikat extends StatefulWidget {
  final TabViewModel parentViewModel;
   TambahSertifikat({Key? key, required this.parentViewModel}) : super(key: key);

  @override
  State<TambahSertifikat> createState() => _TambahSertifikatState();
}

class _TambahSertifikatState extends State<TambahSertifikat> {
  var tipesertif;

  TextEditingController nomorsertif = TextEditingController();
  List<Map> listData = [];
  String? fotolokal;
  File? image;

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
  final dateController1 = TextEditingController();
  final dateController2 = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1960),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate) {
      setState(() {
        // selectedDate = picked;
        dateController1.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1960),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate) {
      setState(() {
        // selectedDate = picked;
        dateController2.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<ViewModelTambahSertifikasi>(
      create: (context) => ViewModelTambahSertifikasi(context),
      child: Builder(builder: (context) {
        return Consumer<ViewModelTambahSertifikasi>(
            builder: (context, viewModel, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,

            body: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 800,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(42),
                      // shape: BoxShape.rectangle,
                      border: Border.all(width: 2.0, color: Colors.deepOrange),
                    ),
                    child: TextButton(
                      child: const Text(
                        'Tambah Sertifikat',
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                      onPressed: () async {
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (_) => addSertifAlertDialog(),).then((
                              _) =>
                              setState(() {
                                viewModel.getListSertif(context);
                              }));
                        });
                      }),
                  ),
                  SizedBox(height: 16,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.listSertif.length,
                    itemBuilder: (context,index) {
                      return Container(
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(viewModel.listSertif[index].nama_sertif.toString(),
                              style: TextStyle(fontSize: 16, color: Colors.green),),
                            SizedBox(height: 12,),
                            Text(viewModel.listSertif[index].no_sertif.toString(),
                              style: TextStyle(fontSize: 16, color: Colors.grey),),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                        return EditSertifikat (id: viewModel.listSertif[index].id.toString());
                                      }));
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      viewModel.deleteSertif(viewModel.listSertif[index].id!, context);
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
                                onPressed: () async {
                                  await viewModel.convertSertifikasiList(context);
                                  widget.parentViewModel.addKebunModel.listSertifikasi = viewModel.dokumenApi;
                                  widget.parentViewModel.addKebun(context);
                                  print(jsonEncode(widget.parentViewModel.addKebunModel));
                                  print(jsonEncode(viewModel.dokumenApi));
                                },
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
