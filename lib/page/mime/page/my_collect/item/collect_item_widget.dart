import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:SDZ/entity/mime/my_collect_entity.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/router/route_map.dart';
import 'package:SDZ/utils/TagFlowDelegate.dart';
import 'package:SDZ/utils/image_utils.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/widget/common_widgets.dart';
import 'package:SDZ/widget/double_click.dart';

double boxSize = 80.0;

///收藏，关注列表item

class CollectItemWidget extends StatefulWidget {
  final MyCollectEntity entity;
  static int TYPE_COLLECT = 1;
  static int TYPE_TALENT_CARD = 3;
  int itemType = 1; //1：我的收藏 3:达人名片列表
  int? accountId; //达人id
  int? isFilter;

  CollectItemWidget(this.entity, this.itemType,
      {this.isFilter, this.accountId});

  @override
  _CollectItemWidgetState createState() => _CollectItemWidgetState();
}

class _CollectItemWidgetState extends State<CollectItemWidget> {
  String cardTypeStringRightTop = ''; //卡片类型 右上角图片
  String cardTypeString = ''; //卡片类型 缩略图

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.entity.skillTagList != null) {
      listResume.clear();
      for (var value1 in widget.entity.skillTagList!) {
        listResume.add(value1.skillLabel);
      }
    }
    if (widget.entity.skills != null) {
      listResume.clear();
      for (var value1 in widget.entity.skills!) {
        listResume.add(value1.skillLabel);
      }
    }
    listResume.add('···');
    if (widget.entity.cardType == 1) {
      cardTypeStringRightTop = Utils.getSvgUrl('ic_subscript_xiaohongshu.svg');
      cardTypeString = Utils.getSvgUrl('ic_xiaohongshu_square.svg');
    } else if (widget.entity.cardType == 2) {
      cardTypeStringRightTop = Utils.getSvgUrl('ic_subscript_tiktok.svg');
      cardTypeString = Utils.getSvgUrl('ic_tiktok_square.svg');
    } else if (widget.entity.cardType == 3) {
      cardTypeStringRightTop = Utils.getSvgUrl('ic_subscript_taobao.svg');
      cardTypeString = Utils.getSvgUrl('ic_taobao_square.svg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DoubleClick(
      onTap: () {
        Map<String, dynamic> arguments = new Map();
        arguments['accountId'] = widget.accountId == null
            ? widget.entity.accountId
            : widget.accountId;
        arguments['cardId'] = widget.entity.cardId;
        arguments['isFilter'] = widget.isFilter;
        if (widget.itemType == CollectItemWidget.TYPE_COLLECT) {
          arguments['isCollect'] = 1;
        } else {
          arguments['isCollect'] = 0;
        }
        Get.toNamed(RouteMap.talentBusinessCardPage, arguments: arguments);
        // Get.offAllNamed('${RouteMap.talentBusinessCardPage}?cardType=${ widget.entity.cardType}&accountId=${widget.accountId}');
      },
      child: Container(
        child: Container(
            decoration: BoxDecoration(
                color: Colours.dark_bg_color2,
                borderRadius: BorderRadius.circular(12.0)),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 12, top: 12, bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.itemType == CollectItemWidget.TYPE_TALENT_CARD
                              ? SvgPicture.asset(
                                  cardTypeString,
                                  height: 56,
                                  width: 56,
                                )
                              : Container(
                                  width: 60,
                                  height: 60,
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        ImageUtils.getImageProvider(
                                            widget.entity.cardAvatar ?? ''),
                                  ),
                                ),
                          Expanded(
                              child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                    ),
                                    widget.itemType ==
                                            CollectItemWidget.TYPE_TALENT_CARD
                                        ? Container(
                                            width: 28,
                                            height: 28,
                                            margin: EdgeInsets.only(right: 8),
                                            child: CircleAvatar(
                                              radius: 14,
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage:
                                                  ImageUtils.getImageProvider(
                                                      widget.entity
                                                              .cardAvatar ??
                                                          ''),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    Expanded(
                                        child: Text(
                                      widget.entity.cardName ?? '',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 12, top: 10),
                                  child: Flow(
                                    delegate: TagFlowDelegate(
                                        allChildWidth: allChidWidth(),
                                        lineCout: 1,
                                        flowHeight: tagHeight(),
                                        margin: EdgeInsets.only(
                                            right: sWidth(8),
                                            bottom: sWidth(5))),
                                    children: _generateList(listResume),
                                  ),
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: CountTitleWidget(
                                  widget.itemType ==
                                              CollectItemWidget.TYPE_COLLECT ||
                                          widget.itemType ==
                                              CollectItemWidget.TYPE_TALENT_CARD
                                      ? '粉丝'
                                      : '小红书',
                                  widget.entity.fansNum,
                                  "assets/svg/ic_xiaohongshu.svg")),
                          Expanded(
                              flex: 1,
                              child: CountTitleWidget(
                                  widget.itemType ==
                                              CollectItemWidget.TYPE_COLLECT ||
                                          widget.itemType ==
                                              CollectItemWidget.TYPE_TALENT_CARD
                                      ? '获赞与收藏'
                                      : '淘宝逛逛',
                                  widget.entity.likesNum,
                                  "assets/svg/ic_taobao.svg")),
                          Expanded(
                              flex: 1,
                              child: CountTitleWidget(
                                  widget.itemType ==
                                              CollectItemWidget.TYPE_COLLECT ||
                                          widget.itemType ==
                                              CollectItemWidget.TYPE_TALENT_CARD
                                      ? '平均赞数'
                                      : '抖音',
                                  widget.entity.avgLikeNum,
                                  "assets/svg/ic_tiktok.svg")),
                        ],
                      ),
                    ],
                  ),
                ),
                widget.itemType == CollectItemWidget.TYPE_COLLECT
                    ? Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 48,
                          height: 48,
                          child: SvgPicture.asset(
                            cardTypeStringRightTop,
                          ),
                        ))
                    : SizedBox.shrink()
              ],
            )),
      ),
    );
  }

  Widget CountTitleWidget(String title, int count, String icon) {
    return Padding(
      padding: EdgeInsets.only(top: 0),
      child: Column(children: <Widget>[
        Container(
          child: Text(
            Utils.formatterFansNumber(count),
            style: TextStyle(
                color: Colours.bg_ffffff,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.itemType == CollectItemWidget.TYPE_COLLECT ||
                        widget.itemType == CollectItemWidget.TYPE_TALENT_CARD
                    ? SizedBox.shrink()
                    : Container(
                        margin: EdgeInsets.only(right: 4),
                        child: SvgPicture.asset(
                          icon,
                          height: 14,
                          width: 14,
                        ),
                      ),
                Text(title,
                    style: TextStyle(fontSize: 10, color: Colours.text_main))
              ],
            ))
      ]),
    );
  }

  ///标签列表
  List<Widget> _generateList(List<String> list) {
    return list.map((item) => labelWidget(item)).toList();
  }

  double tagHeight() {
    if (listResume.length == 0) {
      return 0;
    }
    Size size = Utils.boundingTextSize(listResume[0],
        TextStyle(color: Colours.bg_ffffff, fontSize: sFontSize(11)));
    return size.height + sWidth(5); //5：上下padding之和
  }

  ///标签样式
  Widget labelWidget(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
              left: sWidth(8),
              right: sWidth(8),
              top: sWidth(2.5),
              bottom: sWidth(2.5)),
          decoration: BoxDecoration(
              color: Colours.color_bg_tag,
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          child: Text(text,
              style:
                  TextStyle(color: Colours.bg_ffffff, fontSize: sFontSize(11))),
        )
      ],
    );
  }

  List<String> listResume = [];

  double allChidWidth() {
    double width = 0;
    Size size;
    for (var value in listResume) {
      size = Utils.boundingTextSize(
          value, TextStyle(color: Colours.bg_ffffff, fontSize: sFontSize(11)));
      width +=
          size.width + sWidth(16) + sWidth(8); //16:标签左右padding之和，8：标签左右margin之和
    }
    return width;
  }
}
