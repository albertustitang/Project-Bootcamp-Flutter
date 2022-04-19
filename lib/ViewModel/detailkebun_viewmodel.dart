import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:taniku/Model/response_listkebun_model.dart';
import 'package:taniku/Model/response_listdokumen_model.dart';
import 'package:taniku/Service/api/news_api.dart';
import 'package:taniku/Model/response_listsertifikat_model.dart';
import 'package:taniku/Service/local/shared_pref_service.dart';


class ViewModelDetailKebun extends ChangeNotifier{
  final _listApi = NewsApi();
  List<DataKebun> dataDetailKebun = [];
  List<DataDocument> dataDocument= [];
  List<DataSertif> dataSertif = [];
  final _sharedPref = SharedPreferenceService();

  ViewModelDetailKebun(BuildContext context, String kebun_id){
    getListRepositoryDetailKebun(context, kebun_id);
    getListRepositoryDocument(context, kebun_id);
    getListRepositorySertifikat(context, kebun_id);
  }

  void getListRepositoryDetailKebun(BuildContext context, String kebun_id) async {
    final response = await _listApi.getListRepositoryDetailKebun(context, kebun_id);
    if (response.error == null) {
      if(response.isSuccess == true) {
        dataDetailKebun = response.data!;
        print(jsonEncode(dataDetailKebun));
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }

  void getListRepositoryDocument(BuildContext context, String kebun_id) async {
    final response = await _listApi.getListRepositoryDocument(context, kebun_id);
    if (response.error == null) {
      if(response.isSuccess == true) {
        dataDocument = response.data!;
        print(jsonEncode(dataDetailKebun));
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }

  void getListRepositorySertifikat(BuildContext context, String kebun_id) async {
    final response = await _listApi.getListRepositorySertifikat(context, kebun_id);
    if (response.error == null) {
      if(response.isSuccess == true) {
        dataSertif = response.data!;
        print(jsonEncode(dataDetailKebun));
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }

}