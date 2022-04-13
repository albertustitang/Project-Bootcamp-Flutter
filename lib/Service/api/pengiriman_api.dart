import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taniku/Model/response_pengiriman_model.dart';
import '../../Model/response_transaksi_model.dart';

class PengirimanApi {
  var client = http.Client();
  var baseUrl = "http://34.126.79.39:81/";

  Future<PengirimanModel> getListRepositoryPengiriman(BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/reservasi/getAll").replace();
    final tokenLocal = "N2IyN2I0N2ZmZGU3MmE4NjgxNDhjZGZlNTA4ZGFhZTY0Zjc4YmI0Yw==";
    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    var _body = jsonEncode({
      "page": "1",
      "sort": "desc",
      "status": "",
      "type_user": "PTN",
      "user_id": "85"
    });
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