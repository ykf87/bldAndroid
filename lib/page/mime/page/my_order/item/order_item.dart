import 'package:SDZ/page/mime/entity/order_entity.dart';
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

///订单item
class OrderItem extends StatefulWidget {
  final OrderList entity;
  final bool isOptions;

  OrderItem(this.entity, {this.isOptions = false});

  @override
  _State createState() => _State();
}

class _State extends State<OrderItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 120,
        padding: EdgeInsets.only(left: 16, right: 16),
        margin: EdgeInsets.only(bottom: 20),
        decoration: new BoxDecoration(
            color: Colours.bg_ffffff,
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Container(
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      width: 100,
                      height: 100,
                      imageUrl:
                          widget.entity.cover??'')),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(widget.entity.proTitle ?? '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colours.color_333333,
                                fontWeight: FontWeight.bold),
                            maxLines: 2),
                      ),
                      Text(widget.entity.status ?? '',
                          style: TextStyle(
                              fontSize: 14, color: Colours.color_main_red),
                          maxLines: 1),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('￥${widget.entity.price}',
                      style:
                          TextStyle(fontSize: 12, color: Colours.color_999999),
                      maxLines: 1),
                  SizedBox(
                    height: 10,
                  ),
                  widget.entity.kuaidiNum != null? Expanded(child: Row(
                    children: [
                      Text('快递单号：',
                          style: TextStyle(
                              fontSize: 12, color: Colours.color_999999),
                          maxLines: 1),
                    Expanded(child:   Text(widget.entity.kuaidiNum ?? '',
                        style: TextStyle(
                            fontSize: 12, color: Colours.color_999999),
                        maxLines: 1)),
                      GestureDetector(
                          onTap: (){
                            Utils.copy(widget.entity.kuaidiNum ?? '');
                          },
                          child: SvgPicture.asset(Utils.getSvgUrl('ic_copy_order.svg'),width: 20,height: 20,))
                    ],
                  )):Container()
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
