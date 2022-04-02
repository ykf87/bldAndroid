import 'dart:ffi';

import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/base/base_stateful_widget.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/base/empty_entity.dart';
import 'package:SDZ/entity/mime/user_center_entity.dart';
import 'package:SDZ/event/user_center_get_data.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/widget/double_click.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class BindBankPage extends BaseStatefulWidget {
  bool isBind;
  String? bankId;
  BindBankPage({this.isBind = false,this.bankId});
  @override
  BaseStatefulState<BaseStatefulWidget> getState() {
    return BindBankPageState();
  }
}

class BindBankPageState extends BaseStatefulState<BindBankPage> {
  final BindBankLogic logic = Get.put(BindBankLogic());
  final BindBankState state = Get.find<BindBankLogic>().state;
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerBankNumber = new TextEditingController();
  TextEditingController _controllerPhone = new TextEditingController();
  TextEditingController _controllerBank = new TextEditingController();

  @override
  String navigatorTitle() {
    return widget.isBind?"换绑银行卡":'绑定银行卡';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget initDefaultBuild(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16,top: 60),
      child: Column(
        children: [
          Item('真实姓名', _controllerName,'请输入银行卡绑定的姓名'),
          Row(
            children: [
              Image(
                image: AssetImage("assets/images/ic_warning.png"),
                width: 15,
                height: 15,
              ),
              Text(
                '请务必输入您银行卡的真实姓名,避免提现失败!',
                style: TextStyle(color: Colours.color_main_red, fontSize: 14),
              )
            ],
          ),
          SizedBox(height: 10,),
          DoubleClick(
              onTap: (){
                _selBank();
              },
              child: Item('请选择所属银行', _controllerBank,'',enable: false,isShowRightIcon: true)),
          SizedBox(height: 10,),
          Item('银行卡号', _controllerBankNumber,'请输入银行卡号'),
          SizedBox(height: 10,),
          Item('银行卡绑定的手机号', _controllerPhone,'请输入手机号'),
          SizedBox(height: 40,),
          btnBind(),
        ],
      ),
    );
  }
  Widget btnBind(){
    return FlatButton(
        onPressed: () {
          bindBank();
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
                "绑 定",
                textScaleFactor: 1.1,
                style: new TextStyle(fontSize: 16.0, color: Colors.white),
              )),
        ));
  }

  Widget Item(String title, TextEditingController controller,String hintText,{bool enable = true,bool isShowRightIcon = false}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(color: Colours.color_333333, fontSize: 16),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Center(
                      child: TextField(
                        //键盘展示为号码
                        keyboardType:title.contains('真实姓名')?TextInputType.text:TextInputType.number,
                        //只能输入数字
                        inputFormatters: <TextInputFormatter>[
                          title.contains('真实姓名')?FilteringTextInputFormatter.singleLineFormatter:FilteringTextInputFormatter.digitsOnly,
                        ],
                        cursorColor: Colours.text_main,
                        enabled: enable,
                        style: TextStyle(
                            color: Colours.color_333333,
                            fontSize: 15.0,),
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: hintText,
                          hintStyle: TextStyle(color:  Colours.color_grey_51223a50),
                          counterText: "", // 此处控制最大字符是否显示
                          border: InputBorder.none,
                        ),
                      ),
                    )),
                  ],
                ),
                width: double.infinity,
              ),
            ),
            isShowRightIcon?Image(image: AssetImage("assets/images/ic_black_down.png"),width: 15,height: 15,):SizedBox.shrink()
          ],
        ),

        Container(width: double.infinity,height:0.5,color: Colours.color_grey_e5e5e5,)
      ],
    );
  }


  //选择银行
  Widget? _selBank() {
    List<String> banks = ["中国银行", "中国建设银行", "中国工商银行", "中国农业银行", "中国农商银行"
      , "平安银行", "交通银行", "中国民生银行", "招商银行","其他"];
    Pickers.showSinglePicker(context, data: banks, pickerStyle: customizeStyle(),onConfirm: (value,position){
      setState(() {
        _controllerBank.text = value;
      });
    });

  }

  //自定义选择地区样式
  PickerStyle customizeStyle() {
    return PickerStyle(
      headDecoration: headDecoration,
      backgroundColor: Colours.bg_ffffff,
      textColor: Colours.color_333333,
      commitButton: Padding(
        padding: EdgeInsets.only(right: 16),
        child: Text('确定', style: TextStyle(color: Colours.color_333333, fontSize: 16)),
      ),
      cancelButton: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Text('取消', style: TextStyle(color:Colours.color_333333, fontSize: 16)),
      ),
    );
  }

  // 头部样式
  Decoration headDecoration = BoxDecoration(
      color: Colours.bg_ffffff,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), topRight: Radius.circular(8)));


  void bindBank() {
    if(_controllerName.text.isEmpty){
      ToastUtils.toast('请输入您的真实姓名');
      return;
    }
    if(_controllerName.text.isEmpty){
      ToastUtils.toast('请输入您的真实姓名');
      return;
    }
    if(_controllerBank.text.isEmpty){
      ToastUtils.toast('请选择所属银行');
      return;
    }
    if(_controllerBankNumber.text.isEmpty){
      ToastUtils.toast('请输入您的银行卡号');
      return;
    }
    if(_controllerPhone.text.isEmpty){
      ToastUtils.toast('请输入您银行卡绑定的手机号');
      return;
    }
    Map<String,String> map = Map();
    map["name"] = _controllerName.text;
    map["telphone"] = _controllerPhone.text;
    map["type"] = _controllerBank.text;
    map["number"] = _controllerBankNumber.text;
    if(widget.isBind){
      map["id"] = widget.bankId??'';
    }
    ApiClient.instance.post(ApiUrl.getBLDBaseUrl() + ApiUrl.bindBank,data: map,
        onSuccess: (data) {
          BaseEntity<EmptyEntity> entity = BaseEntity.fromJson(data!);
            ToastUtils.toast("绑定成功");
            EventBusUtils.getInstance().fire(UserCenterEvent());
            Get.back();
        });
  }

}
