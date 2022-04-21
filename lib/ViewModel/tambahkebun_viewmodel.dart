import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:taniku/Model/response_kabupaten_model.dart';
import 'package:taniku/Model/response_kecamatan_model.dart';
import 'package:taniku/Model/response_provinsi_model.dart';
import '../Model/response_jenisbibit_model.dart';
import '../Model/response_jenisdokumen_model.dart';
import '../Model/response_kelurahan _model.dart';
import 'package:taniku/Service/api/tambahkebun_api.dart';

import '../Model/response_sertifikasi_model.dart';
import '../Model/response_tipelahan_model.dart';


class TambahkebunViewModel extends ChangeNotifier{
  final _tambahkebunApi = TambahkebunApi();

  List<DataProvinsi> listProvinsi = [];
  List<DataKabupaten> listKabupaten = [];
  List<DataKecamatan> listKecamatan = [];
  List<DataKelurahan> listKelurahan = [];
  List<DataBibit > listBibit = [];
  List<DataTipeLahan> listTipeLahan = [];
  List<DataJenisDokumen > listJenisDokumen = [];
  List<DataSertifikat> listSertifikat = [];

  TambahkebunViewModel(BuildContext context){
    getListProvinsi(context);
    getListJenisBibit(context);
    getListTipeLahan(context);
    getListDokumen(context);
    getListSertifikasi(context);
  }
  void getListProvinsi(BuildContext context) async {
    final response = await _tambahkebunApi.getListProvinsi(context);
    if (response.error == null) {
      if(response.isSuccess == true) {
        listProvinsi = response.data!;
        print(jsonEncode(listProvinsi));
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }

  void getListKabupaten(String provinsiId, BuildContext context) async {
    final response = await _tambahkebunApi.getListKabupaten(provinsiId, context);
    if (response.error == null) {
      if(response.isSuccess == true) {
        listKabupaten = response.data!;
        print(jsonEncode(listKabupaten));
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }

  void getListKecamatan(String kotaId, BuildContext context) async {
    final response = await _tambahkebunApi.getListKecamatan(kotaId, context);
    if (response.error == null) {
      if(response.isSuccess == true) {
        listKecamatan = response.data!;
        print(jsonEncode(listKecamatan));
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }

  void getListKelurahan(String kecamatanId, BuildContext context) async {
    final response = await _tambahkebunApi.getListKelurahan(kecamatanId, context);
    if (response.error == null) {
      if(response.isSuccess == true) {
        listKelurahan = response.data!;
        print(jsonEncode(listKelurahan));
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }

  void getListJenisBibit(BuildContext context) async {
    final response = await _tambahkebunApi.getListJenisBibit(context);
    if (response.error == null) {
      if(response.isSuccess == true) {
        listBibit = response.data!;
        print(jsonEncode(listBibit));
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }

  void getListTipeLahan(BuildContext context) async {
    final response = await _tambahkebunApi.getListTipeLahan(context);
    if (response.error == null) {
      if(response.isSuccess == true) {
        listTipeLahan = response.data!;
        print(jsonEncode(listTipeLahan));
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }

  void getListDokumen(BuildContext context) async {
    final response = await _tambahkebunApi.getListDokumen(context);
    if (response.error == null) {
      if(response.isSuccess == true) {
        listJenisDokumen = response.data!;
        print(jsonEncode(listJenisDokumen));
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }

  void getListSertifikasi(BuildContext context) async {
    final response = await _tambahkebunApi.getListSertifikasi(context);
    if (response.error == null) {
      if(response.isSuccess == true) {
        listSertifikat = response.data!;
        print(jsonEncode(listSertifikat));
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }
}