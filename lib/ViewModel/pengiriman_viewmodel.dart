import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:taniku/Model/response_transaksi_model.dart';
import 'package:taniku/Service/api/transaksi_api.dart';

import '../Model/response_pengiriman_model.dart';
import '../Service/api/pengiriman_api.dart';


class PengirimanViewModel extends ChangeNotifier{
  final _pengirimanApi = PengirimanApi();
  // final _sharedPref = SharedPreferenceService();

  List<DataPengiriman> listPengiriman = [];

  PengirimanViewModel(BuildContext context){
    this.getListPengiriman(context);
  }

  void getListPengiriman(BuildContext context) async {
    final response = await _pengirimanApi.getListRepositoryPengiriman(context);
    if (response.error == null) {
      if(response.isSuccess == true) {
        listPengiriman = response.data!;
        print(jsonEncode(listPengiriman));
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }
}