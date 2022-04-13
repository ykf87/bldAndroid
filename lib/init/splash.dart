import 'dart:async';
import 'dart:io';

import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/entity/Constants.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/global_entity.dart';
import 'package:SDZ/page/index.dart';
import 'package:SDZ/res/constant.dart';
import 'package:SDZ/utils/CSJUtils.dart';
import 'package:SDZ/utils/route_ainimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pangle_ads/flutter_pangle_ads.dart' as CSJ;
import 'package:flutter_qq_ads/flutter_qq_ads.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:SDZ/base/base_stateful_widget.dart';
import 'package:SDZ/constant/svg_path.dart';
import 'package:SDZ/dialog/agreement_dialog.dart';
import 'package:SDZ/dialog/alter_dialog.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/color_util.dart';
import 'package:SDZ/utils/jpush_util.dart';

import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/umeng_util.dart';
import 'package:SDZ/utils/wf_log_util.dart';
import 'package:SDZ/widget/circle_progress.dart';
import 'package:SDZ/widget/common_widgets.dart';
import 'package:SDZ/widget/double_click.dart';
import 'package:SDZ/widget/empty_appbar.dart';

//类似广告启动页
class SplashPage extends BaseStatefulWidget {
  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _SplashPageState();
}

class _SplashPageState extends BaseStatefulState<SplashPage> {
  static const COUNT = 2000;
  Timer? _timer;
  int currentTimer = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (!SPUtils.isAgreementRead) {
        showAgreementDialog();
      } else {
        if (!SPUtils.getAdShow()) {
          toMain();
        }
      }
    });
    if (SPUtils.isAgreementRead && SPUtils.getAdShow()) {
      showCSJSplashAd();
    }
    setAdEvent();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  /// 协议弹窗
  void showAgreementDialog() {
    if (SPUtils.isAgreementRead) {
      Constants.isFirstOpen = false;
      goHomePage();
      return;
    }
    Constants.isFirstOpen = true;
    Get.dialog(AgreementDialog(onTap: (type) {
      if (type == 0) {
        showAgreementConfirmDialog();
      }
      if (type == 1) {
        SPUtils.setAgreementRead(true);
        ApiClient.instance.get(ApiUrl.getBLDBaseUrl() + ApiUrl.getGlobalConfig,
            onSuccess: (data) {
          BaseEntity<GlobalEntity> entity = BaseEntity.fromJson(data!);
          SPUtils.setAdShow(entity.data?.isadv?.contains("true") ?? false);
          Constants.opensign = entity.data?.opensign == 1;
          goHomePage();
        }, onError: (msg) {
          goHomePage();
        });
      }
    }), barrierDismissible: false);
  }

  /// 协议二次确认弹窗
  void showAgreementConfirmDialog() {
    Get.dialog(
        AlterDialog(
          title: '温馨提示',
          content: '您需要同意《用户协议》及《隐私政策》才能继续使用应用，否则非常遗憾我们将无法为您提供服务。',
          cancelText: '退出APP',
          confirmText: '继续使用',
          onTap: (type) {
            if (type == 0) {
              // SystemNavigator.pop();
              exit(0);
            }
            if (type == 1) {
              showAgreementDialog();
            }
          },
        ),
        barrierDismissible: false);
  }

  @override
  bool isCustomNavigator() => true;

  @override
  PreferredSizeWidget? initCustomNavigator() => EmptyAppBar();

  @override
  Widget initDefaultBuild(BuildContext context) {
    return Container();
  }

  ///页面跳转
  void goHomePage() {
    /// 不同意协议不执行
    if (!SPUtils.isAgreementRead) {
      return;
    }
    requestPermission();
    if (SPUtils.getAdShow()) {
      FlutterQqAds.initAd(CSJUtils.YLHAPPID);
      CSJUtils.initCSJADSDK().then((value) => toMain());
    } else {
      toMain();
    }
  }

  Future<void> showCSJSplashAd() async {
    /// [posId] 广告位 id
    /// [logo] 如果传值则展示底部logo，不传不展示，则全屏展示
    /// [timeout] 加载超时时间
    /// [buttonType] 开屏广告的点击区域，1：全都可以点击 2：仅有下载 Bar 区域可以点击
    String _result = '';
    try {
      bool result = await CSJ.FlutterPangleAds.showSplashAd(
        CSJUtils.CSJSplashId,
        timeout: 3.5,
      );
      _result = "展示开屏广告${result ? '成功' : '失败'}";
      print(_result);
    } on PlatformException catch (e) {
      toMain();
      print(e.message);
    }
  }

  /// 设置广告监听
  Future<void> setAdEvent() async {
    String _adEvent = '';
    CSJ.FlutterPangleAds.onEventListener((event) {
      _adEvent = 'adId:${event.adId} action:${event.action}';
      if (event is CSJ.AdErrorEvent) {
        // 错误事件
        toMain();
      }
      // 关闭错误倒计时结束
      if ((event.action == CSJ.AdEventAction.onAdClosed ||
              event.action == CSJ.AdEventAction.onAdSkip ||
              event.action == CSJ.AdEventAction.onAdComplete ||
              event.action == CSJ.AdEventAction.onAdError) &&
          event.adId == CSJUtils.CSJSplashId) {
        toMain();
      }
    });
  }

  void toMain() {
    Get.offAllNamed('/home', arguments: getArguments());
    // Navigator.push(context, CustomerRoute(MainHomePage()));
  }

  dynamic getArguments() => {'tomain': false};

  /// 申请权限
  /// 只在第一次申请权限，之后按需申请
  requestPermission() async {
    if (SPUtils.getSplashPermissionRequested()) {
      return;
    }
    SPUtils.setSplashPermissionRequested();
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage, Permission.phone].request();
    WFLogUtil.d(statuses);
  }
}
