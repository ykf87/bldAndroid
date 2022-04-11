// Flutter imports:
// Package imports:
import 'package:SDZ/res/colors.dart';
import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flutter/material.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';

// Project imports:

// 券后价小部件
class CouponPriceWidget extends StatelessWidget {
  final String? actualPrice; //  券后价
  final double? originalPrice; //  商品原价
  final double? couponPriceFontSize; // 券后价文本大小
  final double? originalPriceFontSize; // 商品原价文本大小
  final double? interval; // 券后价和原价之间的间隔距离
  final bool? showDiscount; // 是否显示折扣

  const CouponPriceWidget({required this.actualPrice, required this.originalPrice, this.couponPriceFontSize, this.originalPriceFontSize, this.interval, this.showDiscount,Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(

      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 3.0),
          child: const Text('券后', style: TextStyle(color: Colors.black38, fontSize: 12)),
        ),
        const Text(
          '¥ ',
          style: TextStyle(fontSize: 13, color:Colours.color_orange_ffFF7648),
        ),
        Text(
          actualPrice.toString(),
          style: const TextStyle(color:Colours.color_orange_ffFF7648, fontSize: 18,fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(left: interval ?? 10.0),
          child: Text(
            '¥$originalPrice',
            style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.black38, fontSize: 12),
          ),
        ),
        //多少折
        showDiscount != null && showDiscount! ? _buildDiscount() : Container()
      ],
    );
  }

  //计算多少折扣
  Widget _buildDiscount() {
    var discountDouble = double.parse(actualPrice!) / originalPrice!;
    var numStr = discountDouble.toStringAsFixed(2);
    numStr = numStr.substring(0, numStr.lastIndexOf('.') + 2);
    var discount = double.parse(numStr) * 10;
    return FSuper(
      lightOrientation: FLightOrientation.LeftBottom,
      backgroundColor: Colours.app_main,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      margin: const EdgeInsets.only(left: 10),
      text: '${discount.toStringAsFixed(discount.truncateToDouble() == discount ? 0 : 1)}折',
    );
  }
}
