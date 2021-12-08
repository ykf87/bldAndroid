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
class ShopGoodsItem extends StatefulWidget {
  final ShopEntity entity;

  ShopGoodsItem(this.entity);

  @override
  _State createState() => _State();
}

class _State extends State<ShopGoodsItem> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      child: InkWell(
        onTap: () {
          // XRouter.goWeb(articleUrl, title);
          Get.to(GoodsDetailPage());
        },
        child: Container(
          decoration: new BoxDecoration(
              color: Colours.bg_ffffff,
              borderRadius: BorderRadius.all(Radius.circular(2.0))),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image(
                  height: 135,
                  fit: BoxFit.fill,
                  image: CachedNetworkImageProvider( "https://img1.baidu.com/it/u=2579940132,1296036844&fm=11&fmt=auto&gp=0.jpg"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colours.text_FFB31E,
                      size: 15,
                    ),
                    Text(
                      "4.9",
                      style: TextStyle(color: Colours.text_FFB31E, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                          "(1.3k)",
                          style: TextStyle(color: Colours.text_717888, fontSize: 12),
                        )),
                    DoubleClick(
                      onTap: () {
                        _toggleFoucs();
                      },
                      child: Icon(
                        widget.entity.isFocus ? Icons.star : Icons.star_border,
                        color: Colours.text_FF475C,
                        size: 22,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Text(
                    "标题两行的显示样式标题两行的显示样式显示样式显示样式显示样式显示",
                    style: TextStyle(
                        color: Colours.text_131313, fontSize: 14, height: 1.5),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "￥200.00",
                      style: TextStyle(color: Colours.text_FF475C, fontSize: 16),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    )
    ;
  }

  void _toggleFoucs() {
    setState(() {
      widget.entity.isFocus = !widget.entity.isFocus;
    });
  }
}

class ShopEntity {
  String headUrl;

  //昵称
  String name;

  //性别
  int sex; //0:nv 1:nan
  //是否关注
  bool isFocus;

  ShopEntity(this.headUrl, this.name, this.sex, this.isFocus);
}
