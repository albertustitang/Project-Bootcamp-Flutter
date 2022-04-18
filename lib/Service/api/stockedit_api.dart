import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taniku/Service/local/shared_pref_service.dart';
import '../../Model/stockedit_model.dart';


class StockEditApi {
  var client = http.Client();
  var baseUrl = "http://34.126.79.39:81/";

  Future <StockEditModel> getStockEdit ( String noRes, String pabrik_id, String tanggal, String waktu, BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/reservasi/edit").replace();
    final tokenLocal = await SharedPreferenceService().getStringSharedPref("token");
    final petaniIdLocal = await SharedPreferenceService().getStringSharedPref("petani_id");
    final userIdLOcal = await SharedPreferenceService().getStringSharedPref("user_id");

    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer OTE0YmNjNGFhZjhiNTRiMGMzMjAyMjg1YjBhZmM0MzQ5YjViNDhhZg=='
      };
    }
    var _body = jsonEncode({
      "no_reservasi":noRes,
      "pabrik_id": pabrik_id,
      "status":"1",
      "tanggal_pengiriman":tanggal + " " + waktu,
      "type_user":"PTN",
      "user_id":85,
    });

    print(tokenLocal);
    print(_body);
    try {
      final response = await client
          .post(uri, headers: headersToken(tokenLocal), body: _body)
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return StockEditModel.fromJson(jsonDecode(response.body));
      } else {
        return StockEditModel.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return StockEditModel.withError("Waktu Habis, Silahkan Coba Kembali");
    }

  }
}