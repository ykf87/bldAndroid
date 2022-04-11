import 'dart:math';

import 'package:SDZ/constant/svg_path.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/custom_textinput_formatter.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/widget/double_click.dart';
import 'package:SDZ/widget/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'logic.dart';


class AddressPage extends StatefulWidget {
  int taskId = 0;
  AddressPage({Key? key,required this.taskId}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final logic = Get.put(AddressLogic());
  final state = Get.find<AddressLogic>().state;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("TTTTT===${widget.taskId}");
    logic.taskId = widget.taskId;
    logic.setCSJAdEvent();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressLogic>(
      init: AddressLogic(),
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('奖品领取',
                style: TextStyle(color: Colours.color_333333, fontSize: 20)),
            leading: IconButton(
              color: Colors.black,
              tooltip: null,
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios_outlined),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
          ),
          body: GetBuilder<AddressLogic>(
            init: AddressLogic(),
            builder: (logic) {
              return MyScrollView(
                  children:[ Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('收货人',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
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
                        controller: logic.nameController,
                        cursorColor: Colours.text_main,
                        onChanged: (value) {
                          logic.onTextChange();
                        },
                        maxLines: 1,
                        maxLength: 20,
                        style: TextStyle(
                            color: Colours.color_333333, fontSize: 15.0),
                        decoration: InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            hintText: '请输入您的姓名',
                            hintStyle: TextStyle(fontSize: 15, color: Colours.color_858999, textBaseline: TextBaseline.alphabetic),
                            contentPadding: EdgeInsets.only(
                                left: 8)),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colours.color_fbfcfd)),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text('联系方式',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
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
                          logic.onTextChange();
                        },
                        maxLines: 1,
                        maxLength: 20,
                        style: TextStyle(
                            color: Colours.color_333333, fontSize: 15.0),
                        decoration: InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            hintText: '请输入您的联系方式',
                            hintStyle: TextStyle(fontSize: 15, color: Colours.color_858999, textBaseline: TextBaseline.alphabetic),
                            contentPadding: EdgeInsets.only(
                                left: 8)),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colours.color_fbfcfd)),
                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      Text('详细地址',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colours.text_main,
                              fontSize: 16)),
                      SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset(Utils.getSvgUrl('ic_asterisk.svg'),width: 8,height: 8,)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DoubleClick(
                    onTap: (){
                      logic.selAddress(context);
                    },
                    child: Container(
                        padding: EdgeInsets.only(left: 8),
                        height: 48,
                        child: Row(
                          children: [
                            Expanded(
                              child:  Text(logic.area,textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      fontSize: 15.00)),
                            ),
                            Container(
                              child:  Image(
                                image: AssetImage("assets/images/ic_next.png"),
                                width: 20,
                                height: 20,
                                color: Colours.color_black45,
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colours.color_fbfcfd)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 48,
                      child: TextField(
                        style: TextStyle(
                            color: Colours.color_333333, fontSize: 15.0),
                        enableInteractiveSelection: true,
                        onChanged: (value) {
                          logic.onTextChange();
                        },
                        maxLines: 1,
                        cursorColor: Colours.text_main,
                        controller: logic.addressController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 15, color: Colours.color_858999, textBaseline: TextBaseline.alphabetic),
                            contentPadding: EdgeInsets.all(8),
                            hintText: '请输入详细地址'),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colours.color_fbfcfd)),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text('备注',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colours.text_main,
                              fontSize: 16)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 48,
                      child: TextField(
                        controller: logic.remarkController,
                        cursorColor: Colours.text_main,
                        onChanged: (value) {
                          logic.onTextChange();
                        },
                        maxLines: 1,
                        maxLength: 20,
                        style: TextStyle(
                            color: Colours.color_333333, fontSize: 15.0),
                        decoration: InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            hintText: '备注',
                            hintStyle: TextStyle(fontSize: 15, color: Colours.color_858999, textBaseline: TextBaseline.alphabetic),
                            contentPadding: EdgeInsets.only(
                                left: 8)),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colours.color_fbfcfd)),
                ],
              ),],
                  padding: EdgeInsets.only(left: 16,right: 16),
                  bottomButton:  GestureDetector(
                    onTap: () {
                      if(!logic.isEnable){
                        return;
                      }
                      if(!Utils.isMobile(logic.phoneController.text)){
                        ToastUtils.toast("请输入正确的手机号");
                        return;
                      }
                      logic.showAd(context);
                    },
                    onDoubleTap: (){

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
                              : Colours.color_fbfcfd,
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                  ));
            },
          ),
        );
      },
    );
  }
}

