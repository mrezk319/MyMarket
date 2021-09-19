import 'package:dio/dio.dart';
import 'package:shop_app_2/shared/components/constance.dart';
class DioHelper{
  static late Dio dio;
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true
      ),
    );
  }


  static Future<Response> postData({required String path,required Map<String,dynamic> data, String Token =''}){
    dio.options.headers = {
      'lang':'en',
      'Content-Type' : 'application/json',
      'Authorization' : Token,
    };
   return dio.post(path,data: data);
  }
  static Future<Response> putData({required String path,required Map<String,dynamic> data, required String Token}){
    dio.options.headers = {
      'lang':'en',
      'Content-Type' : 'application/json',
      'Authorization' : Token,
    };
    return dio.put(path,data: data);
  }
  static Future<Response> getData({required String path,required String Token,Map<String,dynamic>? data}){
    dio.options.headers = {
      'lang':'en',
      'Content-Type' : 'application/json',
      'Authorization' : Token,
    };
    return dio.get(path,queryParameters: data);
  }

}