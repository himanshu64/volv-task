import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:volv/core/db/shared_prefs.dart';
import 'package:volv/core/services/home_service.dart';
import 'package:volv/core/utils/gretting_message.dart';
import 'package:volv/core/viewmodels/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  late HomeService _homeService;
  var data = '';
  String name = '';
  String email = '';
  String mobile = '';
  List<Map<String, dynamic>> dataList = [];
  Future<void> initialise() async {
    _homeService = HomeService();
    
    callApi();
  }

  getResponse() async {
    Map response = await _homeService.getResponse();
    _dynamicJsonWithKeysToList(response);
  }

  void callApi() async {
    busy = true;
    name  = await MySharedPreferences.instance.getStringValue('name');
    email = await MySharedPreferences.instance.getStringValue('email');
    mobile = await MySharedPreferences.instance.getStringValue('mobile');
    await getResponse();

    notifyListeners();
  }

  String showGreeting() {
    return greetingMessage();
  }

  void _dynamicJsonWithKeysToList(dynamic jsonData) {
    List<Map<String, dynamic>> _dataList = [];
    int counter = 0;

    jsonData.forEach((key, value) {
      if (jsonData[key] is List) {
        //if((json[key] as List).length>0){
        // print(
        //     '--counter:${counter++}--key:$key:::::value::>>$value----jsonKey:${jsonData[key]}');
        _innerJsonList(_dataList, "$key", jsonData[key]);
      } else {
        _dataList.add(jsonData[key]);
      }
    });
    
    print('----finalData:$_dataList');
    dataList = _dataList;
     busy = false;
    
  }

  void _innerJsonMapData(List<Map<String, dynamic>> _dataList, String parentKey,
      Map<String, dynamic> innerJson) {
    for (var key in innerJson.keys) {
      if (innerJson[key] is Map) {
        // print(
        //     '-innerMap--parentKey:"$parentKey", innerJsonKey:${innerJson[key]}---dataList:$dataList');
        _innerJsonMapData(dataList, "$parentKey[$key]", innerJson[key]);
      } else if (innerJson[key] is List) {
        //else if((innerJson[key] as List).length>0){
        // print(
        //     '-innerMapList--parentKey:"$parentKey", innerJsonKey:${innerJson[key]}---dataList:$dataList');
        _innerJsonList(_dataList, "$parentKey[$key]", innerJson[key]);
      } else {
        _dataList.add({key: innerJson[key]});
      }
    }
 
  }

  void _innerJsonList(List<Map<String, dynamic>> _dataList, String parentKey,
      List<dynamic> innerList) {
    int counter = 0;
    for (var mapItem in innerList) {
      if (mapItem is Map) {
        // print(
        //     '-Map>>>>-counter:${counter++}-parentKey:$parentKey[]---item:$mapItem---queryList:$dataList');
        _innerJsonMapData(
            _dataList, "$parentKey[]", mapItem as Map<String, dynamic>);
      } else {
        _dataList.add(mapItem);
      }
    }
    
  }

  
}
