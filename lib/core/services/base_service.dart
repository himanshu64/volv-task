import 'package:volv/core/services/dio_client.dart';

class BaseService {
  late DioClient dioClient ;
  BaseService(){
  dioClient =  DioClient();
  }
}