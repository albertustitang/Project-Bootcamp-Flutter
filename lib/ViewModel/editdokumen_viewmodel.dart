import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taniku/Service/api/tambahkebun_api.dart';

import '../Model/response_jenisdokumen_model.dart';
import '../Model/response_tambahdokumen_model.dart';
import '../Service/local/db.dart';


class ViewModelEditDokumen extends ChangeNotifier{
  final _dbLocal = MyDb();
  final _listApi = TambahkebunApi();
  ListTambahDokumen dataUser = ListTambahDokumen();
  List<DataJenisDokumen> dataDokumen = [];

  ViewModelEditDokumen(int id, BuildContext context){
    getDokumenById(id, context);
    getTambahDokumen(context);
  }

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

  void getDokumenById(int id, BuildContext context) async {
    await _dbLocal.open();
    final response = await _dbLocal.getDokumenById(id, context);
    if (response != null) {
      dataUser = response;
      print(dataUser);
    } else {
      print("Tidak Ada Data");
    }
    notifyListeners();
  }

  void editUser(int id, String namaDokumen, String noDokumen, String image, BuildContext context) async {
    await _dbLocal.open();
    await _dbLocal.editDokumen(id, namaDokumen, noDokumen, image, context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil Edit Data")));
    notifyListeners();
  }

}