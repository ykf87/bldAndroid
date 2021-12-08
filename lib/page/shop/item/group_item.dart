import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
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
class GroupItem extends StatefulWidget {
  final GroupItemEntity entity;

  GroupItem(this.entity);

  @override
  _State createState() => _State();
}

class _State extends State<GroupItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
          child: Container(
            padding:
            EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image(
                    height: 50,
                    width: 50,
                    fit: BoxFit.fill,
                    image: CachedNetworkImageProvider(
                        "https://img1.baidu.com/it/u=2579940132,1296036844&fm=11&fmt=auto&gp=0.jpg"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("短视频剪辑爱好者",style: TextStyle(color: Colours.text_131313,fontSize: 15),maxLines: 1,overflow:TextOverflow.ellipsis),
                    SizedBox(height: 10),
                    Text("每天剪一片，剪出一片天",style: TextStyle(color: Colours.text_717888,fontSize: 12),maxLines: 1,overflow:TextOverflow.ellipsis)

                  ],
                )),
                SizedBox(width: 20),
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
                        Text(widget.entity.isFocus ? "已加入" : "加入",
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
          )),
    );
  }

  void _toggleFoucs() {
    setState(() {
      widget.entity.isFocus = !widget.entity.isFocus;
    });
  }
}

class GroupItemEntity {
  String headUrl;

  //昵称
  String name;

  //性别
  int sex; //0:nv 1:nan
  //是否关注
  bool isFocus;

  GroupItemEntity(this.headUrl, this.name, this.sex, this.isFocus);
}
