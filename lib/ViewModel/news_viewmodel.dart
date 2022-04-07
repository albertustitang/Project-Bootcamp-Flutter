import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:taniku/Model/response_news_model.dart';
import 'package:taniku/Service/api/news_api.dart';



class NewsViewModel extends ChangeNotifier{
  final _newsApi = NewsApi();
  List<DataNews> listNews = [];

  NewsViewModel(BuildContext context){
    getListNews(context);
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

}