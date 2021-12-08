import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/core/utils/event.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/dialog/cancellation_tips_dialog.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/base/empty_entity.dart';
import 'package:SDZ/entity/user_entity.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/page/mime/widget/base_textfield_widget.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/login_util.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/umeng_util.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/widget/double_click.dart';

import '../../../index.dart';
import 'logic.dart';
import 'state.dart';

//注销
class CancellationPhonePage extends StatefulWidget {
  @override
  _CancellationPhonePageState createState() => _CancellationPhonePageState();
}

class _CancellationPhonePageState extends State<CancellationPhonePage> {
  final CancellationPhoneLogic logic = Get.put(CancellationPhoneLogic());
  final CancellationPhoneState state = Get.find<CancellationPhoneLogic>().state;
  TextEditingController _controllerPhtone = new TextEditingController();
  TextEditingController _controllerCode = new TextEditingController();
  bool _isEnable = false;
  int _mSeconds = 60;
  Timer? _timer;
  int _isCountDown = 1; //1:未倒计时 2：正在倒计时 3：重新倒计时
  String codeText = '获取验证码';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerPhtone.text = SPUtils.getUserAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('账号注销',
            style: TextStyle(color: Colours.bg_ffffff, fontSize: 20)),
        leading: IconButton(
          color: Colors.white,
          tooltip: null,
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_outlined),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          child: SvgPicture.asset(
                            "assets/svg/ic_warn.svg",
                          ),
                        ),
                        SizedBox(width: 8),
                        Text('您当前正在执行账号注销',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(height: 48),
                    Container(
                      margin: EdgeInsets.only(left: 20, bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('手机号码',
                              style: TextStyle(
                                  color: Colours.text_main, fontSize: 14)),
                          SizedBox(
                            width: 8,
                          ),
                          SvgPicture.asset(Utils.getSvgUrl('ic_asterisk.svg'),width: 8,height: 8,)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        crossAxisAlignment:  CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Center(
                                child: TextField(
                                  cursorColor: Colours.text_main,
                                  style: TextStyle(color: Colors.white, fontSize: 15.0,fontWeight: FontWeight.bold),
                                  enabled: false,
                                  controller: _controllerPhtone,
                                  decoration: InputDecoration(
                                    counterText: "", // 此处控制最大字符是否显示
                                    border: InputBorder.none,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      height: 48.0,
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                          color: Colours.dark_bg_color2,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 20, bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('验证码',
                              style: TextStyle(
                                  color: Colours.text_main, fontSize: 14)),
                          SizedBox(
                            width: 8,
                          ),
                          SvgPicture.asset(Utils.getSvgUrl('ic_asterisk.svg'),width: 8,height: 8,)
                        ],
                      ),
                    ),
                    Container(
                      height: 48,
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colours.dark_bg_color2,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Center(
                                child: TextField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(6)
                                  ],
                                  onChanged: (text) {
                                    onTextChange();
                                  },
                                  controller: _controllerCode,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    // contentPadding: const EdgeInsets.only(left: 5, top: 10, right: 0, bottom: 10),
                                      hintText: '请输入验证码',
                                      hintStyle: TextStyle(fontSize: 15, color: Colours.color_3E414B, textBaseline: TextBaseline.alphabetic),
                                      border: InputBorder.none,
                                      suffixIcon: _controllerCode.text.length > 0
                                          ? IconButton(
                                        iconSize: 20,
                                        icon: Icon(Icons.cancel),
                                        color: Colors.grey,
                                        onPressed: () {
                                          _controllerCode.clear();
                                          setState(() {});
                                        },
                                      )
                                          : Text('')),
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                          DoubleClick(
                            onTap: () {},
                            child: Container(
                              height: 25,
                              padding: EdgeInsets.only(left: 7, right: 7),
                              child: DoubleClick(
                                onTap: () {
                                  if (_isCountDown == 2) {
                                    return;
                                  }
                                  getPhoneCode();
                                },
                                child: Center(
                                  child: Text(codeText,
                                      style: TextStyle(
                                          color: Colours.bg_ffffff,
                                          fontSize: 15)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 20,
              left: 12,
              right: 12,
              child: DoubleClick(
                onTap: () {
                  if(!_isEnable){
                    return;
                  }
                  Utils.hideKeyboard(context);
                  cancellation();
                },
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                      color: _isEnable
                          ? Colours.color_main_red
                          : Colours.color_btn_nor,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  margin: EdgeInsets.only(
                      left: 0, right: 0, top: 0, bottom: 40),
                  child: Center(
                    child: Text(
                      '提交账号注销',
                      style: TextStyle(color:_isEnable? Colors.white:Colours.text_main, fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void onTextChange() {
    if (_controllerCode.text.length > 0) {
      _isEnable = true;
    } else {
      _isEnable = false;
    }
    setState(() {});
  }


  ///获取验证码
  void getPhoneCode() {
    Map<String, dynamic> map = {'telephone': SPUtils.getUserAccount(), 'type':2};
    ApiClient.instance.post(ApiUrl.sms_code, data: map, onSuccess: (data){
      BaseEntity<EmptyEntity> entity = BaseEntity.fromJson(data!);
      if(entity.isSuccess){
        onStartCountDown();
      }
    });
  }

  /// 倒计时
  void onStartCountDown() {
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_mSeconds < 1) {
          _timer!.cancel();
          _timer = null;
          _isCountDown = 3;
          _mSeconds = 60;
        } else {
          _mSeconds--;
        }
        setState(() {
          if (_isCountDown == 2) {
            codeText = '${_mSeconds}s';
          } else if (_isCountDown == 3) {
            codeText = '重新获取';
          }
        });
      });
      _isCountDown = 2;
    }
  }

  /// 注销
  void cancellation() {
    Map<String, dynamic> map = {'telephone': SPUtils.getUserAccount(),'code':_controllerCode.text};
    ApiClient.instance.delete(ApiUrl.cancellationPhone, data: map, onSuccess: (data){
      BaseEntity<EmptyEntity> entity = BaseEntity.fromJson(data!);
      if(entity.isSuccess){
        showDialog<void>(
            barrierDismissible:false,
            context: context,
            builder: (_) => CancellationTipsDialog(
                onPressed: () {
                  LoginUtil.logout();
                },
                title: Text('提交成功',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                content:
                '账号「${SPUtils.getUserAccount()}」注销申请已提交，该账号将在15天内自动注销，若您在此期间登录该账号，示为您已放弃账号注销。'));
      }
    });
  }
}
