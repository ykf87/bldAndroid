import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/custom_textinput_formatter.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/widget/double_click.dart';

import 'logic.dart';
import 'state.dart';

class FeedBackPage extends StatefulWidget {
  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  final Feed_backLogic logic = Get.put(Feed_backLogic());
  final Feed_backState state = Get.find<Feed_backLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.phoneController.text = SPUtils.getUserAccount();
    logic.phone = SPUtils.getUserAccount();
  }

  @override
  Widget build(BuildContext context) {
    return   GetBuilder<Feed_backLogic>(
      init: Feed_backLogic(),
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('意见反馈',
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
          body: GetBuilder<Feed_backLogic>(
            init: Feed_backLogic(),
            builder: (logic) {
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text('问题或意见',
                                      style: TextStyle(
                                          color: Colours.text_main,
                                          fontSize: 16)),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  SvgPicture.asset(Utils.getSvgUrl('ic_asterisk.svg'),width: 8,height: 8,)
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 200,
                                  child: TextField(
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.0),
                                    enableInteractiveSelection: true,
                                    onChanged: (value) {
                                      logic.feedBackContent = value;
                                      logic.onTextChange();
                                    },
                                    maxLines: 10,
                                    maxLength: 500,
                                    cursorColor: Colours.text_main,
                                    decoration: InputDecoration(
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(fontSize: 15, color: Colours.color_3E414B, textBaseline: TextBaseline.alphabetic),
                                        contentPadding: EdgeInsets.all(8),
                                        hintText: '请输入问题或意见'),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colours.dark_bg_color2)),
                              SizedBox(
                                height: 28,
                              ),
                              Row(
                                children: [
                                  Text('联系方式',
                                      style: TextStyle(
                                          color: Colours.text_main,
                                          fontSize: 16)),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  SvgPicture.asset(Utils.getSvgUrl('ic_asterisk.svg'),width: 8,height: 8,)
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 48,
                                  child: TextField(
                                    controller: logic.phoneController,
                                    cursorColor: Colours.text_main,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(11),
                                      CustomTextInputFormatter(
                                        filterPattern: RegExp("[0-9]"),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      logic.phone = value;
                                      logic.onTextChange();
                                    },
                                    maxLines: 1,
                                    maxLength: 20,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.0),
                                    decoration: InputDecoration(
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: '请输入您的联系方式',
                                        hintStyle: TextStyle(fontSize: 15, color: Colours.color_3E414B, textBaseline: TextBaseline.alphabetic),
                                        contentPadding: EdgeInsets.only(
                                            left: 8)),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colours.dark_bg_color2)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 20,
                    child: DoubleClick(
                      onTap: () {
                        if (logic.feedBackContent.length == 0) {
                          ToastUtils.toast('请填写你的问题或意见');
                          return;
                        }
                        if (logic.phone.length == 0) {
                          ToastUtils.toast('请填写您的联系方式');
                          return;
                        }
                        logic.feedbak(logic.feedBackContent, logic.phone);
                      },
                      child: Container(
                          height: 45,
                          margin: EdgeInsets.only(
                              left: 4, right: 4, top: 4, bottom: 40),
                          child: Center(
                            child: Text(
                              '提交',
                              style: TextStyle(
                                  color: logic.isEnable
                                      ? Colors.white
                                      : Colours.text_main,
                                  fontSize: 16),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: logic.isEnable
                                ? Colours.color_main_red
                                : Colours.color_btn_nor,
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
