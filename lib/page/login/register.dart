import 'dart:async';
import 'dart:io';

import 'package:SDZ/entity/global_entity.dart';
import 'package:SDZ/entity/login/login_entity.dart';
import 'package:SDZ/page/mime/page/PrivacyPolicyPage.dart';
import 'package:SDZ/utils/loading_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

class BldRegisterPage extends BaseStatefulWidget {
  final bool? isMessageTab;

  BldRegisterPage({this.isMessageTab = false});

  @override
  BaseStatefulState<BaseStatefulWidget> getState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends BaseStatefulState<BldRegisterPage>
    with SingleTickerProviderStateMixin {
  var toMain = false;
  late TextEditingController _controller;
  bool _isChecked = false;
  bool _nextBtnEnable = false;
  StreamSubscription<LoginEvent>? _bus;
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerPhone = new TextEditingController();
  TextEditingController _controllerPwd = new TextEditingController();
  bool _checkSelected = false; //维护复选框开关状态

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
    _nextBtnEnable = SPUtils.getUserAccount().isNotEmpty;

    // var map = Get.arguments;
    // toMain = map['tomain'];

    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //   FocusScope.of(context).requestFocus(focusNode);
    // });
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return Container(
      child: new Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffB5CBED),
        body: Container(
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(new Radius.circular(12.0)),
          ),
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(left: 6, right: 6, top: 4, bottom: 16),
          child: Column(
            children: <Widget>[
              bgWidget(),
              nicknameWidget(),
              phoneInputWidget(),
              passwordInputWidget(),
              btnLoginWidget(),
            ],
          ),
        ),
      ),
    );

  }

  Widget nicknameWidget(){
    return Column(
      children: [
        Container(
          margin: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
          width: double.infinity,
          child: new TextField(
            controller: _controllerName,
            maxLines: 1,
            maxLength: 11,
            onChanged: (String value) {
              // _userName=value;
            },
            style: new TextStyle(fontSize: 16.0, color: Colors.black),
            cursorColor: Colours.color_D8DADC,
            decoration: new InputDecoration(
              counterText: '',
              hintText: '请输入昵称',
              hintStyle: TextStyle(color: Colours.color_D8DADC, fontSize: 14),
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          margin: new EdgeInsets.fromLTRB(20.0, 1.0, 20.0, 0.0),
          width: double.infinity,
          height: 1,
          color: Colours.color_D8DADC,
        )
      ],
    );
  }
  Widget phoneInputWidget() {
    return Column(
      children: [
        Container(
          margin: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
          width: double.infinity,
          child: new TextField(
            controller: _controllerPhone,
            maxLines: 1,
            maxLength: 11,
            onChanged: (String value) {
              // _userName=value;
            },
            style: new TextStyle(fontSize: 16.0, color: Colors.black),
            //键盘展示为号码
            keyboardType: TextInputType.phone,
            cursorColor: Colours.color_D8DADC,
            //只能输入数字
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: new InputDecoration(
              counterText: '',
              hintText: '请输入手机号码',
              hintStyle: TextStyle(color: Colours.color_D8DADC, fontSize: 14),
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          margin: new EdgeInsets.fromLTRB(20.0, 1.0, 20.0, 0.0),
          width: double.infinity,
          height: 1,
          color: Colours.color_D8DADC,
        )
      ],
    );
  }

  Widget passwordInputWidget() {
    return Column(
      children: [
        new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 0.0),
          width: double.infinity,
          child: new TextField(
            obscureText: true,
            cursorColor: Colours.color_D8DADC,
            keyboardType: TextInputType.number,
            controller: _controllerPwd,
            style: new TextStyle(fontSize: 16.0, color: Colors.black),
            decoration: new InputDecoration(
                hintText: '请输入密码',
                border: InputBorder.none,
                hintStyle:
                TextStyle(color: Colours.color_D8DADC, fontSize: 14)),
          ),
        ),
        Container(
          margin: new EdgeInsets.fromLTRB(20.0, 1.0, 20.0, 0.0),
          width: double.infinity,
          height: 1,
          color: Colours.color_D8DADC,
        )
      ],
    );
  }

  Widget btnLoginWidget() {
    return new FlatButton(
        onPressed: () {
          toLogin();
        },
        child: new Container(
          height: 50.0,
          margin: new EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
              gradient: new LinearGradient(colors: [
                Colours.color_login_77A7EF,
                Colours.color_login_77A7EF
              ])),
          child: new Center(
              child: new Text(
                "注 册",
                textScaleFactor: 1.1,
                style: new TextStyle(fontSize: 16.0, color: Colors.white),
              )),
        ));
  }

  Widget bgWidget() {
    return Opacity(
        opacity: 0.98,
        child: new Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height*0.4,
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0)),
            image: new DecorationImage(
              image: new ExactAssetImage('assets/images/bg_login.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }


  void toLogin() {
    if (_controllerName.text.length == 0) {
      ToastUtils.toast('请填写您的账号');
      return;
    }
    if (_controllerPhone.text.length == 0) {
      ToastUtils.toast('请填写您的账号');
      return;
    }
    if (_controllerPwd.text.length == 0) {
      ToastUtils.toast('请填写您的密码');
      return;
    }
    Map<String, dynamic> map = new Map();
    String phone = _controllerPhone.value.text;
    String pwd = _controllerPwd.value.text;
    map['name'] =_controllerName.value.text;
    map['phone'] = phone.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    map['password'] = pwd.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    EasyLoading.showToast("请求中...");
    ApiClient.instance.post(ApiUrl.getBLDBaseUrl() + ApiUrl.register, data: map,
        onSuccess: (data) {
      EasyLoading.dismiss();
      BaseEntity<LoginEntity> entity = BaseEntity.fromJson(data!);
      if (!entity.isSuccess) {
        ToastUtils.toast(entity.message ?? '');
        return;
      }
      ToastUtils.toast('注册成功');
      SPUtils.setUserId(entity.data?.id ?? '');
      SPUtils.setUserToken(entity.data?.token ?? '');
      SPUtils.setUserAccount(phone);
      SPUtils.setUserNickName(entity.data?.nickname ?? '');
      SPUtils.setAvatar(entity.data?.avatar ?? '');
      EventBusUtils.getInstance().fire(LoginEvent(LoginEvent.LOGIN_TYPE_LOGIN));
      Get.offAll(() => MainHomePage());
    }, onError: (msg) {
      EasyLoading.dismiss();
      ToastUtils.toast(msg);
    });
  }
}
