import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/mime/my_collect_entity.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/TagFlowDelegate.dart';
import 'package:SDZ/utils/umengshare.dart';
import 'package:SDZ/utils/utils.dart';

import '../common_widgets.dart';
import '../double_click.dart';
import 'logic.dart';
import 'state.dart';

class PosterSharedDialogPage extends StatefulWidget {
  int? talentid = 0;
  MyCollectEntity? cardEntity;
  int isFilter;

  PosterSharedDialogPage(this.talentid, this.cardEntity, this.isFilter);

  @override
  _PosterSharedDialogPageState createState() => _PosterSharedDialogPageState();
}

class _PosterSharedDialogPageState extends State<PosterSharedDialogPage> {
  final PosterSharedDialogLogic logic = Get.put(PosterSharedDialogLogic());
  final PosterSharedDialogState state =
      Get.find<PosterSharedDialogLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.QRCodeUrl = '';
    if (widget.cardEntity != null) {
      logic.getCardDetail(widget.cardEntity);
    } else {
      logic.getTalentHomeData(widget.talentid, widget.isFilter);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PosterSharedDialogLogic>(
      init: PosterSharedDialogLogic(),
      builder: (logic) {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RepaintBoundary(
                  key: logic.repaintKey,
                  child: Container(
                    margin: EdgeInsets.only(left: 12, right: 12),
                    padding: EdgeInsets.only(
                        left: 12, right: 12, top: 17, bottom: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular((12)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/bg_poster.png"),
                        )),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                                Utils.getSvgUrl('ic_logo_wefree.svg'),
                                width: 51,
                                height: 20),
                            SizedBox(width: 8),
                            SvgPicture.asset(Utils.getSvgUrl('ic_close.svg'),
                                width: 12, height: 12),
                            SizedBox(width: 8),
                            SvgPicture.asset(
                                Utils.getSvgUrl('ic_text_zhenxiang.svg'),
                                width: 32,
                                height: 17),
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 12, right: 12, top: 44, bottom: 12),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular((12)),
                                  color: Colors.white),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      widget.cardEntity == null
                                          ? logic.pageEntity.nickname ?? ''
                                          : widget.cardEntity!.cardName ?? "",
                                      style: TextStyle(
                                          color: Colours.text_121212,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  // SizedBox(height: 7),
                                  Container(
                                    // height: 30,
                                    margin: EdgeInsets.only(
                                        top: sWidth(8), bottom: sWidth(12)),
                                    child: Flow(
                                      delegate: TagFlowDelegate(
                                          allChildWidth: allChidWidth(),
                                          lineCout: 1,
                                          flowHeight: tagHeight(),
                                          margin: EdgeInsets.only(
                                              right: sWidth(8),
                                              bottom: sWidth(8))),
                                      children: tagList(state.listResume),
                                    ),
                                  ),
                                  // SizedBox(height: 7),
                                  // Text(
                                  //   "标签：" + getTagStr(state.listResume),
                                  //   style: TextStyle(color: Colors.red),
                                  // ),
                                  // SizedBox(height: 7),
                                  listWidget(),
                                  Row(
                                    children: [
                                      CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          width: 72,
                                          height: 72,
                                          imageUrl: Utils.QRCodeUrl),
                                      SizedBox(width: 3),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('长按扫码查看详情',
                                              style: TextStyle(
                                                  color: Colours.text_121212,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 4),
                                          Text(
                                            '新媒体数字营销、商家推广；博主接单变现',
                                            style: TextStyle(
                                                color: Colours.text_main,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                                top: -36,
                                child: CircleAvatar(
                                  radius: 36,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: CachedNetworkImageProvider(
                                      widget.cardEntity == null
                                          ? logic.pageEntity.avatar ?? ''
                                          : widget.cardEntity!.cardAvatar ??
                                              ''),
                                ))
                          ],
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 12),
              bottomSharedWidget(context)
            ],
          ),
        );
      },
    );
  }

//分享弹窗
  Widget bottomSharedWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colours.dark_bg_color2,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      margin: EdgeInsets.only(left: 12, right: 12),
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 500),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  height: 100,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.68,
                    ),
                    children: state.list.map((item) {
                      return DoubleClick(
                        onTap: () {
                          if (item.name.contains('微信')) {
                            logic.onCaputrePicture(
                                logic.DEAI_PICTURE_TYPE_SHARED,
                                sharedPlatform: logic.SHARED_TYPE_WECHAT);
                          } else if (item.name.contains('朋友圈')) {
                            logic.onCaputrePicture(
                                logic.DEAI_PICTURE_TYPE_SHARED,
                                sharedPlatform: logic.SHARED_TYPE_MOMENTS);
                          } else if (item.name.contains('保存')) {
                            logic.savePicture();
                          }
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(item.url, width: 60, height: 60),
                              SizedBox(height: 12),
                              Text(item.name)
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 2,
                  width: double.infinity,
                  child: Divider(color: Colours.color_dialog_line),
                ),
                DoubleClick(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      height: 60,
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: Colours.dark_bg_color2,
                      child: Text('取消',
                          style: TextStyle(color: Colors.white, fontSize: 16))),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

//平台信息列表
  Widget listWidget() {
    if (logic.cardList.length == 0) {
      return Container();
    }

    final Widget listView = ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: logic.cardList.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          height: 76,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colours.bg_f9f9f9),
          child: Row(
            children: [
              SizedBox(width: 12),
              SvgPicture.asset(
                logic.cardList[index].geSquareCardIcon(),
                width: 52,
                height: 52,
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Utils.formatterNumber(logic.cardList[index].fansNum),
                          style: TextStyle(
                              color: Colours.text_121212,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('粉丝',
                          style: TextStyle(
                              color: Colours.text_main, fontSize: 10)),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          Utils.formatterNumber(logic.cardList[index].likesNum),
                          style: TextStyle(
                              color: Colours.text_121212,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('获赞与收藏',
                          style: TextStyle(
                              color: Colours.text_main, fontSize: 10)),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          Utils.formatterNumber(
                              logic.cardList[index].avgLikeNum),
                          style: TextStyle(
                              color: Colours.text_121212,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('平均赞数',
                          style: TextStyle(
                              color: Colours.text_main, fontSize: 10)),
                    ],
                  )),
            ],
          ),
        );
      },
      // itemBuilder: (context, index) => item,
    );
    return Container(
      child: listView,
    );
  }

  String getTagStr(List<String> list) {
    var list2 = list.toString();
    return list2;
  }

  ///标签列表
  List<Widget> tagList(List<String> list) {
    var list2 = list.map((item) => labelWidget(item)).toList();
    return list2;
  }

  ///标签样式
  Widget labelWidget(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 6),
          // height: 24,
          alignment: Alignment.center,
          padding: EdgeInsets.only(
              left: sWidth(8),
              right: sWidth(8),
              top: sWidth(2.5),
              bottom: sWidth(2.5)),
          decoration: BoxDecoration(
              color: Colours.bg_ffffff,
              border: Border.all(color: Colours.color_D8DBE9, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          child: Text(text,
              style:
                  TextStyle(color: Colours.text_main, fontSize: sFontSize(10))),
        )
      ],
    );
  }

  double allChidWidth() {
    double width = 0;
    Size size;
    for (var value in state.listResume) {
      size = Utils.boundingTextSize(
          value, TextStyle(color: Colours.bg_ffffff, fontSize: sFontSize(10)));
      width += size.width +
          sWidth(16) +
          sWidth(8) +
          0.5 * 2; //16:标签左右padding之和，8：标签左右margin之和
    }
    return width;
  }

  double tagHeight() {
    if (state.listResume.length == 0) {
      return 0;
    }
    Size size = Utils.boundingTextSize(state.listResume[0],
        TextStyle(color: Colours.text_main, fontSize: sFontSize(10)));
    return size.height + sWidth(5) + 0.5 * 2; //5：上下padding之和
  }
}
