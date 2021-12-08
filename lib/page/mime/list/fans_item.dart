import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/router/router.dart';
import 'package:SDZ/widget/double_click.dart';
///我的粉丝 我的关注 列表样式
class FansItem extends StatefulWidget {
  final FansEntity entity;

  FansItem(this.entity);

  @override
  _State createState() => _State();
}

class _State extends State<FansItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // XRouter.goWeb(articleUrl, title);
        ToastUtils.toast("${widget.entity.name}");
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                        CachedNetworkImageProvider(widget.entity.headUrl),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        widget.entity.name,
                        style: TextStyle(
                          color: Colours.text_131313,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Image(
                      image: AssetImage("assets/images/ic_next.png"),
                      width: 25,
                      height: 25,
                    ),
                  ],
                )),
            DoubleClick(
              onTap: () {
                _toggleFoucs();
              },
              child: widget.entity.isFocus ? Container(
                width: 64,
                height: 30,
                decoration: new BoxDecoration(
                    border: Border.all(color: Colours.color_E7EAED,width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(2.0))),
                child: Center(
                  child: Text(
                    "已关注",
                    style: TextStyle(color: Colours.text_717888, fontSize: 12),
                  ),
                ),
              ) : Container(
                width: 64,
                height: 30,
                decoration: new BoxDecoration(
                    color: Colours.text_131313,
                    borderRadius: BorderRadius.all(Radius.circular(2.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.entity.isFocus
                        ? SizedBox.shrink()
                        : Image(
                      image:
                      AssetImage("assets/images/ic_next.png"),
                      width: 20,
                      height: 20,
                    ),
                    Text(
                      widget.entity.isFocus ? "已关注" : "关注",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                ),
              ),
            )
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

class FansEntity {
  String headUrl;

  //昵称
  String name;

  //性别
  int sex; //0:nv 1:nan
  //是否关注
  bool isFocus;

  FansEntity(this.headUrl, this.name, this.sex, this.isFocus);
}
