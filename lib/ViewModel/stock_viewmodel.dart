import 'package:flutter/material.dart';
import '../Service/api/stock_api.dart';


class ReservasiAdd extends ChangeNotifier {
  final _reservasiadd = ReservasiAddApi();

  ReservasiAdd(BuildContext context) {
    // getReservasiadd(context);
  }

  void getReservasiadd(String pabrikid, String waktu, String tanggal, String namapabrik, String tonasi, BuildContext context) async {
    final response = await _reservasiadd.getReservasiAdd(pabrikid,  waktu, tanggal, namapabrik, tonasi, context);
    if (response.error == null) {
      if (response.isSuccess == true) {} else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }
}