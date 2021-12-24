import 'dart:io';

// ignore: implementation_imports
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_status.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/api/jtk_api.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:SDZ/entity/waimai/goods_link_entity.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:SDZ/base/base_stateful_widget.dart';

/// @Author: ljx
/// @CreateDate: 2021/8/18 16:53
/// @Description: 
class WebViewPage extends BaseStatefulWidget {

   String url;

  final String title;

  String? goodsId;
  String? source;

  WebViewPage({Key? key, required this.url, required this.title,this.goodsId,this.source});

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _WebViewState();

}

class _WebViewState extends BaseStatefulState<WebViewPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

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

  void getData() {
    if(widget.goodsId == null){
      return;
    }
    Map<String, dynamic> map = Map();
    map['pub_id'] = JtkApi.pub_id;
    map['source'] = widget.source;
    map['goodsId'] = widget.goodsId;
    map['sid'] = "bld";

    ApiClient.instance.get(ApiUrl.recommend, data: map, isJTK: true,
        onSuccess: (data) {
          BaseEntity<GoodsLinkEntity> entity = BaseEntity.fromJson(data!);
          if (entity.code == ApiStatus.JTKSUCCESS && entity.data != null) {
            widget.url = entity.data?.url??'';
            setState(() {
            });
          }else{
          }
          setState(() {});

        });
  }

}