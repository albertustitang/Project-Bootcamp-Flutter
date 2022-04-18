import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taniku/Model/response_pengiriman_model.dart';
import 'package:taniku/Service/local/shared_pref_service.dart';

class PengirimanApi {
  var client = http.Client();
  var baseUrl = "http://34.126.79.39:81/";

  Future<PengirimanModel> getListPengiriman (BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/reservasi/getAll").replace();
    final tokenLocal = await SharedPreferenceService().getStringSharedPref("token");
    final petaniIdLocal = await SharedPreferenceService().getStringSharedPref("petani_id");
    final userIdLocal = await SharedPreferenceService().getStringSharedPref("user_id");
    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer OTE0YmNjNGFhZjhiNTRiMGMzMjAyMjg1YjBhZmM0MzQ5YjViNDhhZg=='
      };
    }
    var _body = jsonEncode({
      'orderBy': "id",
      'petani_id': petaniIdLocal,
      'type_user': "PTN",
      'sort': "desc", //sort by "asc" or "desc"//
      'page': "1",
      'user_id': 85,
      'status':"",
    });
    print(tokenLocal);
    print(_body);
    try {
      final response = await client
          .post(uri, headers: headersToken(tokenLocal), body: _body)
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return PengirimanModel.fromJson(jsonDecode(response.body));
      } else {
        return PengirimanModel.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return PengirimanModel.withError("Waktu Habis, Silahkan Coba Kembali");
    }

  }
}