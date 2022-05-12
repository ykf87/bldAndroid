import 'package:SDZ/entity/adIntegral/ad_task_entity.dart';
import 'package:SDZ/env.dart';
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

import 'package:SDZ/page/shop/page/goods_detail/goods_detail_page.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/router/route_map.dart';
import 'package:SDZ/router/router.dart';
import 'package:SDZ/utils/TagFlowDelegate.dart';
import 'package:SDZ/utils/image_utils.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:SDZ/utils/wf_log_util.dart';
import 'package:SDZ/widget/common_widgets.dart';

///激励视频任务
class NewTaskItem extends StatefulWidget {
  final AdTaskEntity entity;
  final bool isOptions;

  NewTaskItem(this.entity, {this.isOptions = false});

  @override
  _State createState() => _State();
}

class _State extends State<NewTaskItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        color: Colours.bg_ffffff,
        boxShadow: [
          BoxShadow(
              color: Colours.color_grey_e5e5e5,
              offset: Offset(0.0, 0.5),
              blurRadius: 0.5,
              spreadRadius: 0.5),
        ],
      ),
      width: double.infinity,
      padding: EdgeInsets.only(left: 8, right: 12, bottom: 14, top: 14),
      margin: EdgeInsets.only(top: 12,left: 12,right: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Utils.getSvgUrl(
              getImg(widget.entity.platform),
            ),
            width: 30,
            height: 30,
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleStr(widget.entity.platform),
                  style: TextStyle(
                      fontSize: 15,
                      color: Colours.color_333333,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                RichText(
                  text: TextSpan(
                      style: TextStyle(fontSize: 12.0, color: Colors.white),
                      text: '',
                      children: [
                        TextSpan(
                          style: TextStyle(
                              fontSize: 12.0, color: Colours.color_343434),
                          text:widget.entity.platform == 3?"最高可获得": '可获得',
                        ),
                        TextSpan(
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colours.color_orange_F1A14B),
                          text: widget.entity.prize.toString(),
                        ),
                        TextSpan(
                          style: TextStyle(
                              fontSize: 12.0, color: Colours.color_343434),
                          text: '省币',
                        ),
                      ]),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  BottomStr(widget.entity.platform),
                  style: TextStyle(fontSize: 12, color: Colours.color_C0C0C0),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Container(
            width: 86,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(colors: [
                Colours.color_orange_F1A14B,
                Colours.color_orange_EB4736,
              ]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Utils.getSvgUrl('ic_coin.svg'),
                  width: 16,
                  height: 16,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  btnStr(widget.entity.platform),
                  style: TextStyle(color: Colours.bg_ffffff, fontSize: 14),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String btnStr(int plateform) {
    if (plateform == 0) {
      return '去分享';
    }
    if (plateform == 1) {
      return '观看';
    }
    if (plateform == 2) {
      return '观看';
    }
    if (plateform == 3) {
      return "拆红包";
    }
    return "看福利视频赚省币";
  }

  String titleStr(int plateform) {
    if (plateform == 0) {
      return '分享给好友赚省币';
    }
    if (plateform == 1) {
      return '看福利视频赚省币(${widget.entity.times}/${widget.entity.max})';
    }
    if (plateform == 2) {
      return '看福利视频赚省币(${widget.entity.times}/${widget.entity.max})';
    }
    if (plateform == 3) {
      return "拆语音红包赚省币(${widget.entity.times}/${widget.entity.max})";
    }
    return "看福利视频赚省币";
  }

  String BottomStr(int plateform) {
    if (plateform == 0) {
      return '完成分享即可';
    }
    if (plateform == 1) {
      return '完成观看视频广告即可';
    }
    if (plateform == 2) {
      return '完成观看视频广告即可';
    }
    if (plateform == 3) {
      return "完成拆语音广告即可";
    }
    return "完成观看视频广告即可";
  }

  String getImg(int plateform) {
    if (plateform == 0) {
      return "ic_task_shared.svg";
    }
    if (plateform == 1) {
      return "ic_task_video1.svg";
    }
    if (plateform == 2) {
      return "ic_task_video2.svg";
    }
    if (plateform == 3) {
      return "ic_task_shop.svg";
    }
    return "ic_task_video.svg";
  }
}
