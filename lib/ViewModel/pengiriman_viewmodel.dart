import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../Model/response_pengiriman_model.dart';
import '../Service/api/pengiriman_api.dart';
import 'package:taniku/Service/api/stockedit_api.dart';


class PengirimanViewModel extends ChangeNotifier{
  final _pengirimanApi = PengirimanApi();
  final _StockEditApi = StockEditApi();
  // final _sharedPref = SharedPreferenceService();

  List<DataPengiriman> listPengiriman = [];

  PengirimanViewModel(BuildContext context){
    this.getListPengiriman(context);
  }

  void getListPengiriman(BuildContext context) async {
    final response = await _pengirimanApi.getListPengiriman(context);
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

  void getStockEdit(String noRes, String pabrik_id, String tanggal, String waktu, BuildContext context) async {
    final response = await _StockEditApi.getStockEdit(noRes,pabrik_id,tanggal,waktu, context);
    if (response.error == null) {
      if(response.isSuccess == true) {
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }
}