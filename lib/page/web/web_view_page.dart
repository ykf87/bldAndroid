import 'dart:io';

// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:SDZ/base/base_stateful_widget.dart';

/// @Author: ljx
/// @CreateDate: 2021/8/18 16:53
/// @Description: 
class WebViewPage extends BaseStatefulWidget {
   String url;
   String title;
  WebViewPage({Key? key, required this.url,required this.title});

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _WebViewState();

}

class _WebViewState extends BaseStatefulState<WebViewPage> {

  WebViewController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void initData() {
    super.initData();
    if (Platform.isAndroid){
      WebView.platform = SurfaceAndroidWebView();
    }

  }
  //发送给web
  void sendMessage(){
    controller?.evaluateJavascript('flutterCallJsMethod("msg from flutter")');
  }

  //Flutter 接收web消息
  JavascriptChannel _jsChannel(BuildContext context) => JavascriptChannel(
      name: 'appobject',
      onMessageReceived: (JavascriptMessage message) {
        print("前端交互: ${message.message}");
      });

  @override
  String navigatorTitle() => widget.title;

  @override
  Widget initDefaultBuild(BuildContext context) {

    return WebView(
        javascriptChannels:[_jsChannel(context)].toSet() ,
//  initialUrl: 'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(htmlString))}', //加载本地html

      onWebViewCreated: (WebViewController webViewController) {
        controller = webViewController;
        // _controller.complete(webViewController);
      },
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      onPageStarted: (url){

      },
      onPageFinished: (url){

      },
      gestureNavigationEnabled: true,
    );
  }

}