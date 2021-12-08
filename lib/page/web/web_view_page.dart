import 'dart:io';

// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:SDZ/base/base_stateful_widget.dart';

/// @Author: ljx
/// @CreateDate: 2021/8/18 16:53
/// @Description: 
class WebViewPage extends BaseStatefulWidget {

  final String url;

  final String title;

  WebViewPage({Key? key, required this.url, required this.title});

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _WebViewState();

}

class _WebViewState extends BaseStatefulState<WebViewPage> {

  @override
  void initData() {
    super.initData();
    if (Platform.isAndroid){
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  String navigatorTitle() => widget.title;

  @override
  Widget initDefaultBuild(BuildContext context) {

    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

}