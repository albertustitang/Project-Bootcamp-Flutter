import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Model/response_transaksi_model.dart';
import '../local/shared_pref_service.dart';

class TransaksiApi {
  var client = http.Client();
  var baseUrl = "http://34.126.79.39:81/";

  Future<TransaksiModel> getListRepositoryTransaksi(BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/pabrik/getPabrik").replace();
    final tokenLocal = await SharedPreferenceService().getStringSharedPref("token");
    final petaniIdLocal = await SharedPreferenceService().getStringSharedPref("petani_id");
    final userIdLocal = await SharedPreferenceService().getStringSharedPref("user_id");
    // final tokenLocal = "OTE0YmNjNGFhZjhiNTRiMGMzMjAyMjg1YjBhZmM0MzQ5YjViNDhhZg==";
    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    var _body = jsonEncode({
      "jarak_maksimum": "1000000000000",
      "jarak_minimum": "0",
      "latitude": "20.149",
      "longitude": "77.49",
      "orderBy": "jarak_pabrik",
      "sort": "desc",
      "user_id": userIdLocal
    });
    print(_body);
    try {
      final response = await client
          .post(uri, headers: headersToken(tokenLocal), body: _body)
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return TransaksiModel.fromJson(jsonDecode(response.body));
      } else {
        return TransaksiModel.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return TransaksiModel.withError("Waktu Habis, Silahkan Coba Kembali");
    }
  }
}