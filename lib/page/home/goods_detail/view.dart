import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_status.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/api/jtk_api.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/waimai/goods_link_entity.dart';
import 'package:SDZ/generated/i18n.dart';
import 'package:SDZ/page/home/widget/banner.dart';
import 'package:SDZ/page/home/widget/topic_carousel.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/image_util.dart';
import 'package:SDZ/widget/extended_image.dart';
import 'package:SDZ/widget/loading_widget.dart';
import 'package:SDZ/widget/no_shadow_croll_ehavior.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class GoodsDetailPage extends StatefulWidget {

  String? goodsId;
  String? source;

  GoodsDetailPage({Key? key,this.goodsId,this.source});

  @override
  _GoodsDetailPageState createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {
  final GoodsDetailLogic logic = Get.put(GoodsDetailLogic());
  final GoodsDetailState state = Get.find<GoodsDetailLogic>().state;
  GoodsLinkEntity? info;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // const SizedBox(
        //   width: double.infinity,
        //   height: double.infinity,
        //   child: BlurHash(hash: 'LgJQ[]~o%0V?tixvNHM}R-xaaeWU'),
        // ),
        Scaffold(
          appBar: AppBar(        centerTitle: true,
            title: Text('商品详情',
                style: TextStyle(color: Colours.text_121212, fontSize: 20)),
            leading: IconButton(
              color: Colours.text_121212,
              tooltip: null,
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios_outlined),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),),
          backgroundColor: Colors.transparent,
          body: info != null
              ? ScrollConfiguration(
            behavior: NoShadowScrollBehavior(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [IndexTopicComponentCarousel(list: info?.goodsCarouselPictures??[],aspectRatio: 2,), renderHeader(), renderDetail()],
              ),
            ),
          )
              : const LoadingWidget(),
        ),
      ],
    );
  }

  /// 头部容器
  Widget renderHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    getTypeLabel(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  info!.goodsName??'',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '券后价',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                          FSuper(
                              text: '¥ ',
                              style: const TextStyle(color: Colors.red, fontSize: 16),
                              spans: [TextSpan(text: '${info!.price}', style: const TextStyle(color: Colors.red, fontSize: 25, fontWeight: FontWeight.bold))],
                              lightOrientation: FLightOrientation.RightTop)
                        ],
                      ),
                    ),

                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 50,
              decoration: const BoxDecoration(color: Colors.red, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (info!.discount != null)
                    Text(
                      '${info!.discount?.replaceAll('.00', '')}元隐藏券',
                      style: const TextStyle(color: Colors.white),
                    ),
                  Text(
                    info!.discount!.isNotEmpty ? '去领券 >' : '去购买 >',
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 商品信息
  Widget renderDetail() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('商品信息'),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        // Text(
                        //   '销量${info!.sales}件',
                        //   style: const TextStyle(color: Colors.grey, fontSize: 15),
                        // )
                      ],
                    )
                  ],
                ),
              ),
              ...renderImages(constraints.maxWidth)
            ],
          );
        },
      ),
    );
  }
  /// 图片
  List<Widget> renderImages(double width) {
    if(info!.goodsDetailPictures == null){
      return [];
    }
    return info!.goodsDetailPictures!
        .map((e) => SizedBox(
      width: width,
      child: ExtendedImage.network(
        MImageUtils.magesProcessor(e),
        width: double.infinity,
        cache: true,
        fit: BoxFit.cover,
        shape: BoxShape.rectangle,
      ),
    ))
        .toList();
  }


  String getTypeLabel() {
    if (widget.source != null) {
      switch (widget.source) {
        case 'pdd':
          return '拼多多';
        case 'taobao':
          return '淘宝';
        case 'jd':
          return '京东';
      }
    }
    return widget.source??'';
  }

  void getData() {
    if(widget.goodsId == null){
      return;
    }
    Map<String, dynamic> map = Map();
    map['pub_id'] = JtkApi.pub_id;
    map['source'] = widget.source;
    map['goodsId'] = widget.goodsId;
    map['sid'] = "bld";

    ApiClient.instance.get(ApiUrl.recommend, data: map, isJTK: true,
        onSuccess: (data) {
          BaseEntity<GoodsLinkEntity> entity = BaseEntity.fromJson(data!);
          if (entity.code == ApiStatus.JTKSUCCESS && entity.data != null) {
            setState(() {
              info = entity.data;
            });
          }else{
          }
          setState(() {});

        });
  }
}

