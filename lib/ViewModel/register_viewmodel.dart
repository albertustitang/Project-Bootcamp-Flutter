import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taniku/Service/api/register_api.dart';
import 'package:taniku/Service/local/shared_pref_service.dart';


class RegisterViewModel extends ChangeNotifier{
  final _registerApi = RegisterApi();
  final _sharedPref = SharedPreferenceService();
  bool hidePassword = false;


  RegisterViewModel(BuildContext){}
  void register(String username, String mobilephone, String password, String confirmpassword, BuildContext context) async {
    final response = await _registerApi.register(username, mobilephone, password, confirmpassword, context);
    if (response.error == null) {
      if(response.isSuccess == true) {
        print(response.message.toString());
        print('Register Berhasil');
      } else {
        print('gagal');
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }
}