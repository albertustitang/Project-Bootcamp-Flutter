import 'package:flutter/material.dart';
import 'package:taniku/Model/response_tambahdokumen_model.dart';
import '../Model/response_jenisdokumen_model.dart';
import '../Service/api/tambahkebun_api.dart';
import '../Service/local/db.dart';


class ViewModelTambahDokumen extends ChangeNotifier {
  final _dbLocal = MyDb();
  final _listApi = TambahkebunApi();
  ListTambahDokumen editDokumen1 = ListTambahDokumen();
  List<DataJenisDokumen> dataDokumen = [];
  List<ListTambahDokumen> listDokumen = [];
  // List<ListDokumen> addDataDokumen = [];

  ViewModelTambahDokumen(BuildContext context) {
    getTambahDokumen(context);
    getListDokumen(context);
  }

  // void getTambahDataDokumen(BuildContext context) async {
  //   final response =
  //       await _listApi.getDokumen(context);
  //   if (response.error == null) {
  //     dataDokumen = response.data!;
  //    if (response.isSuccess == true) {
  //       print(response.message.toString());
  //     } else {
  //       print(response.message.toString());
  //     }
  //   } else {
  //     print(response.error.toString());
  //   }
  //   notifyListeners();
  // }

  void getTambahDokumen(BuildContext context) async {
    final response =
    await _listApi.getListDokumen(context);
    if (response.error == null) {
      dataDokumen = response.data!;
      if (response.isSuccess == true) {
        print(response.message.toString());
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }

  void getListDokumen(BuildContext context) async {
    await _dbLocal.open();
    final response = await _dbLocal.getListDokumen(context);
    if (response.isNotEmpty) {
      listDokumen = response;
    } else {
      print("Tidak Ada Data");
    }
    notifyListeners();
  }

  void addDokumen(String namaDokumen, String noDokumen, String image, BuildContext context) async {
    await _dbLocal.open();
    await _dbLocal.addDokumen(namaDokumen, noDokumen, image, context);
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil Tambah Data")));
    notifyListeners();
  }

  void editDokumen(int id, String namaDokumen, String noDokumen, String image, BuildContext context) async {
    await _dbLocal.open();
    await _dbLocal.editDokumen(id, namaDokumen, noDokumen, image, context);
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil Tambah Data")));
    notifyListeners();
  }


  void deleteDokumen(int id, BuildContext context) async {
    await _dbLocal.open();
    await _dbLocal.deleteDokumen(id, context);
    getListDokumen(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil Delete Data")));
    notifyListeners();
  }
}