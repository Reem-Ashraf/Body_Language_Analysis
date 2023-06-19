import 'package:dio/dio.dart';
import 'package:graduation_project/model/shaerd_prefrense/shaerd_prefrense.dart';
import 'package:graduation_project/view/componant/core/constant.dart';
class DioHelper{

   static Dio? dio;
   static init(){
     dio=Dio(BaseOptions(
       baseUrl: 'http://127.0.0.1:8000/api/',
       headers: {
         'Content-Type':'application/json'
       },
       receiveDataWhenStatusError: true,
     ));
   }
   static Future<Response?> getData({
     required String url,
     Map<String,dynamic>? query,
     String lang='ar',
     String? token,
   })async{
     dio?.options.headers= {
       'Authorization': 'Bearer ${CacheHelper.getData(key: accessTokenKey)}',
     };
     print('GET => $url');
    final response =  await dio?.get(url,queryParameters: query);

     print(response!.data);
     print(response.statusCode);
     print(response.statusMessage);
    return response;
   }
   static Future<Response?>postData({
     required String url,
     Map<String,dynamic>? query,
     required Map<String,dynamic>data,
     String lang='ar',
     String? token,
   })async{
     dio?.options.headers= {
       'lang':lang,
       'Authorization': 'Bearer ${CacheHelper.getData(key: accessTokenKey)}',
     };

     final response = await dio?.post(url,queryParameters: query,data: data);

     print(response!.data);
     print(response.statusCode);
     print(response.statusMessage);
    return response;
   }
}