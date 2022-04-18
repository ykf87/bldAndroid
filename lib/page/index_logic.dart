import 'dart:async';
import 'dart:io';
import 'package:SDZ/page/login/new_login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/constant/wf_constant.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/dialog/agreement_dialog.dart';
import 'package:SDZ/dialog/alter_dialog.dart';
import 'package:SDZ/dialog/notification_permission_dialog.dart';
import 'package:SDZ/dialog/off_account_dialog.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/base/empty_entity.dart';
import 'package:SDZ/entity/login/login_entity.dart';
import 'package:SDZ/entity/new_message_entity.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/utils/jpush_util.dart';
import 'package:SDZ/utils/login_util.dart';

import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/umeng_util.dart';
import 'package:SDZ/utils/wf_log_util.dart';

import 'index_state.dart';
import 'login/code_login.dart';
import 'login/login.dart';
import 'login/perfect_user_info.dart';

class IndexLogic extends GetxController {
  final IndexState state = IndexState();
  bool isSmallTimer = false;
  Timer? timer;


  //tab改变处理
  tabChange(int index) {
  }

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

  /// 申请通知权限
  requestNotificationPermission() async {
    bool isEnabled = await JPushUtil.instance.isNotificationEnabled();
    if (!isEnabled && !SPUtils.getNotificationPermissionRequested()) {
      SPUtils.setNotificationPermissionRequested();
      Get.dialog(NotificationPermissionDialog());
    }
  }

  /// 完善信息
  /// 如未完善提示完善
  editBaseInfo() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (LoginUtil.isLogin() &&
          (SPUtils.userNickName.isEmpty || SPUtils.getAvatar().isEmpty)) {
        Get.offAll(() => PerfectUserInfoPage(SPUtils.getUserAccount()));
      }
    });
  }

  /// 协议弹窗
  showAgreementDialog() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Get.dialog(AgreementDialog(onTap: (type) {
        if (type == 0) {
          showAgreementConfirmDialog();
        }
        if (type == 1) {
          SPUtils.setAgreementRead(true);
          initSDK();
        }
      }), barrierDismissible: false);
    });
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
              SystemNavigator.pop();
            }
            if (type == 1) {
              showAgreementDialog();
            }
          },
        ),
        barrierDismissible: false);
  }

  /// 初始化SDK
  void initSDK() {
    requestPermission();

    // /// 闪验初始化
    // OneKeyLoginUtil.instance.init();

    /// 友盟初始化
    // UmengUtil.instance.init();

  }

  dynamic get arguments => {'tomain': true};

  login() {
    if (LoginUtil.isLogin()) {
      return;
    }

    if (Platform.isIOS) {
      LoginUtil.toLogin(isMessageTab: true);
    }
    else {
      state.showTabLogin = true;
        state.showTabLogin = false;
        toLogin();
    }
  }

  toLogin() {
    Get.to(
        () => NewLoginPage(),
        arguments: {'tomain': false});
  }

  /// 一键登录
  void oneKeyLogin(String token) {
    Map<String, dynamic> map = Map();
    map['telephone'] = '';
    map['loginType'] = 1;
    map['code'] = token;
    map['pushCode'] = SPUtils.pushCode;
    ApiClient.instance.post(ApiUrl.login, data: map, onSuccess: (data) {
      BaseEntity<LoginEntity> entity = BaseEntity.fromJson(data!);
      if (entity.isSuccess) {
        SPUtils.setUserAccount(entity.data?.telephone ?? '');

        ToastUtils.toast('登录成功');
        SPUtils.setUserId(entity.data?.accountId ?? '');
        SPUtils.setUserToken(entity.data?.token ?? '');
        SPUtils.setUserNickName(entity.data?.nickname ?? '');
        SPUtils.setAvatar(entity.data?.avatar ?? '');
        WFLogUtil.d("--------发送LOGIN_TYPE_LOGIN事件-------------");
        EventBusUtils.getInstance()
            .fire(LoginEvent(LoginEvent.LOGIN_TYPE_LOGIN));

        /// 友盟登录用户账号
        UmengUtil.onProfileSignIn(entity.data!.accountId ?? '');

        state.curTabIndex = 1;
        tabChange(state.curTabIndex);
        update();

        WFLogUtil.d("---------一键登录state.curTabIndex----------" +
            state.curTabIndex.toString());
      }
    });
  }

  /// 继续登录
  continueLogin(String token) {
    Map<String, dynamic> map = Map();
    map['telephone'] = SPUtils.getUserAccount();
    map['loginType'] = 1;
    map['code'] = token;
    ApiClient.instance.post(ApiUrl.login_continue, data: map,
        onSuccess: (data) {
      BaseEntity<EmptyEntity> entity = BaseEntity.fromJson(data!);
      if (entity.isSuccess) {
        Get.to(() => CodeLoginPage(
              phone: SPUtils.getUserAccount(),
              isMessageTab: true,
              isContinueLogin: true,
            ), arguments: {'tomain': false});
      }
      state.curTabIndex = 1;
      WFLogUtil.d("---------非一键登录state.curTabIndex----------" +
          state.curTabIndex.toString());
      update();
    }, onError: (msg) {
      ToastUtils.toast(msg);
      toLogin();
    });
  }

  /// 注销提示弹窗
  void onShowOffAccountDialog(String token) {
    Get.dialog(
        OffAccountDialog(
            onTap: () {
              continueLogin(token);
            },
            onCancel: () {}),
        barrierDismissible: false);
  }
}
