import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:taniku/Model/response_kabupaten_model.dart';
import 'package:taniku/Model/response_kecamatan_model.dart';
import 'package:taniku/Model/response_provinsi_model.dart';
import '../Model/response_kelurahan _model.dart';
import 'package:taniku/Service/api/tambahkebun_api.dart';


class TambahkebunViewModel extends ChangeNotifier{
  final _tambahkebunApi = TambahkebunApi();

  List<DataProvinsi> listProvinsi = [];
  List<DataKabupaten> listKabupaten = [];
  List<DataKecamatan> listKecamatan = [];
  List<DataKelurahan> listKelurahan = [];

  TambahkebunViewModel(BuildContext context){
    getListProvinsi(context);
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































}