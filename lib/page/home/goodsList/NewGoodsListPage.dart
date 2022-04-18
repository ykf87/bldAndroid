import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_status.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/api/jtk_api.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/jutuike/goods_entity.dart';
import 'package:SDZ/page/home/widget/waterfall_goods_card.dart';
import 'package:SDZ/page/signModule/sign/FeedAdItem.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/widget/custom_refresh_footer.dart';
import 'package:SDZ/widget/custom_refresh_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

/// 商品列表
class NewGoodsListPage extends StatefulWidget {
  String source = 'taobao'; //商品来源

  NewGoodsListPage(this.source);

  @override
  _NewGoodsListPageState createState() => _NewGoodsListPageState();
}

class _NewGoodsListPageState extends State<NewGoodsListPage>
    with AutomaticKeepAliveClientMixin {
  int pageNum = 1;
  EasyRefreshController refreshController = EasyRefreshController();
  bool isShowEmpty = false; //是否显示缺省
  final List<GoodsEntity> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EasyLoading.show();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      header: WeFreeHeader(),
      footer: WeFreeFooter(),
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1), () {
          doRefresh();
        });
      },
      onLoad: () async {
        await Future.delayed(Duration(seconds: 1), () {
          doLoadMore();
        });
      },
      slivers: [
        SliverToBoxAdapter(
          child: isShowEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 96),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/img_collection_empty.svg',
                        height: 120,
                        width: 120,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '暂无数据~',
                        style:
                            TextStyle(color: Colours.text_main, fontSize: 14),
                      ),
                    ],
                  ))
              : SizedBox.shrink(),
        ),
        SliverToBoxAdapter(
            child: Container(
          padding: EdgeInsets.only(left: 12, right: 12),
          child: StaggeredGridView.countBuilder(
            primary: false,
            shrinkWrap: true,
            crossAxisCount: 4,
            itemCount: list.length,
            itemBuilder: (context, i) {
              return Container(
                child: list[i].isAd
                    ? FeedAdItem(
                        MediaQuery.of(context).size.width,
                        adType: 2,
                      )
                    : WaterfallGoodsCard(
                        list[i],
                        source: widget.source,
                      ),
              );
            },
            staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
        )),
      ],
    );
  }

  void doRefresh() {
    pageNum = 1;
    list.clear();
    getData();
  }

  void doLoadMore() {
    pageNum++;
    getData();
  }

  void getData() {
    Map<String, dynamic> map = Map();
    map['pub_id'] = JtkApi.pub_id;
    map['source'] = widget.source;
    // map['cat'] = pub_id;//分类
    // map['sub_share_rate'] = sub_share_rate;//分成比例 1代表100%，0.9代表90%，默认1
    map['page'] = pageNum;
    map['pageSize'] = 20;

    ApiClient.instance.get(ApiUrl.query_goods, data: map, isJTK: true,
        onSuccess: (data) {
      EasyLoading.dismiss();
      BaseEntity<List<GoodsEntity>> entity = BaseEntity.fromJson(data!);

      if (entity.code == ApiStatus.JTKSUCCESS && entity.data != null) {
        for (int i = 0; i < 5; i++) {
          GoodsEntity giftEntity = new GoodsEntity();
          giftEntity.isAd = true;
          if (entity.data!.length > (i + 1) * 5) {
            entity.data!.insert((i + 1) * 5, giftEntity);
          }
        }
        list.addAll(entity.data ?? []);
      } else {
        isShowEmpty = true;
      }
      setState(() {});
    }, onError: (msg) {
      EasyLoading.dismiss();
    });
  }

  @override
  bool get wantKeepAlive => true;
}
