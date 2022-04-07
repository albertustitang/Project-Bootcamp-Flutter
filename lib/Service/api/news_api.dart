import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:taniku/Service/local/shared_pref_service.dart';
import 'package:taniku/Model/response_news_model.dart';



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

}