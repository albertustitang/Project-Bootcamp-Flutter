import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taniku/View/transaksi.dart';

import '../Service/api/stock_api.dart';


class StockViewModel extends ChangeNotifier{
  final _stockApi = StockApi();
  List<Transaksi> listTransaksi = [];

  StockViewModel(BuildContext context) {}

  void getResponseStock(Transaksi, BuildContext context) async {
    final response = await _stockApi.getResponseStock(Transaksi, context);
    if (response.error == null) {
      if(response.isSuccess == true) {
        print(response.message.toString());
        print('Berhasil');
      } else {
        print('gagal');
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }
}