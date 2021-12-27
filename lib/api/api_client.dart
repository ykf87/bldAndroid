import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/foundation.dart';
import 'package:SDZ/api/response_interceptor.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/env.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/utils/device_util.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/utils/loading_util.dart';
import 'package:SDZ/utils/login_util.dart';
import 'package:SDZ/utils/package_util.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/wf_log_util.dart';

import 'api_status.dart';
import 'api_url.dart';

class ApiClient {
  factory ApiClient() => getInstance();

  static ApiClient get instance => getInstance();

  static late ApiClient _instance;
  static bool _isInstanceCreated = false;

  static Dio? _dio;

  ApiClient._internal() {
    if (_isInstanceCreated == false) {
      var options = BaseOptions(
        baseUrl: ApiUrl.getJTKBaseUrl(),
        connectTimeout: 30000,
        receiveTimeout: 30000,
      );
      _dio = Dio(options);
      bool proxySwitch = SPUtils.getProxySwitch();

      if (proxySwitch) {
        (_dio!.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (HttpClient client) {
          client.findProxy = (uri) {
            //proxy all request to localhost:8888
            // return "PROXY 192.168.1.113:8888";
            return "PROXY " + SPUtils.getProxyIp() + ":8888";
          };
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        };
      }

      // _dio?.interceptors.add(RequestInterceptor());
      _dio?.interceptors.add(ResponseInterceptor());
    }
  }

  static ApiClient getInstance() {
    if (_isInstanceCreated == false) {
      _instance = ApiClient._internal();
    }
    _isInstanceCreated = true;
    return _instance;
  }

  /// post
  /// url 请求地址
  /// data 请求参数(可选)
  /// loading 是否显示加载提示(可选)
  Future getReturn(String url,
      {Map<String, dynamic>? data, bool loading = false}) async {
    if(loading) {
      LoadingUtil().show();
    }
    try{
      Response response = await _dio!.get(url,
          queryParameters:
          data != null ? data as Map<String, dynamic> : Map());
      if(loading) {
        LoadingUtil().dismiss();
      }
      return response.data;
    } on DioError catch(e){
      if(loading) {
        LoadingUtil().dismiss();
      }
    }
  }

  post<T>(String url,
      {T? data,
      Function(T data)? onSuccess,
      Function(String msg)? onError,
      bool loading = false,
      bool isJTK = false}) async {
    request<T>(url,
        data: data,
        method: 'POST',
        onSuccess: onSuccess,
        onError: onError,
        loading: loading,
        isJTK: isJTK);
  }

  get<T>(String url,
      {T? data,
      Function(T data)? onSuccess,
      Function(String msg)? onError,
      bool loading = false,
      bool isJTK = false}) async {
    request<T>(url,
        data: data,
        method: 'GET',
        onSuccess: onSuccess,
        onError: onError,
        loading: loading,
        isJTK: isJTK);
  }

  put<T>(String url,
      {T? data,
      Function(T data)? onSuccess,
      Function(String msg)? onError,
      bool loading = false,
      bool isJTK = false}) async {
    request<T>(url,
        data: data,
        method: 'PUT',
        onSuccess: onSuccess,
        onError: onError,
        loading: loading,
        isJTK: isJTK);
  }

  delete<T>(String url,
      {T? data,
      Function(T data)? onSuccess,
      Function(String msg)? onError,
      bool loading = false,
      bool isJTK = false}) async {
    request<T>(url,
        data: data,
        method: 'DELETE',
        onSuccess: onSuccess,
        onError: onError,
        loading: loading,
        isJTK: isJTK);
  }

  static request<T>(String url,
      {String method = 'POST',
      T? params,
      T? data,
      Function(T data)? onSuccess,
      Function(String msg)? onError,
      bool loading = false,
      bool isJTK = false}) async {
    if (loading) {
      LoadingUtil().show(loadingText: '加载中...');
    }
    try {
      _dio!.options.method = method;
      _dio!.options.headers = {
        // 'os': (defaultTargetPlatform == TargetPlatform.android
        //         ? 'Android'
        //         : 'ios') +
        //     '-${await DeviceUtil.platformVersion}',
        'device': await Env.getDeivceName(),
        // 'app_version': 'wefree-${await PackageUtil.version}',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        // 'app_store': Env.getChannelName(),
        // 'mac': '',
        'device_id': SPUtils.getDeviceId(),
        'Authorization': SPUtils.getUserToken(),
        // 'User-Agent': FkUserAgent.userAgent!
      };

      Response? response;
      if (method == 'POST') {
        response = await _dio!.post(url,
            queryParameters:
                params != null ? params as Map<String, dynamic> : Map(),
            data: data);
      }
      if (method == 'GET') {
        response = await _dio!.get(url,
            queryParameters:
                data != null ? data as Map<String, dynamic> : Map());
      }
      if (method == 'PUT') {
        response = await _dio!.put(url,
            queryParameters:
                params != null ? params as Map<String, dynamic> : Map(),
            data: data);
      }
      if (method == 'DELETE') {
        response = await _dio!.delete(url,
            queryParameters:
                params != null ? params as Map<String, dynamic> : Map(),
            data: data);
      }

      if (loading) {
        LoadingUtil().dismiss();
      }
      if (isJTK) {}

      if (response?.statusCode == HttpStatus.ok) {
        if (response?.data['code'] ==
            (isJTK ? ApiStatus.JTKSUCCESS : ApiStatus.SUCCESS)) {
          onSuccess?.call(response?.data);
        } else if (response?.data['code'] == ApiStatus.LOGIN_OUT) {
          ToastUtils.toast(response?.data['msg'] ?? "");
          EventBusUtils.getInstance()
              .fire(LoginEvent(LoginEvent.LOGIN_TYPE_LOGINOUT));
          LoginUtil.tokenLoginOut();
        } else {
          if (onError != null) {
            onError.call(response?.data['msg']);
          } else {
            ToastUtils.toast(response?.data['msg'] ?? "");
          }
        }
      } else {
        if (onError != null) {
          onError.call(response!.statusMessage!);
        } else {
          ToastUtils.toast("【statusCode:】${response?.statusCode}");
        }
      }
    } on DioError catch (e) {
      if (loading) {
        LoadingUtil().dismiss();
      }

      print(e.toString());

      if (e.response == null) {
        if (onError != null) {
          onError.call('网络开了个小差~~');
        } else {
          ToastUtils.toast("网络开了个小差~~");
        }
        return;
      }

      if (e.response!.statusCode == 401) {
        LoginUtil.toLogin();
        return;
      }

      if (onError != null) {
        onError.call(e.message);
      } else {
        if (e.message == null) {
          ToastUtils.toast("网络开了个小差~~");
        } else {
          ToastUtils.toast(e.toString());
        }
      }
    }
  }
}
