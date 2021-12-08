import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/base/base_stateful_widget.dart';
import 'package:SDZ/constant/svg_path.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/base/empty_entity.dart';
import 'package:SDZ/event/change_home_tab_event.dart';
import 'package:SDZ/page/index.dart';
import 'package:SDZ/page/shop/widget/camera_dialog.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/OssUpDataUtil.dart';
import 'package:SDZ/utils/custom_textinput_formatter.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/widget/double_click.dart';

/// @Author: ljx
/// @CreateDate: 2021/8/24 9:48
/// @Description: 完善新用户信息

class PerfectUserInfoPage extends BaseStatefulWidget {

  final String phone;

  final bool? isMessageTab;

  PerfectUserInfoPage(this.phone, {this.isMessageTab = false});

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _PerfectUserInfoState();
}

class _PerfectUserInfoState extends BaseStatefulState<PerfectUserInfoPage> {

  String avatarUrl = '';
  late TextEditingController _editingController;

  @override
  void initData() {
    super.initData();
    String phone = widget.phone;
    if(phone.isNotEmpty && phone.length > 4){
      phone = phone.substring(phone.length - 4, phone.length);
    }
    _editingController = TextEditingController(text: 'WeFree$phone');
  }

  @override
  void onDispose() {
    super.onDispose();
    _editingController.dispose();
  }

  @override
  PreferredSizeWidget initCustomNavigator() => AppBar(
    ///隐藏底部阴影
    elevation: 0,
    backgroundColor: Colours.color_10121A,
    leading: Container(),
    brightness: Brightness.dark,
  );

  @override
  bool isCustomNavigator() => true;

  @override
  Widget initDefaultBuild(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('欢迎加入', style: TextStyle(color: Colors.white, fontSize: 28),),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: SvgPicture.asset(
                          SvgPath.ic_logo,
                          width: 112,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Center(
                  child: Text('一表人才的你更需要个性的头像和昵称', style: TextStyle(color: Colours.color_6A6E7E, fontSize: 14),),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 32),
                  child: DoubleClick(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      onCloseKeyboard();
                      //更换头像
                      Get.bottomSheet(CameraDialog(isCrop: true,callBack: (File? file) {
                        OssUpdataUtil.upload(XFile(file!.path),(String url){
                          setState(() {
                            avatarUrl = url;
                          });
                        });
                      }));
                    },
                    child: Column(
                      children: [
                        ClipOval(
                          child: avatarUrl.isNotEmpty ? CachedNetworkImage(
                            imageUrl: avatarUrl.isNotEmpty ? avatarUrl : 'https://img2.baidu.com/it/u=3354066334,1529355902&fm=26&fmt=auto&gp=0.jpg',
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                          ) : SvgPicture.asset(
                            SvgPath.ic_avatar,
                            width: 110,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          child: Text('点击修改头像', style: TextStyle(fontSize: 14, color: Colours.color_6A6E7E),)
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 32),
                child: RichText(
                  text: TextSpan(
                      text: '昵称',
                      style: TextStyle(color: Colours.color_6A6E7E, fontSize: 14),
                      children: [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(fontSize: 14, color: Colours.color_FF193C),
                        ),
                      ]
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 48,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.only(left: 10, right: 0),
                decoration: BoxDecoration(
                    color: Colours.color_181A23,
                    borderRadius: BorderRadius.circular((8))
                ),
                child: TextField(
                  controller: _editingController,
                  focusNode: focusNode,
                  style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    CustomTextInputFormatter(
                      filterPattern: RegExp("[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]|[_]"),
                    ),
                  ],
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 15),
                      hintText: '请输入昵称',
                      hintStyle: TextStyle(fontSize: 15, color: Colours.color_3E414B),
                      border: InputBorder.none,
                      suffixIcon: _editingController.text.isNotEmpty && focusNode.hasFocus ? IconButton(
                        iconSize: 20,
                        icon: Icon(Icons.cancel),
                        color: Colors.grey,
                        onPressed: () {
                          _editingController.clear();
                          setState(() {
                          });
                        },
                      ) : Text(''),

                  ),
                  onChanged: (text) {
                    setState(() {

                    });
                  },
                ),
              )
            ],
          )),
          Container(
            width: double.infinity,
            height: 45,
            margin: const EdgeInsets.only(bottom: 50),
            child: ElevatedButton(
                onPressed: (){
                  checkData();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colours.color_FF193C),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                ),
                child: Text('保存', style: TextStyle(color: Colors.white, fontSize: 16),)),
          )
        ],
      ),
    );
  }

  /// 校验数据
  void checkData() {
    onCloseKeyboard();
    if(avatarUrl.isEmpty) {
      ToastUtils.toast('您还没上传头像呢~');
      return;
    }
    String nickName = _editingController.text;
    if(nickName.isEmpty){
      ToastUtils.toast('需要完善昵称哦~');
      return;
    }
    Map<String, dynamic> data = {'avatar': avatarUrl, 'nickname': nickName};
    ApiClient.instance.put(ApiUrl.user_info, data: data, onSuccess: (data){
      BaseEntity<EmptyEntity> entity = BaseEntity.fromJson(data!);
      if(entity.isSuccess){
        ToastUtils.toast('保存成功');
        SPUtils.setAvatar(avatarUrl);
        SPUtils.setUserNickName(nickName);
        SPUtils.setFinishPerfectUserInfo();
        Get.offAll(() => MainHomePage(), arguments: {'isMessageTab': widget.isMessageTab!});
      }
    });
  }
}