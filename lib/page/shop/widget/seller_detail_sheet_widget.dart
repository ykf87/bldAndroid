import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:SDZ/res/colors.dart';


///商家简介弹窗样式
class SellerDetailSheetWidget extends StatefulWidget {
  @override
  _SellerDetailSheetWidgetState createState() =>
      _SellerDetailSheetWidgetState();
}

class _SellerDetailSheetWidgetState extends State<SellerDetailSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 500),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                //头像
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      backgroundImage: CachedNetworkImageProvider(
                          'https://img1.baidu.com/it/u=2579940132,1296036844&fm=11&fmt=auto&gp=0.jpg'),
                    ),
                    SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '李青峰',
                              style: TextStyle(
                                  color: Colours.text_131313,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Icon(
                              Icons.star,
                              size: 20,
                              color: Colours.text_FFB31E,
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colours.text_FFB31E,
                              size: 15,
                            ),
                            Text(
                              "4.9",
                              style: TextStyle(
                                  color: Colours.text_FFB31E, fontSize: 15),
                            ),
                            Text(
                              "(1.3k)",
                              style: TextStyle(
                                  color: Colours.text_717888, fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 30),
                Text('关于技能卖家',
                    style: TextStyle(
                        color: Colours.text_131313,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                SizedBox(height: 10),
                ItemAboutSeller('所在城市','北京'),
                ItemAboutSeller('服务等级','最高'),
                ItemAboutSeller('交付时间','10天'),
                SizedBox(height: 30),
                Text('基本描述',
                    style: TextStyle(
                        color: Colours.text_131313,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                SizedBox(height: 20),
                Text('我专注于包装设计和品牌推广，我我很乐意与您一起创造一个特别的、'
                    '创新的和令人兴奋的设计，用设计让世界变得更美好是我的宗旨。'
                    '如果您正在寻找具有高端效果的高品质艺术设计，那么您来对地方了，'
                    '迫及待想和你一起工作，如有需要可及时与我联系，期待！',
                    style: TextStyle(
                        color: Colours.text_717888,
                        fontSize: 15,height: 1.5)),
                SizedBox(height: 30),
                Text('综合评分',
                    style: TextStyle(
                        color: Colours.text_131313,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                SizedBox(height: 20),
                ItemScore('技能卖家沟通',5.0),
                ItemScore('技能卖家沟通',5.0),
                ItemScore('技能卖家沟通',5.0),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget ItemAboutSeller(String title,String endTitle) {
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
                Text(title,style: TextStyle(color:Colours.text_131313,fontSize: 14)),
                Expanded(child: Text(endTitle,style: TextStyle(color:Colours.text_131313,fontSize: 14 ),textAlign: TextAlign.end))
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

  Widget ItemScore(String title,double score){
    return Container(
      padding: EdgeInsets.only(top: 10,bottom: 10),
      child:Row(
        children: [
          Expanded(child: Text(title,style: TextStyle(color: Colours.text_131313,fontSize: 15))),
          Icon(
            Icons.star,
            color: Colours.text_FFB31E,
            size: 15,
          ),
          Text(
            '$score',
            style: TextStyle(
                color: Colours.text_FFB31E, fontSize: 15),
          ),
        ],
      ) ,
    );
  }
}
