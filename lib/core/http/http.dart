import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:SDZ/core/utils/path.dart';
import 'package:SDZ/utils/wf_log_util.dart';

class XHttp {
  XHttp._internal();

  ///网络请求配置
  static final Dio dio = Dio(BaseOptions(
    baseUrl: "https://www.wanandroid.com",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));

  ///初始化dio
  static void init() {
    ///初始化cookie
    PathUtils.getDocumentsDirPath().then((value) {
      var cookieJar =
          PersistCookieJar(storage: FileStorage(value + "/.cookies/"));
      dio.interceptors.add(CookieManager(cookieJar));
    });

    //添加拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
      WFLogUtil.d("请求之前");
      return handler.next(options);
    }, onResponse: (Response response, handler) {
      WFLogUtil.d("响应之前");
      return handler.next(response);
    }, onError: (DioError e, handler) {
      WFLogUtil.d("错误之前");
      handleError(e);
      return handler.next(e);
    }));
  }

  ///error统一处理
  static void handleError(DioError e) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
        WFLogUtil.d("连接超时");
        break;
      case DioErrorType.sendTimeout:
        WFLogUtil.d("请求超时");
        break;
      case DioErrorType.receiveTimeout:
        WFLogUtil.d("响应超时");
        break;
      case DioErrorType.response:
        WFLogUtil.d("出现异常");
        break;
      case DioErrorType.cancel:
        WFLogUtil.d("请求取消");
        break;
      default:
        WFLogUtil.d("未知错误");
        break;
    }
  }

  ///get请求
  static Future get(String url, [Map<String, dynamic>? params]) async {
    Response response;
    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    return response.data;
  }

  ///post 表单请求
  static Future post(String url, [Map<String, dynamic>? params]) async {
    Response response = await dio.post(url, queryParameters: params);
    return response.data;
  }

  ///post body请求
  static Future postJson(String url, [Map<String, dynamic>? data]) async {
    Response response = await dio.post(url, data: data);
    return response.data;
  }

  ///下载文件
  static Future downloadFile(urlPath, savePath) async {
    Response? response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        WFLogUtil.d("$count $total");
      });
    } on DioError catch (e) {
      handleError(e);
    }
    return response!.data;
  }
}
