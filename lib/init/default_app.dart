import 'dart:math';

import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/constant/wechat_constant.dart';
import 'package:SDZ/core/http/http.dart';
import 'package:SDZ/core/utils/locale.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/global_entity.dart';
import 'package:SDZ/generated/i18n.dart';
import 'package:SDZ/router/route_map.dart';
import 'package:SDZ/utils/CSJUtils.dart';
import 'package:SDZ/utils/VideoUtils.dart';
import 'package:SDZ/utils/YLHUtils.dart';
import 'package:SDZ/utils/device_util.dart';
import 'package:SDZ/utils/device_utils.dart';
import 'package:SDZ/utils/provider.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/theme_provider.dart';
import 'package:SDZ/utils/theme_utils.dart';
import 'package:SDZ/utils/wf_log_util.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_qq_ads/flutter_qq_ads.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:voiceread/voiceread.dart';
import 'package:fluwx/fluwx.dart';

//默认App的启动
class DefaultApp {
  //运行app
  static void run() {
    WidgetsFlutterBinding.ensureInitialized();

    ///全局定义沉浸式样式
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

    // 保持竖屏，禁止横屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      initFirst().then((value) =>
          runApp(ProviderScope(child: Store.init(ToastUtils.init(MyApp())))));
      initApp();
    });
  }

  /// 必须要优先初始化的内容
  static Future<void> initFirst() async {
    await SPUtils.init();
    await LocaleUtils.init();
    await FkUserAgent.init();
    if (SPUtils.isAgreementRead) {
      final result = await ApiClient.instance
          .getReturn(ApiUrl.getBLDBaseUrl() + ApiUrl.getGlobalConfig);
      if (result != null) {
        BaseEntity<GlobalEntity> entity = BaseEntity.fromJson(result!);
        SPUtils.setAdShow(entity.data?.isadv?.contains("true") ?? false);
      }
      if (SPUtils.getAdShow()) {
        await CSJUtils.initCSJADSDK();
        await FlutterQqAds.initAd(YLHUtils.YLHAPPID);
      }
      VideoUtils.init();
    }
    String deviceId = await DeviceUtil.deviceId ?? '';
    if (deviceId.isEmpty) {
      var rng = new Random(); //随机数生成类
      var rngTime = rng.nextInt(100);
      var time = DateTime.now().millisecondsSinceEpoch + rngTime;
      deviceId = 'FAKE_DEVICE_ID_$time';
    }
    SPUtils.setDeviceId(deviceId);
    // await MobSharedUtils.init();
  }

  /// 程序初始化操作
  static void initApp() {
    WFLogUtil.init(isDebug: kDebugMode);
    XHttp.init();
    registerWxApi(
        appId: WechatConstant.WX_APPID,
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: WechatConstant.UNIVERSAL_LINK);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleModel>(
        builder: (context, appTheme, localeModel, _) {
      /// 仅针对安卓
      if (Device.isAndroid) {
        /// 切换深色模式会触发此方法，这里设置导航栏颜色
        ThemeUtils.setSystemNavigationBar(appTheme.getThemeMode());
      }
      return GestureDetector(
        onTap: () {
          hideKeyboard(context);
        },
        child: GetMaterialApp(
          builder: EasyLoading.init(),
          title: '省得赚',
          theme: appTheme.getTheme(),
          darkTheme: appTheme.getTheme(isDarkMode: false),
          themeMode: appTheme.getThemeMode(),
          getPages: RouteMap.getPages,
          defaultTransition: Transition.rightToLeft,
          locale: localeModel.getLocale(),
          // supportedLocales: I18n.delegate.supportedLocales,
          localizationsDelegates: [
            I18n.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('zh', 'CN'), //设置语言为中文
          ],
          localeResolutionCallback:
              (Locale? _locale, Iterable<Locale> supportedLocales) {
            if (localeModel.getLocale() != null) {
              //如果已经选定语言，则不跟随系统
              return localeModel.getLocale();
            } else {
              //跟随系统
              Locale systemLocale = LocaleUtils.getSystemLocale();
              if (I18n.delegate.isSupported(systemLocale)) {
                return systemLocale;
              }
              return supportedLocales.first;
            }
          },
        ),
      );
    });
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
