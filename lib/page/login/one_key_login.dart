import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/base/base_stateful_widget.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/dialog/off_account_dialog.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/base/empty_entity.dart';
import 'package:SDZ/entity/login/login_entity.dart';
import 'package:SDZ/entity/session_entity.dart';
import 'package:SDZ/entity/user_entity.dart';
import 'package:SDZ/event/change_home_tab_event.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/event/reload_one_key_event.dart';
import 'package:SDZ/page/login/login.dart';
import 'package:SDZ/page/login/perfect_user_info.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/utils/one_key_login_util.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/umeng_util.dart';
import 'package:SDZ/utils/wf_log_util.dart';
import 'package:SDZ/widget/empty_appbar.dart';

import '../index.dart';
import 'code_login.dart';

/// @Author: ljx
/// @CreateDate: 2021/8/27 16:40
/// @Description: 一键登录

class OneKeyLoginPage extends BaseStatefulWidget {

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _OneKeyLoginState();

}

class _OneKeyLoginState extends BaseStatefulState<OneKeyLoginPage> {

  /// 背景滚动列表
  List<String> _list = [];

  /// 滚动控制器
  ScrollController? _scrollController;

  static const int offset = 30;

  /// 倒计时
  Timer? _timer;

  bool toMain = false;
  bool isMessageTab = false;

  StreamSubscription<ReLoadOneKeyLoginEvent>? _bus;

  @override
  bool isPrimary() => false;

  @override
  bool isCustomNavigator() => true;

  @override
  PreferredSizeWidget? initCustomNavigator() => EmptyAppBar();

  @override
  void onDispose() {
    super.onDispose();
    _bus?.cancel();
    if(_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    if(_scrollController != null) {
      _scrollController!.dispose();
      _scrollController = null;
    }
  }

  @override
  void initData() {
    super.initData();
    toMain = Get.arguments['tomain'];
    isMessageTab = Get.arguments['isMessageTab'];

    _bus = EventBusUtils.getInstance().on<ReLoadOneKeyLoginEvent>().listen((event) {
      if(event.mLogin == ReLoadOneKeyLoginEvent.LOGIN){
        initOneKeyLogin();
      }
      if(event.mLogin == ReLoadOneKeyLoginEvent.BACK){
        Get.back();
      }
    });

    addData();

    /// 设置滚动监听
    _scrollController = new ScrollController(initialScrollOffset: .0)
      ..addListener(_scrollListener);

    /// 设置定时器 用于自动滚动列表
    _timer = Timer.periodic(Duration(milliseconds: 800), (timer) {
      _scrollController!.animateTo(_scrollController!.offset + offset,
          duration: Duration(milliseconds: 800),
          curve: Curves.linear
      );
      // _scrollController.jumpTo(_scrollController.offset + offset);
    });

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initOneKeyLogin();
    });
  }

  addData() {
    _list.addAll(List.generate(20, (index) => 'assets/images/talent/${index + 1}.png'));
  }

  _scrollListener() {
    if (_scrollController!.offset >= _scrollController!.position.maxScrollExtent &&
        !_scrollController!.position.outOfRange) {
      setState(() {
        addData();
      });
    }
  }

  ///闪验初始化
  void initOneKeyLogin() {
    if(OneKeyLoginUtil.instance.getOneKeyLoginInitSuccess()) {
      OneKeyLoginUtil.instance
          .setOneKeyLoginListener((res) {
            if(1000 == res.code) {
              oneKeyLogin(res.token);
            }else{
              // Get.offAll(() => MainHomePage());
              Get.back();
              if (Platform.isIOS) {
                Get.back();
              }
            }
      }).openLoginAuth((res) {

      }, fail: () {
        toLogin();
      }).addClickWidgetEventListener((widgetId) {
        switch(widgetId){
          case 'icon':
            {
              Get.back();
              break;
            }
          case 'smsLogin':
            {
              toLogin();
              break;
            }
            break;
        }
      });
    }else{
      toLogin();
    }
  }

  toLogin() {
    Get.off(()=>LoginPage(isMessageTab: isMessageTab), arguments: {'tomain': toMain});
  }

  /// 一键登录
  void oneKeyLogin(String token) {
    Map<String, dynamic> map = Map();
    map['telephone'] = '';
    map['loginType'] = 1;
    map['code'] = token;
    map['pushCode'] = SPUtils.pushCode;
    ApiClient.instance.post(ApiUrl.login, data: map, onSuccess: (data){
      BaseEntity<LoginEntity> entity = BaseEntity.fromJson(data!);
      if(entity.isSuccess){
        SPUtils.setUserAccount(entity.data?.telephone ?? '');
        if(entity.data!.isCancel) {
          onShowOffAccountDialog(token);
          return;
        }
        ToastUtils.toast('登录成功');
        SPUtils.setUserId(entity.data?.accountId ?? '');
        SPUtils.setUserToken(entity.data?.token ?? '');
        SPUtils.setUserNickName(entity.data?.nickname ?? '');
        SPUtils.setAvatar(entity.data?.avatar ?? '');
        EventBusUtils.getInstance().fire(LoginEvent(LoginEvent.LOGIN_TYPE_LOGIN));
        /// 友盟登录用户账号
        UmengUtil.onProfileSignIn(entity.data!.accountId ?? '');
        if(entity.data!.isNewUser){
          Get.offAll(()=>PerfectUserInfoPage(entity.data!.telephone ?? ''));
        }else{
          if(toMain) {
            Get.offAll(() => MainHomePage());
          }else{
            if(isMessageTab) {
              EventBusUtils.getInstance().fire(ChangeHomeTabEvent(1));
            }
            Get.back();
          }
        }
      }
    }, onError: (msg){
      ToastUtils.toast(msg);
      Get.offAll(()=>LoginPage(), arguments: {'tomain': toMain});
    });
  }

  /// 继续登录
  continueLogin(String token) {
    Map<String, dynamic> map = Map();
    map['telephone'] = SPUtils.getUserAccount();
    map['loginType'] = 1;
    map['code'] = token;
    ApiClient.instance.post(ApiUrl.login_continue, data: map, onSuccess: (data){
      BaseEntity<EmptyEntity> entity = BaseEntity.fromJson(data!);
      if(entity.isSuccess){
        Get.to(()=>CodeLoginPage(phone: SPUtils.getUserAccount(), isMessageTab: isMessageTab, isContinueLogin: true), arguments: {'tomain':toMain});
      }
    }, onError: (msg){
      ToastUtils.toast(msg);
      Get.offAll(()=>LoginPage(), arguments: {'tomain': toMain});
    });
  }

  /// 注销提示弹窗
  void onShowOffAccountDialog(token) {
    Get.dialog(OffAccountDialog(onTap: (){
      continueLogin(token);
    }, onCancel: (){
      Get.back();
    }), barrierDismissible: false);
  }

  @override
  Widget initDefaultBuild(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          child: StaggeredGridView.countBuilder(
            primary: false,
            controller: _scrollController,
            shrinkWrap: true,
            crossAxisCount: 4,
            itemCount: _list.length,
            itemBuilder: (context, i) {
              return Image.asset(_list[i], fit: BoxFit.fill);
            },
            staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
          ),
        ),
        Container(
          color: Color(0x80000000),
        )
      ],
    );
  }
}