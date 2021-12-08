import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';

import 'package:flutter_pickers/style/picker_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/event/user_center_get_data.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/utils/wf_log_util.dart';
import 'package:SDZ/widget/double_click.dart';
import '../../../entity/mime/base_info_entity.dart';
import 'package:SDZ/page/mime/widget/line_text_widget.dart';
import 'package:SDZ/page/shop/widget/camera_dialog.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/OssUpDataUtil.dart';
import 'package:SDZ/utils/image_utils.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/widget/my_scroll_view.dart';

///基础信息页面
class BaseInfoPage extends StatefulWidget {
  @override
  _BaseInfoPageState createState() => _BaseInfoPageState();
}

class _BaseInfoPageState extends State<BaseInfoPage> {
  String headUrl = SPUtils.getAvatar();
  BaseInfoEntity? baseInfoEntity;
  String initProvince = '福建省', initCity = '福州市', initTown = '鼓楼区';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('基础信息',
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
          elevation: 0,
        ),
        body: MyScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
          tapOutsideToDismiss: true,
          children: _buildBody(),
          bottomButton: bottomBtn(),
        ));
  }

  //获取基础信息
  void getData() {
    ApiClient.instance.get(ApiUrl.getbaseInfo, onSuccess: (data) {
      BaseEntity<BaseInfoEntity> entity = BaseEntity.fromJson(data!);
      baseInfoEntity = entity.data;
      if (baseInfoEntity == null) {
        return;
      }
      headUrl = baseInfoEntity!.avatar;
      WFLogUtil.d('headUrl==${headUrl}');
      _controllerName.text = baseInfoEntity!.nickname;
      _controllerPhone.text = baseInfoEntity!.telephone;
      _controllerWechat.text = baseInfoEntity!.wechat ?? '';
      _controllerAddress.text = baseInfoEntity!.address??'';
      initProvince = baseInfoEntity!.province??'';
      initCity = baseInfoEntity!.city??'';
      initTown = baseInfoEntity!.area??'';
      _controllerArea.text = initProvince+initCity+initTown;
      setState(() {

      });
    });
  }

  //更新个人信息
  void updateInfo() {
    Map<String, dynamic> map = Map();
    map['avatar'] = headUrl;
    map['telephone'] = _controllerPhone.text;
    map['nickname'] = _controllerName.text;
    map['wechat'] = _controllerWechat.text;
    map['province'] = initProvince;
    map['city'] = initCity;
    map['area'] = initTown;
    map['address'] = _controllerAddress.text;

    ApiClient.instance.put(ApiUrl.modifyBaseInfo, data: map, onSuccess: (data) {
        ToastUtils.toast('保存成功');
        EventBusUtils.getInstance().fire(UserCenterEvent());
        Get.back();
    });
  }

  //保存
  Widget bottomBtn() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      child: DoubleClick(
        onTap: () {
          if (headUrl == null) {
            ToastUtils.toast('您还没上传头像呢~');
            return;
          }
          if (_controllerName.value.text.length == 0) {
            ToastUtils.toast('需要完善昵称哦~');
            return;
          }
          if (_controllerPhone.value.text.length == 0) {
            ToastUtils.toast('请填写联系电话');
            return;
          }
          if (_controllerWechat.value.text.length == 0) {
            ToastUtils.toast('请填写微信号');
            return;
          }
          updateInfo();
        },
        child: Container(
            height: 45,
            padding: EdgeInsets.all(4),
            child: Center(
              child: Text(
                '保存',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            decoration: BoxDecoration(
              color: Colours.color_main_red,
              borderRadius: BorderRadius.circular(8.0),
            )),
      ),
    );
  }

  List<Widget> _buildBody() {
    return [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DoubleClick(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor:Colours.bg_b3000000,
                  context: context,
                  builder: (BuildContext context) {
                    return CameraDialog(isCrop: true,callBack: (File? file) {
                      WFLogUtil.d("file==$file");
                      //更换头像
                      OssUpdataUtil.upload(XFile(file!.path),(String url){
                        setState(() {
                          headUrl = url;
                        });
                      });
                    });
                  });
            },
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          backgroundImage: ImageUtils.getImageProvider(headUrl),
                        ),
                      ),
                      headUrl.length == 0
                          ? SizedBox.shrink()
                          : Positioned(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(48),
                                child: Container(
                                  width: 96,
                                  height: 96,
                                  color: Colours.color_80000000,
                                ),
                              ),
                            ),
                      Positioned(
                          child: SvgPicture.asset(
                        Utils.getSvgUrl('ic_edit.svg'),
                        height: 20,
                        width: 20,
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    '点击更换头像',
                    style: TextStyle(color: Colours.bg_ffffff, fontSize: 14),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      item('昵称', '请输入您的昵称', _controllerName, 10, true),
      item('联系电话', '请输入您的联系电话', _controllerPhone, 20, false),
      item('微信号', '请输入微信号', _controllerWechat, 20, true),
      item('所在地区', '请选择所在地区', _controllerArea, 10, false, context: context),
      item('详细地址', '请输入详细地址', _controllerAddress, 100, true, height: 96),
      SizedBox(height: 12)
    ];
  }

  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerPhone = new TextEditingController();
  TextEditingController _controllerWechat = new TextEditingController();
  TextEditingController _controllerArea = new TextEditingController();
  TextEditingController _controllerAddress = new TextEditingController();

  Widget item(String title, String hintText, TextEditingController controller,
      int maxLength, bool enable,
      {double? height, BuildContext? context}) {
    bool isShowRedStart = true; //是否显示*
    if (title.contains('所在地区') || title.contains('详细地址')) {
      isShowRedStart = false;
    }

    return DoubleClick(
      onTap: () {
        if (!enable) {
          hideKeyboard(context!);
          _checkLocation();
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: 28,
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title,
                      style: TextStyle(color: Colours.text_main, fontSize: 14)),
                  SizedBox(
                    width: 8,
                  ),
                  isShowRedStart
                      ? SvgPicture.asset(Utils.getSvgUrl('ic_asterisk.svg'),width: 8,height: 8,)
                      : SizedBox.shrink()
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Row(
                  crossAxisAlignment: height != null
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: TextField(
                      cursorColor: Colours.text_main,
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                      maxLength: maxLength,
                      maxLines: height != null ? 5 : 1,
                      enabled: enable,
                      controller: controller,
                      keyboardType: title.contains('电话')
                          ? TextInputType.number
                          : TextInputType.text,
                      decoration: InputDecoration(
                        counterText: "", // 此处控制最大字符是否显示
                        hintText: hintText,
                        border: InputBorder.none,
                      ),
                    )),
                    !title.contains('所在地区')
                        ? SizedBox.shrink()
                        : Container(
                            margin: EdgeInsets.only(right: 12),
                            child: Image(
                              image: AssetImage("assets/images/ic_next.png"),
                              width: 20,
                              height: 20,
                              color: Colours.text_main,
                            ))
                  ],
                ),
                height: height ?? 48.0,
                width: double.infinity,
                padding: EdgeInsets.only(left: 12,right: 12),
                decoration: BoxDecoration(
                    color: Colours.dark_bg_color2,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ],
          ),
        ],
      ),
    );
  }


  //选择地区
  Widget? _checkLocation() {
    Pickers.showAddressPicker(
      context,
      pickerStyle: customizeStyle(),
      initProvince: initProvince,
      initCity: initCity,
      initTown: initTown,
      onConfirm: (p, c, t) {
        setState(() {
          if (c.contains("全部")) {
            c = '';
          }
          if (t!.contains("全部")) {
            t = '';
          }
          initProvince = p;
          initCity = c;
          initTown = t!;
          _controllerArea.text = p + c + t!;
        });
      },
    );
  }

  //自定义选择地区样式
  PickerStyle customizeStyle() {
    return PickerStyle(
      headDecoration: headDecoration,
      backgroundColor: Colours.dark_bg_color,
      textColor: Colors.white,
      commitButton: Padding(
        padding: EdgeInsets.only(right: 16),
        child: Text('确定', style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
      cancelButton: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Text('取消', style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }

  // 头部样式
  Decoration headDecoration = BoxDecoration(
      color: Colours.dark_bg_color,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), topRight: Radius.circular(8)));

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
