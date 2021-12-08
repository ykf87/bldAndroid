// Flutter imports:
// Package imports:
import 'package:SDZ/core/utils/utils.dart';
import 'package:SDZ/entity/waimai/activity_link_result_entity.dart';
import 'package:SDZ/widget/loading_mixin.dart';
import 'package:SDZ/widget/simple_appbar.dart';
import 'package:fbutton_nullsafety/fbutton_nullsafety.dart';
import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flutter/material.dart';

// Project imports:

/// 外卖领取页面

class WaimaiDetail extends StatefulWidget {
  final String type; // 类型 1 - 外卖红包  2 - 商超红包
  const WaimaiDetail({Key? key, required this.type}) : super(key: key);

  @override
  _WaimaiDetailState createState() => _WaimaiDetailState();
}

class _WaimaiDetailState extends State<WaimaiDetail> with LoadingMixin {
  ActivityLinkResultEntity? model;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      setLoading(true);
      final result = new ActivityLinkResultEntity();
      if (mounted && result != null) {
        setState(() {
          model = result;
        });
      }
      setLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.type == '1'
          ? const Color.fromRGBO(255, 97, 97, 1)
          : const Color.fromRGBO(1, 171, 245, 1),
      appBar: const SimpleAppBar(title: '红包领取'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            renderHeaderImage(),
            renderNavLink(),
            SizedBox(height: 12,),
            renderKl(),
            SizedBox(height: 12,),
            rendenGuize()
          ],
        ),
      ),
    );
  }

  /// 领取规则
  Widget rendenGuize() {
    const style = TextStyle(color: Colors.white);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('规则说明:', style: style),
          Text('1.每天最高可领20元红包。', style: style),
          Text('2.使用红包时下单手机号码必须与收餐人手机号码、领取红包时输入的手机号码一致。', style: style),
          Text('3.具体红包使用有效期及红包金额以实际收到为准。', style: style),
        ],
      ),
    );
  }

  // 头部
  Widget renderHeaderImage() {
    return AspectRatio(
        aspectRatio: 1.87,
        child: Image.asset(
            'assets/images/waimai/hb/${widget.type == '1' ? '1' : 'sc_bg'}.png'));
  }

  /// 复制口令模块
  Widget renderKl() {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 2.33,
          child: Image.asset('assets/images/waimai/hb/4.png'),
        ),
        if (model != null)
          Positioned(
              left: 20,
              right: 20,
              top: 30,
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    model?.long_tpwd??'',
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                    textAlign: TextAlign.center,
                  ))),
        Positioned(
          left: 30,
          right: 30,
          bottom: 40,
          child: FButton(
            height: 40,
            text: '复制饿了么口令',
            style: const TextStyle(color: Colors.pink),
            onPressed: () {
              if (model != null) {
                Utils.copy(model?.long_tpwd??'', message: '复制口令成功,打开淘宝即可领取优惠券');
              }
            },
            clickEffect: true,
            strokeWidth: 1,
            strokeColor: Colors.red,
            alignment: Alignment.center,
            corner: FCorner.all(50),
            shadowColor: Colors.red,
            highlightColor: Colors.pink.shade50,
          ),
        )
      ],
    );
  }

  /// 跳转链接
  Widget renderNavLink() {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          Image.asset('assets/images/waimai/hb/2.png'),
          Positioned(
              top: 12,
              left: 20,
              right: 20,
              child: AspectRatio(
                aspectRatio: 3.98,
                child: Image.asset('assets/images/waimai/hb/3.png'),
              )),
          Positioned(
              bottom: 35,
              left: 30,
              right: 30,
              child: FButton(
                height: 40,
                alignment: Alignment.center,
                text: '领红包点外卖',
                style: const TextStyle(color: Colors.white),
                color: Colors.red,
                onPressed: () {
                  if (model != null) {
                    Utils.navToBrowser(model!.click_url??'');
                  }
                },
                highlightColor: Colors.pink,
                corner: FCorner.all(50),
              ))
        ],
      ),
    );
  }
}
