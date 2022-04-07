import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Model/response_register_model.dart';

class RegisterApi {
  var client = http.Client();
  var baseUrl = "http://34.126.79.39:81/";

  Future<ResponseRegisterModel> register(String username, String mobilephone, String password, String confirmpassword, BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/auth/register").replace();
    Map<String, String> headers() {
      return {'Content-Type': 'application/json', 'Accept': 'application/json'};
    }
    var _body = jsonEncode({
      'type_user' : 'PTN',
      'username': username,
      'mobile': mobilephone,
      'password': password,
      'confirm_password': confirmpassword,
    });
    try {
      final response = await client
          .post(uri, headers: headers(), body: _body)
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == HttpStatus.ok) {
        return ResponseRegisterModel.fromJson(jsonDecode(response.body));
      } else {
        return ResponseRegisterModel.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return ResponseRegisterModel.withError("Waktu Habis, Silahkan Coba Kembali");
    }
  }

}