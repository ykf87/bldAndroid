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
import 'package:SDZ/page/mime/list/fans_item.dart';
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
class TaskItem extends StatefulWidget {
  final AdTaskEntity entity;
  final bool isOptions;

  TaskItem(this.entity, {this.isOptions = false});

  @override
  _State createState() => _State();
}

class _State extends State<TaskItem> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 8,right: 12,bottom: 14,top: 14),
      decoration: BoxDecoration(
        image: DecorationImage(
          // image: AssetImage(getImg(widget.entity.resType)),
          image: AssetImage(widget.entity.resType>4?"assets/images/integral_bg_waterfall_flow_1.png":
          "assets/images/integral_bg_waterfall_flow_${widget.entity.resType}.png"),
          fit:BoxFit.fill,
        )
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.entity.title??'日常任务',style: TextStyle(color: Colors.white,fontSize: 16,),maxLines: 2,overflow:TextOverflow.ellipsis,),
          SizedBox(height: 8,),
          Text("已完成${widget.entity.times}次",style: TextStyle(color: Colors.white,fontSize: 14,),maxLines: 1,overflow:TextOverflow.ellipsis,),
          SizedBox(height: 16,),
          Text("剩余可完成${widget.entity.leftCout()}次",style: TextStyle(color: Colors.white,fontSize: 14,),maxLines: 1,overflow:TextOverflow.ellipsis,),
          SizedBox(height: 12,),
          Container(
            height: 28,
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage("assets/images/ic_video.png"),width: 12,height: 12,),
                SizedBox(width: 4,),
                Text("看视频领${widget.entity.prize}枸币",style: TextStyle(color:widget.entity.getTextColor(),fontSize: 14,),maxLines: 1,overflow:TextOverflow.ellipsis,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getImg(int resType) {
    if (resType == 0) {
      return "assets/images/integral_bg_waterfall_flow_1";
    }
    if (resType == 1) {
      return "assets/images/integral_bg_waterfall_flow_2";
    }
    if (resType == 2) {
      return "assets/images/integral_bg_waterfall_flow_3";
    }
    if (resType == 3) {
      return "assets/images/integral_bg_waterfall_flow_4";
    }
    return "assets/images/integral_bg_waterfall_flow_1";
  }
}
