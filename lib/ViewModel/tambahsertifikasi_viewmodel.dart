import 'package:flutter/material.dart';
import 'package:taniku/Model/response_addkebun_model.dart';
import 'package:taniku/Model/response_tambahsertifikasi_model.dart';
import '../Model/response_sertifikasi_model.dart';
import '../Service/api/tambahkebun_api.dart';
import '../Service/local/db.dart';


class ViewModelTambahSertifikasi extends ChangeNotifier {
  final _dbLocal = MyDb();
  final _listApi = TambahkebunApi();
  ListTambahSertif editSertif = ListTambahSertif();
  List<DataSertifikat> dataSertif = [];
  List<ListTambahSertif> listSertif = [];
  List<ListSertifikasi> dokumenApi = [];

  ViewModelTambahSertifikasi(BuildContext context) {
    getTambahSertifikasi(context);
    getListSertif(context);
    convertSertifikasiList(context);
  }

  void getTambahSertifikasi(BuildContext context) async {
    final response =
    await _listApi.getListSertifikasi(context);
    if (response.error == null) {
      dataSertif = response.data!;
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

  void getListSertif(BuildContext context) async {
    await _dbLocal.open();
    final response = await _dbLocal.getListSetif(context);
    if (response.isNotEmpty) {
      listSertif = response;
    } else {
      print("Tidak Ada Data");
    }
    notifyListeners();
  }

  convertSertifikasiList(BuildContext context) async {
    await _dbLocal.open();
    final response = await _dbLocal.convertListSertifikat();
    if (response.isNotEmpty) {
      dokumenApi.clear();
      dokumenApi = response;
    } else {
      print("Tidak ada Data");
    }
    print(response.length);
    notifyListeners();
  }

  void addSertif(String namaSertif, String noSertif, String dateController, String dateController2, String image, BuildContext context) async {
    await _dbLocal.open();
    await _dbLocal.addSertif(namaSertif, noSertif, dateController, dateController2, image, context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil Tambah Data")));
    notifyListeners();
  }

  void editSertif1(int id, String namaSertif, String noSertif, String dateController, String dateController2, String image, BuildContext context) async {
    await _dbLocal.open();
    await _dbLocal.editSertif(id, namaSertif, noSertif, dateController, dateController2, image, context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil Edit Data")));
    notifyListeners();
  }


  void deleteSertif(int id, BuildContext context) async {
    await _dbLocal.open();
    await _dbLocal.deleteSertif(id, context);
    getListSertif(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil Edit Data")));
    notifyListeners();
  }

}