import 'dart:async';
import 'dart:io';

// ignore: implementation_imports
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/event/ad_reward_event.dart';
import 'package:SDZ/utils/CSJUtils.dart';
import 'package:SDZ/utils/VideoUtils.dart';
import 'package:SDZ/utils/YLHUtils.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:SDZ/base/base_stateful_widget.dart';

/// @Author: ljx
/// @CreateDate: 2021/8/18 16:53
/// @Description:
class WebViewPage extends BaseStatefulWidget {
  String url;
  String title;

  WebViewPage({Key? key, required this.url, required this.title});

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _WebViewState();
}

class _WebViewState extends BaseStatefulState<WebViewPage> {
  WebViewController? controller;
  StreamSubscription<MyAdRewardEvent>? adRewardEventBus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adRewardEventBus =
        EventBusUtils.getInstance().on<MyAdRewardEvent>().listen((event) {
      sendMessage();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    adRewardEventBus?.cancel();
  }

  @override
  void initData() {
    super.initData();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  //发送给web
  void sendMessage() {
    controller?.evaluateJavascript('videoDone()');
  }

  //Flutter 接收web消息
  JavascriptChannel _jsChannel(BuildContext context) => JavascriptChannel(
      name: 'appobject',
      onMessageReceived: (JavascriptMessage message) {
        if (message.message.contains("1")) {
          CSJUtils.showRewardVideoAd();
        } else if (message.message.contains("2")) {
          YLHUtils.showReword();
        } else if (message.message.contains("3")) {
          VideoUtils.loadVoiceAd((logId) {
            sendMessage();
          }, type: 'default', tid: '');
        }
      });

  @override
  String navigatorTitle() => widget.title;

  @override
  Widget initDefaultBuild(BuildContext context) {
    return WebView(
      javascriptChannels: [_jsChannel(context)].toSet(),
//  initialUrl: 'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(htmlString))}', //加载本地html

      onWebViewCreated: (WebViewController webViewController) {
        controller = webViewController;
        // _controller.complete(webViewController);
      },
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      onPageStarted: (url) {},
      onPageFinished: (url) {},
      gestureNavigationEnabled: true,
    );
  }
}
