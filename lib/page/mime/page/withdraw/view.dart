import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/base/base_stateful_widget.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/mime/user_center_entity.dart';
import 'package:SDZ/event/user_center_get_data.dart';
import 'package:SDZ/page/mime/page/bind_bank/view.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/widget/double_click.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

/// 提现
class WithdrawPage extends BaseStatefulWidget {
  @override
  BaseStatefulState<BaseStatefulWidget> getState() {
    return WithdrawPageState();
  }
}

class WithdrawPageState extends BaseStatefulState<WithdrawPage> {
  final WithdrawLogic logic = Get.put(WithdrawLogic());
  final WithdrawState state = Get.find<WithdrawLogic>().state;
  TextEditingController _controllerPhone = new TextEditingController();
  bool hasBindCard = false; //是否绑定银行卡
  UserCenterEntity? userCenterEntity;

  @override
  String navigatorTitle() {
    return '提现';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    EventBusUtils.getInstance().on<UserCenterEvent>().listen((event) {
      getData();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget initDefaultBuild(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DoubleClick(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new  BindBankPage(
                          isBind: userCenterEntity?.bank == null?false:true,
                          bankId: userCenterEntity?.bank?.id,
                        )));
              },
              child: bindCard()),
          SizedBox(
            height: 40,
          ),
          Container(
            width: double.infinity,
            height: 10,
            color: Colours.bg_f7f8f8,
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              '提现个数',
              style: TextStyle(fontSize: 14, color: Colours.color_333333),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Text(
                '￥',
                style: TextStyle(
                    fontSize: 28,
                    color: Colours.color_333333,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 40,
                child: TextField(
                  controller: _controllerPhone,
                  maxLines: 1,
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
                    hintText: '请输入提现个数',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '可取出省币：${userCenterEntity?.jifen ?? 0}个',
                  style: TextStyle(fontSize: 14, color: Colours.color_333333),
                ),
              ),
              DoubleClick(
                  onTap: () {
                    if (userCenterEntity?.jifen == 0) {
                      return;
                    }
                    _controllerPhone.text =
                        userCenterEntity?.jifen.toString() ?? "";
                  },
                  child: Text(
                    '全部取出',
                    style:
                        TextStyle(fontSize: 14, color: Colours.color_main_red),
                  )),
            ],
          ),
          FlatButton(
              onPressed: () {
                withdraw();
              },
              child: new Container(
                height: 45.0,
                margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                decoration: new BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(50.0)),
                    gradient: new LinearGradient(colors: [
                      const Color(0xFFe9546b),
                      const Color(0xFFd0465b)
                    ])),
                child: new Center(
                    child: new Text(
                  "提 现",
                  textScaleFactor: 1.1,
                  style: new TextStyle(fontSize: 16.0, color: Colors.white),
                )),
              )),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              '1、务必核实银行卡账号与该账号所属人真实姓名信息;\n2、10省币可兑换1元，即换算比例为10:1',
              style: TextStyle(fontSize: 12, color: Colours.text_999999),
            ),
          ),
        ],
      ),
    );
  }

  ///绑定银行卡
  Widget bindCard() {
    return Row(
      children: [
        SizedBox(
          width: 12,
        ),
        Text(
          '到账银行卡',
          style: TextStyle(fontSize: 14, color: Colours.color_333333),
        ),
        Expanded(child: Container()),
        Text(
          userCenterEntity?.bank?.number
                  ?.replaceFirst(new RegExp(r'\d{4}'), '****', 3) ??
              '绑定银行卡',
          style: TextStyle(fontSize: 14, color: Colours.color_333333),
        ),
        SizedBox(
          width: 2,
        ),
        Image(
          image: AssetImage("assets/images/ic_next.png"),
          width: 20,
          height: 20,
          color: Colours.color_black45,
        ),
        SizedBox(
          width: 12,
        ),
      ],
    );
  }

  void getData() {
    ApiClient.instance.get(ApiUrl.getBLDBaseUrl() + ApiUrl.center,
        loading: true, onSuccess: (data) {
      BaseEntity<UserCenterEntity> entity = BaseEntity.fromJson(data!);
      if (entity.isSuccess && entity.data != null) {
        setState(() {
          userCenterEntity = entity.data;
          hasBindCard = userCenterEntity?.bank != null;
        });
      }
    });
  }

  void withdraw() {
    if (userCenterEntity?.bank == null) {
      ToastUtils.toast("请先绑定银行卡账号");
      return;
    }
    if (_controllerPhone.text.length == 0) {
      ToastUtils.toast("请输入取出省币个数");
      return;
    }
    if (int.parse(_controllerPhone.text) > userCenterEntity!.jifen) {
      ToastUtils.toast("取出省币个数不能大于 ${userCenterEntity!.jifen} 个");
      return;
    }
    Map<String, String> map = Map();
    map['jine'] = _controllerPhone.text.trim();
    map['cardid'] = userCenterEntity?.bank?.id ?? '';
    ApiClient.instance.post(ApiUrl.getBLDBaseUrl() + ApiUrl.alipayWithdraw,
        loading: true, data: map, onSuccess: (data) {
      BaseEntity<UserCenterEntity> entity = BaseEntity.fromJson(data!);
      if (entity.isSuccess && entity.data != null) {
        ToastUtils.toast('提现成功，请耐心等待到账信息！');
        Get.back();
      }
    });
  }
}
