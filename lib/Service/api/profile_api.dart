import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taniku/Service/local/shared_pref_service.dart';

import '../../Model/response_listkebun_model.dart';
import '../../Model/response_profile_model.dart';


class ProfileApi {
  var client = http.Client();
  var baseUrl = "http://34.126.79.39:81/";

  Future<ProfileModel> getListProfile(BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/profile/getProfile").replace();
    final tokenLocal = await SharedPreferenceService().getStringSharedPref("token");
    final user =await SharedPreferenceService().getStringSharedPref("user_id");

    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    var _body = jsonEncode({
      'user_id' : user

    });
    print(tokenLocal);
    print(_body);
    try {
      final response = await client
          .post(uri, headers: headersToken(tokenLocal), body: _body)
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return ProfileModel.fromJson(jsonDecode(response.body));
      } else {
        return ProfileModel.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return ProfileModel.withError("Waktu Habis, Silahkan Coba Kembali");
    }
  }

  Future<ListKebun> getListKebun(BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/kebun/getKebun").replace();
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
      "orderBy": "id",
      "petani_id": petaniIdLocal,
      "sort": "asc",
      "user_id": userIdLocal,
    });
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

}