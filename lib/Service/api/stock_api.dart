import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taniku/Model/response_stock_model.dart';
import 'package:taniku/service/local/shared_pref_service.dart';


class ReservasiAddApi {
  var client = http.Client();
  var baseUrl = "http://34.126.79.39:81/";

  Future <StockModel> getReservasiAdd (String pabrikid, String waktu, String tanggal, String namapabrik, String tonasi, BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/reservasi/add").replace();
    final tokenLocal = await SharedPreferenceService().getStringSharedPref("token");
    final petaniIdLocal = await SharedPreferenceService().getStringSharedPref("petani_id");
    final userIdLocal = await SharedPreferenceService().getStringSharedPref("user_id");
    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    var _body = jsonEncode({
      "koperasi_id": "",
      "pabrik_id": pabrikid,
      "petani_id": petaniIdLocal,
      "tanggal_pengiriman": tanggal +" "+ waktu,
      "tonasi": tonasi,
      "user_id": userIdLocal });
    print(tokenLocal);
    print(_body);
    try {
      final response = await client
          .post(uri, headers: headersToken(tokenLocal), body: _body)
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return StockModel.fromJson(jsonDecode(response.body));
      } else {
        return StockModel.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return StockModel.withError("Waktu Habis, Silahkan Coba Kembali");
    }

  }
}