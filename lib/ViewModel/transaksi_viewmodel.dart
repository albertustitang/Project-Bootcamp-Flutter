import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:taniku/Model/response_transaksi_model.dart';
import 'package:taniku/Service/api/transaksi_api.dart';


class TransaksiViewModel extends ChangeNotifier{
  final _transaksiApi = TransaksiApi();
  // final _sharedPref = SharedPreferenceService();

  List<DataTransaksi> listTransaksi = [];

  TransaksiViewModel(BuildContext context){
    getListTransaksi(context);
  }

  void getListTransaksi(BuildContext context) async {
    final response = await _transaksiApi.getListRepositoryTransaksi(context);
    if (response.error == null) {
      if(response.isSuccess == true) {
        listTransaksi = response.data!;
        print(jsonEncode(listTransaksi));
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }
}