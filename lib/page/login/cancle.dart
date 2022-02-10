import 'dart:async';
import 'dart:io';

import 'package:SDZ/dialog/exit_dialog.dart';
import 'package:SDZ/entity/global_entity.dart';
import 'package:SDZ/entity/login/login_entity.dart';
import 'package:SDZ/page/mime/page/PrivacyPolicyPage.dart';
import 'package:SDZ/utils/login_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/base/base_stateful_widget.dart';
import 'package:SDZ/constant/svg_path.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/base/empty_entity.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/page/index.dart';
import 'package:SDZ/page/login/code_login.dart';
import 'package:SDZ/page/web/web_view_page.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/custom_textinput_formatter.dart';
import 'package:SDZ/utils/event_bus_util.dart';

import 'package:SDZ/utils/phone_formatter.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/widget/double_click.dart';
import 'package:SDZ/widget/text_image_button.dart';

class CanclePage extends BaseStatefulWidget {
  final bool? isMessageTab;

  CanclePage({this.isMessageTab = false});

  @override
  BaseStatefulState<BaseStatefulWidget> getState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends BaseStatefulState<CanclePage>
    with SingleTickerProviderStateMixin {
  var toMain = false;
  late TextEditingController _controller;
  StreamSubscription<LoginEvent>? _bus;
  TextEditingController _controllerPhone = new TextEditingController();
  TextEditingController _controllerPwd = new TextEditingController();

  @override
  void initData() {
    super.initData();
    _bus = EventBusUtils.getInstance().on<LoginEvent>().listen((event) {
      if (event.mLogin == LoginEvent.LOGIN_TYPE_LOGIN &&
          Navigator.canPop(context)) {
        Get.back();
      }
    });
    _controller = new TextEditingController(
        text: Utils.splitPhoneNumber(SPUtils.getUserAccount()));
    _controllerPhone.text = SPUtils.getUserAccount();
  }

  @override
  void onDispose() {
    super.onDispose();
    _controller.dispose();
    _bus?.cancel();
  }

  @override
  void initNavigatorClickListener() {
    super.initNavigatorClickListener();
    onCloseKeyboard();
    if (!toMain && Navigator.canPop(context)) {
      Get.back();
    } else {
      Get.offAll(() => MainHomePage());
    }
  }

  @override
  bool interceptNavigatorBackClick() => true;

  @override
  bool isShowNavigator() => false;

  @override
  Widget initDefaultBuild(BuildContext context) {
    // TODO: implement build

    Widget phoneInputWidget = new Container(
      margin: new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
      width: MediaQuery.of(context).size.width * 0.85,
      child: new TextField(
        enabled: false,
        controller: _controllerPhone,
        maxLines: 1,
        maxLength: 11,
        onChanged: (String value) {
          // _userName=value;
        },
        style: new TextStyle(fontSize: 16.0, color: Colors.black),
        //键盘展示为号码
        keyboardType: TextInputType.phone,
        //只能输入数字
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly

        ],
        decoration: new InputDecoration(
          hintText: '请输入手机号码',
          icon: new Image.asset(
            'assets/images/phone_icon.png',
            width: 20.0,
            height: 20.0,
          ),
          border: UnderlineInputBorder(),
        ),
      ),
    );
    Widget passwordInputWidget = new Container(
      margin: new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
      width: MediaQuery.of(context).size.width * 0.85,
      child: new TextField(
        obscureText: true,
        keyboardType: TextInputType.number,
        controller: _controllerPwd,
        style: new TextStyle(fontSize: 16.0, color: Colors.black),
        decoration: new InputDecoration(
          hintText: '请输入密码',
          icon: new Image.asset(
            'assets/images/password_icon.png',
            width: 20.0,
            height: 20.0,
          ),
          border: UnderlineInputBorder(),
        ),
      ),
    );

    Widget btnLoginWidget = new FlatButton(
        onPressed: () {
          showDialog<void>(
              context: context,
              builder: (_) => ExitDialog(
                  onPressed: () {
                    // logout();
                   cancle();
                  },
                  content: '注销之后，您的信息将会被清除，无法注册和登录账号'));
        },
        child: new Container(
          height: 45.0,
          margin: new EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
              gradient: new LinearGradient(
                  colors: [const Color(0xFFe9546b), const Color(0xFFd0465b)])),
          child: new Center(
              child: new Text(
            "注 销",
            textScaleFactor: 1.1,
            style: new TextStyle(fontSize: 16.0, color: Colors.white),
          )),
        ));



    Widget contentWidget = new Center(
      child: new Container(
        constraints: new BoxConstraints.expand(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 450.0,
        ),
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(
            color: Colors.white,
            width: 5.0,
          ),
          borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '注销账号',
              style: new TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            phoneInputWidget,
            passwordInputWidget,
            btnLoginWidget,

          ],
        ),
      ),
    );
    Widget bgWidget = new Opacity(
        opacity: 0.98,
        child: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage('assets/images/login_back.png'),
              fit: BoxFit.cover,
            ),
          ),
        ));

    return Container(
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        body: new Stack(
          children: <Widget>[
            bgWidget,
            new ListView(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 60.0, bottom: 50.0),
                  child: new Center(
                      child: new Image.asset(
                    'assets/images/ic_logo.jpg',
                    width: 50.0,
                    height: 50.0,
                  )),
                ),
                contentWidget,
              ],
            )
          ],
        ),
      ),
    );

  }


  void getInfo() {
    SPUtils.setUserToken(
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsIkF1dGhvciI6bnVsbH0.eyJpc3MiOiJHT1VRSSIsImF1ZCI6Imh0dHA6Ly80NS43Ny4yMTYuMjQxIiwiaWF0IjoxNjQwMjQ1NDIxLjEzMTQyNCwibmJmIjoxNzAzMzE3NDIxLjEzMTQyNCwiaWQiOjcsInBob25lIjoiZXlKcGRpSTZJaTh5WmpOc1JrSktZMHc1WVhGeFEzaHZPRVpFSzJjOVBTSXNJblpoYkhWbElqb2lMMHg0Um1WVVZXdEdla2MxWjFwdVdVTm1PVTlCUVQwOUlpd2liV0ZqSWpvaVpUSXdOelJrWmpnME5UY3laamN3Wm1ZM01XRTVaakF4TmpkallqTmtOMkZpT1RneU1qSXhNV0poTWpJNU4ySm1OVEpqT0dRNFpURXdabU5qTmpsaU1TSjkiLCJzdGF0dXMiOjF9.BaCVllxXkharXdL-GWgB6yfvXbHx9ZMA4njFSk8FVtU');
    ApiClient.instance.get(ApiUrl.getBLDBaseUrl() + ApiUrl.getGlobalConfig,
        onSuccess: (data) {
      BaseEntity<GlobalEntity> entity = BaseEntity.fromJson(data!);
      ToastUtils.toast('成功');
    }, onError: (msg) {});
  }

  void cancle() {
    onCloseKeyboard();
    if (_controllerPwd.text.length == 0) {
      ToastUtils.toast('请填写您的密码');
      return;
    }
    Map<String, dynamic> map = new Map();
    String phone = _controllerPhone.value.text;
    String pwd = _controllerPwd.value.text;
    map['phone'] = phone.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    map['password'] = pwd.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    ApiClient.instance.post(ApiUrl.getBLDBaseUrl() + ApiUrl.cancle, data: map,
        onSuccess: (data) {
      BaseEntity<LoginEntity> entity = BaseEntity.fromJson(data!);
      ToastUtils.toast('注销成功');
      LoginUtil.logout();
    }, onError: (msg) {
      ToastUtils.toast(msg);
    });
  }
}
