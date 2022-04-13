import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taniku/Model/response_stock_model.dart';
import 'package:taniku/View/transaksi.dart';

class StockApi {
  var client = http.Client();
  var baseUrl = "http://34.126.79.39:81/";

  Future<StockModel> getResponseStock(Transaksi, BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/reservasi/add").replace();
    final tokenLocal = "N2IyN2I0N2ZmZGU3MmE4NjgxNDhjZGZlNTA4ZGFhZTY0Zjc4YmI0Yw==";
    Map<String, String> headers() {
      return {'Content-Type': 'application/json', 'Accept': 'application/json'};
    }
    var _body = jsonEncode( {
      "koperasi_id": "",
      "pabrik_id": "8",
      "petani_id": "46",
      "tanggal_pengiriman": "2022-03-16 17:46:00",
      "tonasi": "1000",
      "user_id": "85"
    });
    try {
      final response = await client
          .post(uri, headers: headers(), body: _body)
          .timeout(const Duration(seconds: 30));
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