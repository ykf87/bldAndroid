import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:SDZ/env.dart';
import 'package:SDZ/utils/wf_log_util.dart';

import 'api_status.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (Env.requestLogLevel == RequestLogLevel.RequestLogLevel_FullLog) {
      WFLogUtil.d('请求参数开始=================================>');
      WFLogUtil.d('base_url====>${response.requestOptions.baseUrl}');
      WFLogUtil.d('path====>${response.requestOptions.path}');
      WFLogUtil.d('method====>${response.requestOptions.method}');
      WFLogUtil.d('header====>${json.encode(response.requestOptions.headers)}');
      if (response.requestOptions.method == 'GET') {
        WFLogUtil.d('params====>${response.requestOptions.queryParameters}');
      } else {
        WFLogUtil.d('params====>${json.encode(response.requestOptions.data)}');
      }
      WFLogUtil.d('请求参数结束=================================>');
      WFLogUtil.d('接口返回开始=================================>');
      WFLogUtil.d('path====>${response.requestOptions.path}');
      WFLogUtil.d('data====>${json.encode(response.data)}');
      WFLogUtil.d('接口返回结束=================================>');
    } else if (Env.requestLogLevel == RequestLogLevel.RequestLogLevel_UrlLog) {
      WFLogUtil.d('base_url====>${response.requestOptions.baseUrl}');
    } else if (Env.requestLogLevel ==
        RequestLogLevel.RequestLogLevel_Url_Data_log) {
      WFLogUtil.d('base_url====>${response.requestOptions.baseUrl}');
      WFLogUtil.d('data====>${json.encode(response.data)}');
    }

    ///把接口返回数据转换map
    if (response.data is String) {
      Map<String, dynamic> map = json.decode(response.data);
      response.data = map;
    } else {
      response.data = new Map<String, dynamic>.from(response.data);
    }

    ///拦截器中直接弹错误toast
    // if(response.data['code'] != ApiStatus.SUCCESS) {
    //   // DioError dioError = DioError();
    //   // dioError.requestOptions = response.requestOptions;
    //   // dioError.response = response;
    //   // dioError.error = map['errMsg'];
    //   // return handler.reject(dioError);
    //   return handler.resolve(response);
    // }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (Env.requestLogLevel == RequestLogLevel.RequestLogLevel_FullLog) {
      WFLogUtil.d('接口错误开始=================================>');
      WFLogUtil.d('err.message====>${err.message}');
      WFLogUtil.d('base_url====>${err.requestOptions.baseUrl}');
      WFLogUtil.d('path====>${err.requestOptions.path}');
      WFLogUtil.d('method====>${err.requestOptions.method}');
      WFLogUtil.d('header====>${json.encode(err.requestOptions.headers)}');
      WFLogUtil.d('params====>${json.encode(err.requestOptions.data)}');
      WFLogUtil.d('response====>${json.encode(err.response!.data)}');
      WFLogUtil.d('接口错误结束=================================>');
    } else if (Env.requestLogLevel == RequestLogLevel.RequestLogLevel_UrlLog ||
        Env.requestLogLevel == RequestLogLevel.RequestLogLevel_Url_Data_log) {
      WFLogUtil.d('接口错误：response====>${json.encode(err.response!.data)}');
    }

    return super.onError(err, handler);
  }
}
