
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:SDZ/utils/device_util.dart';
import 'package:SDZ/utils/package_util.dart';
import 'package:SDZ/utils/sputils.dart';

class RequestInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Map<String, dynamic> params = await addCommonParams(options.data);
    if(options.method == 'GET' && options.data != null) {
      options.queryParameters = options.data;
    }
    if(options.method == 'POST') {
      // options.data = FormData.fromMap(options.data);
    }
    // print('请求参数开始=================================>');
    // print('base_url====>${options.baseUrl}');
    // print('path====>${options.path}');
    // print('header====>${options.headers}');
    // if(options.method == 'GET') {
    //   print('params====>${options.queryParameters}');
    // }
    // if(options.method == 'POST') {
    //   print('params====>${options.data}');
    // }
    // print('请求参数结束=================================>');
    return super.onRequest(options, handler);
  }
}