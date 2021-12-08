import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:SDZ/base/base_stateful_widget.dart';
import 'package:SDZ/page/shop/page/commit_order/logic.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/widget/double_click.dart';

class CommitOrderPage extends BaseStatefulWidget {
  @override
  BaseStatefulState<BaseStatefulWidget> getState() {
    return CommitOrderPageState();
  }
}

class CommitOrderPageState extends BaseStatefulState {
  int? goodsId;
  int? selectValue;
  String title = '基础版';

  @override
  void initData() {
    goodsId = Get.arguments['goodsId'] as int;
    selectValue = Get.arguments['selectValue'] as int;
    if(selectValue == 1){
      title = '基础版';
    }else if(selectValue == 2){
      title = '中级版';
    }else if(selectValue == 3){
      title = '高级版';
    }
  }

  @override
  String navigatorTitle() {
    return '提交订单';
  }

  @override
  void onDispose() {}

  @override
  Widget initDefaultBuild(BuildContext context) {
    return GetBuilder<CommitOrderLogic>(
        init: CommitOrderLogic(),
        builder: (control) {
          return Container(
            color: Colours.bg_fff4f5f9,
            child: Stack(
              children: [
                Column(children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(2))),
                          child: Row(
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
                                          child: Text(
                                              'SA98726-Zy一刻&突破付哒哒哒哒都是废话出现的',
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
                                                  color: Colours.text_FF475C,
                                                  fontSize: 16)),
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        goodsInfo()
                      ],
                    ),
                  )
                ]),
                Positioned(
                    bottom: 0,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child:
                    DoubleClick(
                      onTap: () {},
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 15, bottom: 30),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colours.text_131313,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(2.0))),
                          height: 45,
                          child: Center(
                            child: Text(
                              '确认并付款',
                              style: TextStyle(color: Colors.white,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          );
        });
  }

  Widget goodsInfo() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 10,right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.all(Radius.circular(2))),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(title,style: TextStyle(color: Colours.text_131313,fontWeight: FontWeight.bold,fontSize:16)),
          SizedBox(height: 20),
          goodsInfoWidget(1),
          Container(
            height: 0.5,
            width: MediaQuery.of(context).size.width,
            color: Colours.color_E7EAED,
          ),
          SizedBox(height: 20),
          Row(children: [
            Text('服务费',style: TextStyle(color: Colours.text_717888,fontSize: 12)),
            Expanded(child:  Text('¥199.00',style: TextStyle(color: Colours.text_131313,fontSize: 12),textAlign: TextAlign.right))
          ]),
          SizedBox(height: 20),
          Row(children: [
            Text('总交货时间',style: TextStyle(color: Colours.text_717888,fontSize: 12)),
            Expanded(child:  Text('1天',style: TextStyle(color: Colours.text_131313,fontSize: 12),textAlign: TextAlign.right))
          ]),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: RichText(
                textAlign: TextAlign.end,
                text: TextSpan(
                    children: [
                      TextSpan(
                        text: '共计   ',
                        style: TextStyle(color: Colours.text_131313, fontSize: 12),
                      ),
                      TextSpan(
                        text: '¥398.00',
                        style: TextStyle(color: Colours.text_FF475C, fontSize: 18),
                      ),
                    ]
                ),
              ))
            ],
          ),
          SizedBox(height: 10),
        ],
      ));
  }

  Widget goodsInfoWidget(int index) {
    Widget rowStyle = Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Text('15天交货',
                  style: TextStyle(color: Colours.text_131313, fontSize: 13,height: 1.5))),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: ImageIcon(
              AssetImage('assets/images/ic_arrow_right.png'),
              color: Colours.text_1BC8CB,
              size: 15,
            ),
          )
        ],
      ),
    );
    return Container(
      child: Column(
        children: [
          rowStyle,
          rowStyle,
          rowStyle,
          rowStyle,
          rowStyle,
        ],
      ),
    );
  }
}
