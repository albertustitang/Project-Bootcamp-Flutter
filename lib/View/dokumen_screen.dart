import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taniku/View/adddokumen_screen.dart';
import 'package:taniku/View/edit_dokumen_screen.dart';
import '../ViewModel/tabbar_viewmodel.dart';
import '../ViewModel/tambahdokumen_viewmodel.dart';

class TambahDokumen extends StatefulWidget {
  // final id, petaniId;
  final TabViewModel parentViewModel;
   TambahDokumen({Key? key,required this.parentViewModel}) : super(key: key);

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
                            context: context,
                            builder: (_) => addDokumenAlertDialog(),).then((
                              _) =>
                              setState(() {
                                viewModel.getListDokumen(context);
                              }));
                        });
                      }),
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
                                        return EditDokumen (id: int.parse(viewModel.listDokumen[index].id.toString()));
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
                                onPressed: () async {
                                  await viewModel.convertDokumenList(context);
                                  widget.parentViewModel.addKebunModel.listDokumen = viewModel.dokumenApi;
                                  print(jsonEncode(widget.parentViewModel.addKebunModel));
                                  print(jsonEncode(viewModel.dokumenApi));

                                  // widget.next.call();
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
