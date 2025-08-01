import 'package:dio/dio.dart';

abstract class HttpMethods {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
}

class HttpManager {

  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {

    final defaultHeaders = headers?.cast<String, String>() ?? {} ..addAll({
      'content-type': 'application/json',
      'accept': 'application/json',
      'X-Parse-Application-Id': 'g1Oui3JqxnY4S1ykpQWHwEKGOe0dRYCPvPF4iykc',
      'X-Parse-REST-API-Key': 'rFBKU8tk0m5ZlKES2CGieOaoYz6TgKxVMv8jRIsN',
    });

    Dio dio = Dio();

    try {
      Response response = await dio.request(
        url,
        options: Options(
          headers: defaultHeaders,
          method: method
        ),
        data: body,
      );

      print('${response.data}, kkk');

      return response.data;

    } on DioError catch (error) {
      print('$error, error1');
      return error.response?.data ?? {};
    }catch (error){
      print('$error, error2');
      return {};
    }
  }
}