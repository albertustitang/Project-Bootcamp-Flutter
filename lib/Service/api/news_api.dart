import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:taniku/Service/local/shared_pref_service.dart';
import 'package:taniku/Model/response_news_model.dart';

import '../../Model/response_listdetail_model.dart';
import '../../Model/response_listdokumen_model.dart';
import '../../Model/response_listkebun_model.dart';
import '../../Model/response_listsertifikat_model.dart';
import '../../Model/response_transaksi_model.dart';



class NewsApi {
  var client = http.Client();
  var baseUrl = "http://34.126.79.39:81/";

  Future<NewsModel> getListNews(BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/news").replace();
    final tokenLocal = await SharedPreferenceService().getStringSharedPref("token");
    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    var _body = jsonEncode({});
    print(tokenLocal);
    print(_body);
    try {
      final response = await client
          .post(uri, headers: headersToken(tokenLocal), body: _body)
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return NewsModel.fromJson(jsonDecode(response.body));
      } else {
        return NewsModel.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return NewsModel.withError("Waktu Habis, Silahkan Coba Kembali");
    }
  }



Future<ListKebun> getListKebun(BuildContext context) async {
  var uri = Uri.parse(baseUrl + "api/niaga/kebun/getKebun").replace();
  // final tokenLocal = await SharedPreferenceService().getStringSharedPref(
  //     "token");
  final tokenLocal = "OTE0YmNjNGFhZjhiNTRiMGMzMjAyMjg1YjBhZmM0MzQ5YjViNDhhZg==";
  final petaniIdLocal = "46";
  final userIdLocal = "85";

  Map<String, String> headersToken(String token) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }
  var _body = jsonEncode({
    "orderBy": "id",
    "petani_id": "46",
    "sort": "asc",
    "user_id": "85"
  });
  print(tokenLocal);
  print(_body);
  try {

    final response = await client
        .post(uri, headers: headersToken(tokenLocal), body: _body)
        .timeout(const Duration(seconds: 30));
    print(response.body);
    if (response.statusCode == HttpStatus.ok) {
      return ListKebun.fromJson(jsonDecode(response.body));
    } else {
      return ListKebun.withError("Gagal Load Data");
    }
  } on TimeoutException catch (_) {
    return ListKebun.withError("Waktu Habis, Silahkan Coba Kembali");
  }
}
  Future<ListDetail> getListRepositoryDetailKebun(BuildContext context, String kebun_id) async {
    var uri = Uri.parse(baseUrl + "api/niaga/kebun/findOneKebun").replace();
    // final tokenLocal = "MjZhYWNiMDE4YzlmYmFmYmIxMjgzNzgyZGFiMTM2NzVlOTQ0MTVkNQ==";
    final tokenLocal = "OTE0YmNjNGFhZjhiNTRiMGMzMjAyMjg1YjBhZmM0MzQ5YjViNDhhZg==";
    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    var _body = jsonEncode({
      "user_id": "85",
      "kebun_id": kebun_id
    });
    // print(_body);
    try {
      final response = await client
          .post(uri, headers: headersToken(tokenLocal), body: _body)
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return ListDetail.fromJson(jsonDecode(response.body));
      } else {
        return ListDetail.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return ListDetail.withError("Waktu Habis, Silahkan Coba Kembali");
    }
  }
  Future<ListDokumen> getListRepositoryDocument(BuildContext context, String kebun_id) async {
    var uri = Uri.parse(baseUrl + "api/niaga/kebun/getKebunSertifikat").replace();
    // final tokenLocal = "MjZhYWNiMDE4YzlmYmFmYmIxMjgzNzgyZGFiMTM2NzVlOTQ0MTVkNQ==";
    final tokenLocal = "OTE0YmNjNGFhZjhiNTRiMGMzMjAyMjg1YjBhZmM0MzQ5YjViNDhhZg==";
    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    var _body = jsonEncode({
      "orderBy": "nomor",
      "sort": "asc",
      "user_id": "85",
      "kebun_id": kebun_id
    });
    print(_body);
    try {
      final response = await client
          .post(uri, headers: headersToken(tokenLocal), body: _body)
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return ListDokumen.fromJson(jsonDecode(response.body));
      } else {
        return ListDokumen.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return ListDokumen.withError("Waktu Habis, Silahkan Coba Kembali");
    }
  }

  Future<ListSertifikat> getListRepositorySertifikat(BuildContext context, String kebun_id) async {
    var uri = Uri.parse(baseUrl + "api/niaga/kebun/getSertifikatList").replace();
    // final tokenLocal = "MjZhYWNiMDE4YzlmYmFmYmIxMjgzNzgyZGFiMTM2NzVlOTQ0MTVkNQ==";
    final tokenLocal = "OTE0YmNjNGFhZjhiNTRiMGMzMjAyMjg1YjBhZmM0MzQ5YjViNDhhZg==";
    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    var _body = jsonEncode({
      "orderBy": "nomor",
      "sort": "asc",
      "user_id": "85",
      "kebun_id": kebun_id
    });
    print(_body);
    try {
      final response = await client
          .post(uri, headers: headersToken(tokenLocal), body: _body)
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return ListSertifikat.fromJson(jsonDecode(response.body));
      } else {
        return ListSertifikat.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return ListSertifikat.withError("Waktu Habis, Silahkan Coba Kembali");
    }
  }

  Future<TransaksiModel> getListRepositoryTransaksi(BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/pabrik/getPabrik").replace();
    final tokenLocal = "OTE0YmNjNGFhZjhiNTRiMGMzMjAyMjg1YjBhZmM0MzQ5YjViNDhhZg==";
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
      "user_id": "85" });
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
