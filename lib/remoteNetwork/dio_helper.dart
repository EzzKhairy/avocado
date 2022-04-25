import 'package:dio/dio.dart';

class DioHelper
{
  static Dio ?dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://gg-new-api-avo.herokuapp.com/public/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Accept':'application/json',
          'Content-Type':'application/json',
        }
      ),
    );
  }

  static Future<Response> getData({
    required url,
    Map<String, dynamic>? query,
}) async
  {
    dio!.options.headers = {
      'Accept':'application/json',
      'Content-Type':'application/json',
      };
    return await dio!.get(
        url,
        queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
})async
  {
    dio!.options.headers = {
      'Accept' : 'application/json',
      'Content-Type':'application/json',

    };

    return dio!.post(
      url,
      data: data,
    );
  }
}