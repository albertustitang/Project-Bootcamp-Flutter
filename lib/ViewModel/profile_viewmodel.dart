import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:taniku/Model/response_profile_model.dart';
import 'package:taniku/Model/response_profile_model.dart';

import 'package:taniku/Service/api/profile_api.dart';



class ProfileViewModel extends ChangeNotifier{
  final _profileApi = ProfileApi();
  DataProfile dataProfile = new DataProfile();

  ProfileViewModel(BuildContext context){
    getListProfile(context);
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

}