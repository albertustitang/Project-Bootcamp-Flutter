import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:taniku/Model/response_login_model.dart';
import 'package:taniku/Model/response_profile_model.dart';
import 'package:taniku/Service/api/profile_api.dart';
import 'package:taniku/Model/response_listkebun_model.dart';




class ProfileViewModel extends ChangeNotifier{
  final _profileApi = ProfileApi();

  DataProfile dataProfile = new DataProfile();
  List<DataKebun> listKebun = [];

  ProfileViewModel(BuildContext context){
    getListProfile(context);
    getListKebun(context);
  }

  void getListProfile(BuildContext context) async {
    final response = await _profileApi.getListProfile(context);
    if (response.error == null) {
      if(response.isSuccess == true) {
        dataProfile = response.data!;
        print(jsonEncode(dataProfile));
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }

  void getListKebun(BuildContext context) async {
    final response = await _profileApi.getListKebun(context);
    if (response.error == null) {
      if(response.isSuccess == true) {
        listKebun = response.data!;
        print(jsonEncode(listKebun));
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }

}