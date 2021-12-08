import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:SDZ/entity/mime/my_focus_talent_entity.dart';
import 'package:SDZ/page/mime/list/fans_item.dart';
import 'package:SDZ/page/mime/widget/count_title_widget.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/router/route_map.dart';
import 'package:SDZ/utils/TagFlowDelegate.dart';
import 'package:SDZ/utils/image_utils.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/widget/common_widgets.dart';
import 'package:SDZ/widget/double_click.dart';

double boxSize = 80.0;

///关注列表item

class FocusItemWidget extends StatefulWidget {
  final MyFocusTalentEntity entity;
  static int TYPE_FOCUS = 2;
  int itemType = 2;

  FocusItemWidget(this.entity, this.itemType);

  @override
  _FocusItemWidgetState createState() => _FocusItemWidgetState();
}

class _FocusItemWidgetState extends State<FocusItemWidget> {
  String xiaohongshuCount = '0';
  String taobaoCount = '0';
  String douyinCount = '0';
  List<String> listResume = [];
  List<MyFocusTalentCardList> curList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.entity.skillTagList != null) {
      for (var value1 in widget.entity.skillTagList!) {
        listResume.add(value1.skillLabel!);
      }
    }
    listResume.add('···');

    if (widget.entity.cardList != null && widget.entity.cardList?.length != 0) {
      for (var value in widget.entity.cardList!) {
        if (int.parse(value.fansNum ?? '0') != 0) {
          curList.add(value);
        }
      }
      while (curList.length != 3) {
        MyFocusTalentCardList entity = new MyFocusTalentCardList();
        curList.add(entity);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DoubleClick(
      onTap: () {
        Map<String, dynamic> arguments = new Map();
        arguments['accountId'] = widget.entity.accountId;
        arguments['isFilter'] = 1;
        Get.toNamed(RouteMap.talentHomePage, arguments: arguments);
      },
      child: Container(
        child: Container(
            decoration: BoxDecoration(
                color: Colours.dark_bg_color2,
                borderRadius: BorderRadius.circular(12.0)),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 12, top: 12, bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.transparent,
                              backgroundImage: ImageUtils.getImageProvider(
                                  widget.entity.avatar!),
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
                                    Text(widget.entity.nickname!,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: sWidth(12), top: sWidth(10)),
                                  child: Flow(
                                    delegate: TagFlowDelegate(
                                        allChildWidth: allChidWidth(),
                                        lineCout: 1,
                                        flowHeight: tagHeight(),
                                        margin: EdgeInsets.only(
                                            right: sWidth(8), bottom: sWidth(5))),
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
                        children: curList.map((e) {
                          return Expanded(
                              flex: 1,
                              child: CountTitleWidget(e.getCardTypeName(),
                                  e.fansNum ?? '0', e.getCardTypeIcon()));
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget CountTitleWidget(String title, String count, String icon) {
    return Visibility(
      visible: int.parse(count) != 0,
      child: Container(
        width: 117,
        padding: EdgeInsets.only(top: 0),
        child: Column(children: <Widget>[
          Container(
            child: Text(
              Utils.formatterFansNumber(int.parse(count)),
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
                  Container(
                    margin: EdgeInsets.only(right: 4),
                    child: SvgPicture.asset(
                      icon,
                      height: 14,
                      width: 14,
                    ),
                  ),
                  Center(
                    child: Text(title,
                        style:
                            TextStyle(fontSize: 11, color: Colours.text_main)),
                  )
                ],
              ))
        ]),
      ),
    );
  }

  double tagHeight() {
    if (listResume.length == 0) {
      return 0;
    }
    Size size = Utils.boundingTextSize(listResume[0],
        TextStyle(color: Colours.bg_ffffff, fontSize: sFontSize(11)));
    return size.height + sWidth(5); //5：上下padding之和
  }

  ///标签列表
  List<Widget> _generateList(List<String> list) {
    return list.map((item) => labelWidget(item)).toList();
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

  double allChidWidth() {
    double width = 0;
    Size size;
    for (var value in listResume) {
      size = Utils.boundingTextSize(
          value, TextStyle(color: Colours.bg_ffffff, fontSize: sWidth(11)));
      width +=
          size.width + sWidth(16) + sWidth(8); //16:标签左右padding之和，8：标签左右margin之和
    }
    return width;
  }
}
