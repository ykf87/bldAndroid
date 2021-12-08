import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:SDZ/constant/svg_path.dart';
import 'package:SDZ/core/http/http.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/mime/my_browse_record_entity.dart';
import 'package:SDZ/entity/mime/my_collect_entity.dart';
import 'package:SDZ/entity/mime/my_focus_talent_entity.dart';
import 'package:SDZ/page/mime/list/fans_item.dart';
import 'package:SDZ/page/mime/page/my_focus_talent/view.dart';
import 'package:SDZ/page/shop/page/goods_detail/goods_detail_page.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/router/route_map.dart';
import 'package:SDZ/router/router.dart';
import 'package:SDZ/utils/TagFlowDelegate.dart';
import 'package:SDZ/utils/image_utils.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/utils/wf_log_util.dart';
import 'package:SDZ/widget/common_widgets.dart';

///浏览足迹
class BrowseRecordsItem extends StatefulWidget {
  final MyBrowseRecordEntity entity;
  final bool isOptions;

  BrowseRecordsItem(this.entity, {this.isOptions = false});

  @override
  _State createState() => _State();
}

class _State extends State<BrowseRecordsItem> {
  GlobalKey _ImageKey = GlobalKey();
  List<MyBrowseRecordSkillTagList> skillList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          // XRouter.goWeb(articleUrl, title);
          Map<String, dynamic> arguments = new Map();
          arguments['accountId'] = widget.entity.accountId;
          arguments['isFilter'] = widget.isOptions ? 1 : 0;
          Get.toNamed(RouteMap.talentHomePage, arguments: arguments);
        },
        child: Container(
          decoration: new BoxDecoration(
              color: Colours.dark_bg_color2,
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0)),
                      child:
                      // Image(
                      //   key: _ImageKey,
                      //   width: double.infinity,
                      //   fit: BoxFit.fill,
                      //   image: CachedNetworkImageProvider(
                      //       Utils.getBigImage(widget.entity)),
                      // )
                      CachedNetworkImage(
                          fit: BoxFit.fill,
                          width: double.infinity,
                          placeholder: (context, url) => Container(
                            height: 100,
                            child: Center(
                                child: Container(
                                  width: 52,
                                  height: 37,
                                  child: SvgPicture.asset(
                                      SvgPath.ic_logo_placeholder),
                                )),
                          ),
                          imageUrl: Utils.getBigImage(widget.entity))),
                  widget.entity.cardList?.length == 0
                      ? SizedBox.shrink()
                      : Positioned(
                      bottom: 8,
                      left: 8,
                      right: 0,
                      child: Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.entity.cardList?.length,
                            reverse: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return platformItem(
                                  widget.entity.cardList![index]);
                            }),
                      ))
                ],
              ),
              widget.entity.introduce == null ||
                  widget.entity.introduce?.length == 0
                  ? SizedBox.shrink()
                  : Padding(
                padding: EdgeInsets.only(top: 8, left: 8, right: 10),
                child: Text(
                  widget.entity.introduce ?? '',
                  style: TextStyle(
                      color: Colours.bg_ffffff,
                      fontSize: 12,
                      height: 1.5),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8, left: 8, bottom: 8),
                child: Flow(
                  delegate: TagFlowDelegate(
                      allChildWidth: allChidWidth(),
                      lineCout: 2,
                      flowHeight: tabHeight(), //5:标签bottom
                      margin: EdgeInsets.only(
                          left: sWidth(8), bottom: sWidth(8))),
                  children: _generateList(),
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 8),
                  Container(
                    width: 16,
                    height: 16,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.transparent,
                      backgroundImage: ImageUtils.getImageProvider(
                          widget.entity.avatar ?? ''),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: Text(
                        widget.entity.nickname ?? '',
                        style: TextStyle(color: Colours.text_main, fontSize: 11),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
                ],
              ),
              SizedBox(
                height: 12,
              )
            ],
          ),
        ),
      ),
    );
  }

  /// 标签所有宽度之和
  double allChidWidth() {
    addSkillList();
    double width = 0;
    if (skillList.length == 0) {
      return width;
    }
    Size size;
    for (int i = 0; i < skillList.length - 1; i++) {
      size = Utils.boundingTextSize(skillList[i].skillLabel,
          TextStyle(color: Colours.bg_ffffff, fontSize: sFontSize(10)));
      width +=
          size.width + sWidth(16) + sWidth(8); //16:标签左右padding之和，6：标签左右margin之和
    }
    return width; //20：最后一个标签（...）的宽度
  }

  double tabHeight() {
    addSkillList();
    if (skillList.length == 0) {
      return 0;
    }
    Size size = Utils.boundingTextSize(skillList[0].skillLabel,
        TextStyle(color: Colours.bg_ffffff, fontSize: sFontSize(10)));
    return size.height + sWidth(5); //5：上下padding之和
  }

  ///标签列表
  List<Widget> _generateList() {
    addSkillList();
    if (skillList == null) {
      return [];
    }
    return skillList.map((item) => labelWidget(item)).toList();
  }

  ///标签样式
  Widget labelWidget(MyBrowseRecordSkillTagList skillEntity) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: EdgeInsets.only(
                left: sWidth(8),
                right: sWidth(8),
                top: sWidth(2),
                bottom: sWidth(2)),
            decoration: BoxDecoration(
                color: Colours.color_bg_tag,
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            child: Text(skillEntity.skillLabel!,
                style: TextStyle(
                    color: Colours.text_858999, fontSize: sFontSize(10))))
      ],
    );
  }

  //名片列表item
  Widget platformItem(MyCollectEntity item) {
    if (item == null) return Container();
    String cardTypeUrl = 'assets/svg/ic_tiktok.svg';
    switch (item.cardType) {
      case 2:
        cardTypeUrl = Utils.getSvgUrl('ic_tiktok.svg');
        break;
      case 1:
        cardTypeUrl = Utils.getSvgUrl('ic_xiaohongshu.svg');
        break;
      case 3:
        cardTypeUrl = Utils.getSvgUrl('ic_taobao.svg');
        break;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colours.color_66121212,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.only(right: 5),
          height: 22,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 1,
              ),
              SvgPicture.asset(cardTypeUrl, height: 20, width: 20),
              SizedBox(
                width: 4,
              ),
              Container(
                  constraints: BoxConstraints(
                    maxWidth: 100,
                  ),
                  child: Text(
                    Utils.formatterFansNumber(item.fansNum),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ))
            ],
          ),
        )
      ],
    );
  }

  void addSkillList() {
    skillList.clear();
    if (widget.entity.skillTagList != null) {
      skillList.addAll(widget.entity.skillTagList!);
    }
    MyBrowseRecordSkillTagList entity = new MyBrowseRecordSkillTagList();
    entity.skillLabel = '···';
    entity.skillId = 0;
    skillList.add(entity);
  }
}
