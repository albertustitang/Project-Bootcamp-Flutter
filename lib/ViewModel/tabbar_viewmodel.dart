import 'package:flutter/material.dart';
import '../Model/response_addkebun_model.dart';
import '../Service/api/kebun_api.dart';

class TabViewModel extends ChangeNotifier{
  final _kebunApi = KebunApi();
  AddKebunModel addKebunModel = AddKebunModel();

  void addKebun(BuildContext context) async {
    final response = await _kebunApi.addKebun(addKebunModel, context);
    print(response);
    notifyListeners();
  }
}