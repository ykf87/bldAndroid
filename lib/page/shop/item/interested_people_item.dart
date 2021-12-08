import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SDZ/core/http/http.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/page/shop/page/goods_detail/goods_detail_page.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/router/router.dart';
import 'package:SDZ/widget/double_click.dart';

import '../../index.dart';

///商店 商品列表样式
class InterestedPeopleItem extends StatefulWidget {
  final InterestedEntity entity;

  InterestedPeopleItem(this.entity);

  @override
  _State createState() => _State();
}

class _State extends State<InterestedPeopleItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      child: InkWell(
          onTap: () {
            // XRouter.goWeb(articleUrl, title);
            Get.to(GoodsDetailPage());
          },
          child: Card(
            shadowColor: Colours.text_1a717888,
            elevation: 1.5,
            child: Container(
              margin: EdgeInsets.only(top: 2, bottom: 2, left: 2),
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image(
                      height: 70,
                      width: 70,
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(
                          "https://img1.baidu.com/it/u=2579940132,1296036844&fm=11&fmt=auto&gp=0.jpg"),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "名字最长显示名字最长显示范…",
                    style: TextStyle(
                      color: Colours.text_131313,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 20),
                  Text("你可能感兴趣",
                      style: TextStyle(
                        color: Colours.text_A0A4B1,
                        fontSize: 12,
                      )),
                  SizedBox(height: 15),
                  DoubleClick(
                    onTap: () {
                      _toggleFoucs();
                    },
                    child: Container(
                      height: 30,
                      width: 64,
                      decoration: new BoxDecoration(
                        color: widget.entity.isFocus
                            ? Colours.bg_ffffff
                            : Colours.text_1BC8CB,
                        border: widget.entity.isFocus
                            ? Border.all(color: Colours.text_F4F5F9, width: 1)
                            : null, //边框
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          widget.entity.isFocus
                              ? SizedBox.shrink()
                              : Icon(
                                  Icons.add,
                                  color: Colours.bg_ffffff,
                                  size: 15,
                                ),
                          Text(widget.entity.isFocus ? "已关注" : "关注",
                              style: TextStyle(
                                  color: widget.entity.isFocus
                                      ? Colours.text_131313
                                      : Colors.white,
                                  fontSize: 12))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  void _toggleFoucs() {
    setState(() {
      widget.entity.isFocus = !widget.entity.isFocus;
    });
  }
}

class InterestedEntity {
  String headUrl;

  //昵称
  String name;

  //性别
  int sex; //0:nv 1:nan
  //是否关注
  bool isFocus;

  InterestedEntity(this.headUrl, this.name, this.sex, this.isFocus);
}
