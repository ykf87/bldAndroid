import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/router/router.dart';
import 'package:SDZ/widget/double_click.dart';

///我的商品 列表样式
class GoodsItem extends StatefulWidget {
  final GoodsEntity entity;

  GoodsItem(this.entity);

  @override
  _State createState() => _State();
}

class _State extends State<GoodsItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // XRouter.goWeb(articleUrl, title);
        ToastUtils.toast("${widget.entity.name}");
      },
      child: Container(
        height: 123,
        decoration: new BoxDecoration(
            color: Colours.bg_ffffff,
            borderRadius: BorderRadius.all(Radius.circular(2.0))),
        margin: EdgeInsets.only(top: 10,right: 10,left: 10),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Image.network(
                "https://img0.baidu.com/it/u=1660668216,3957312586&fm=253&fmt=auto&app=120&f=JPEG?w=360&h=640",
                height: 123,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
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
                              Expanded(
                                  child: Text(
                                "(1.3k)",
                                style: TextStyle(
                                    color: Colours.text_717888, fontSize: 12),
                              )),
                              DoubleClick(
                                onTap: () {
                                  _toggleFoucs();
                                },
                                child: Icon(
                                  widget.entity.isFocus
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colours.text_FF475C,
                                  size: 22,
                                ),
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                "标题两行的显示样式标题两行的显示样式显示样式显示样式显示样式显示",
                                style: TextStyle(
                                    color: Colours.text_131313,
                                    fontSize: 14,
                                    height: 1.5),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ],
                      ),
                    ),
                    Positioned(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "￥200.00",
                              style: TextStyle(
                                  color: Colours.text_FF475C, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      right: 0,
                      bottom: 0,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFoucs() {
    setState(() {
      widget.entity.isFocus = !widget.entity.isFocus;
    });
  }
}

class GoodsEntity {
  String headUrl;

  //昵称
  String name;

  //性别
  int sex; //0:nv 1:nan
  //是否关注
  bool isFocus;

  GoodsEntity(this.headUrl, this.name, this.sex, this.isFocus);
}
