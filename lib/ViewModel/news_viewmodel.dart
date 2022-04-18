import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:taniku/Model/response_news_model.dart';
import 'package:taniku/Service/api/news_api.dart';
import 'package:taniku/Service/local/shared_pref_service.dart';
import '../Model/response_listkebun_model.dart';




class NewsViewModel extends ChangeNotifier{
  final _newsApi = NewsApi();
  // final _sharedPref = SharedPreferenceService();

  List<DataNews> listNews = [];
  List<DataKebun> listKebun = [];

  NewsViewModel(BuildContext context){
    getListNews(context);
    getListKebun(context);
  }

  void getListNews(BuildContext context) async {
    final response = await _newsApi.getListNews(context);
    if (response.error == null) {
      if(response.isSuccess == true) {
        listNews = response.data!;
        print(jsonEncode(listNews));
      } else {
        print(response.message.toString());
      }
    } else {
      print(response.error.toString());
    }
    notifyListeners();
  }
  void getListKebun(BuildContext context) async {
    final response = await _newsApi.getListKebun(context);
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