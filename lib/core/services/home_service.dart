import 'dart:convert';


import 'package:volv/core/services/base_service.dart';
import 'package:volv/core/services/dio_client.dart';

class HomeService extends BaseService {
  

  
   Future getResponse() async {
    try {
      // final res = await DioClient.get("/");;
      final res = await dioClient.get('/');

      return res;
    } catch (e) {
      throw e.toString();
    }
  }
}
