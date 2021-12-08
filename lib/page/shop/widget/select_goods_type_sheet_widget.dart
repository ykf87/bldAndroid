import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/widget/double_click.dart';

///选择商品规格弹窗样式
class SelectGoodsTypeSheetWidget extends StatefulWidget {
  final Function(int value) onSelect;
  int selcetValue;

  SelectGoodsTypeSheetWidget({Key? key, required this.onSelect, this.selcetValue = 1})
      : super(key: key);

  @override
  _SelectGoodsTypeSheetWidgetState createState() =>
      _SelectGoodsTypeSheetWidgetState();
}

class _SelectGoodsTypeSheetWidgetState
    extends State<SelectGoodsTypeSheetWidget> {
  var baseValue = 1; //基础版
  var middleValue = 2; //中极版
  var seniorValue = 3; //高级版

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 600),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl:
                            'https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640',
                        width: 100,
                        height: 100),
                    SizedBox(width: 15),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      height: 100,
                      child: Stack(
                        children: [
                          Align(
                            child: Text('SA98726-Zy一刻&突破付哒哒哒哒都是废话出现的',
                                style: TextStyle(
                                    color: Colours.text_131313,
                                    fontSize: 15,
                                    height: 1.5),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text('¥199.00',
                                style: TextStyle(
                                    color: Colours.text_FF475C, fontSize: 16)),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
                SizedBox(height: 30),
                Text('服务规格',
                    style: TextStyle(
                        color: Colours.text_131313,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                SizedBox(height: 20),
                Row(
                  children: [
                    DoubleClick(
                      onTap: () {
                        setState(() {
                          widget.selcetValue = baseValue;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: baseValue == widget.selcetValue
                                ? null
                                : Border.all(
                                    color: Colours.color_E7EAED, width: 1),
                            color: baseValue == widget.selcetValue
                                ? Colours.text_1BC8CB
                                : Colours.bg_ffffff,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0))),
                        height: 35,
                        width: 82,
                        child: Center(
                          child: Text(
                            '基础版',
                            style: TextStyle(
                                color: baseValue == widget.selcetValue
                                    ? Colors.white
                                    : Colours.text_717888,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    DoubleClick(
                      onTap: () {
                        setState(() {
                          widget.selcetValue = middleValue;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: middleValue == widget.selcetValue
                                ? null
                                : Border.all(
                                    color: Colours.color_E7EAED, width: 1),
                            color: middleValue == widget.selcetValue
                                ? Colours.text_1BC8CB
                                : Colours.bg_ffffff,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0))),
                        height: 35,
                        width: 82,
                        child: Center(
                          child: Text(
                            '中级版',
                            style: TextStyle(
                                color: middleValue == widget.selcetValue
                                    ? Colors.white
                                    : Colours.text_717888,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    DoubleClick(
                      onTap: () {
                        setState(() {
                          widget.selcetValue = seniorValue;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: seniorValue == widget.selcetValue
                                ? null
                                : Border.all(
                                    color: Colours.color_E7EAED, width: 1),
                            color: seniorValue == widget.selcetValue
                                ? Colours.text_1BC8CB
                                : Colours.bg_ffffff,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0))),
                        height: 35,
                        width: 82,
                        child: Center(
                          child: Text(
                            '高级版',
                            style: TextStyle(
                                color: seniorValue == widget.selcetValue
                                    ? Colors.white
                                    : Colours.text_717888,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                DoubleClick(
                  onTap: () {
                    Navigator.pop(context);
                    widget.onSelect.call(widget.selcetValue);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colours.text_131313,
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    height: 45,
                    child: Center(
                      child: Text(
                        '确定',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget ItemAboutSeller(String title, String endTitle) {
    return Container(
      height: 60,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Row(
              children: [
                Image(
                  image: AssetImage("assets/images/testi.png"),
                  width: 20,
                  height: 20,
                  color: Colors.black,
                ),
                SizedBox(width: 12),
                Text(title,
                    style: TextStyle(color: Colours.text_131313, fontSize: 14)),
                Expanded(
                    child: Text(endTitle,
                        style:
                            TextStyle(color: Colours.text_131313, fontSize: 14),
                        textAlign: TextAlign.end))
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 0.5,
              margin: EdgeInsets.only(left: 34),
              color: Colours.color_E7EAED,
            ),
          )
        ],
      ),
    );
  }
}
