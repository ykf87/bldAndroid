import 'package:SDZ/utils/adaptor.dart';
import 'package:SDZ/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svgaplayer_flutter/player.dart';

class SignCard extends StatelessWidget {
  ///卡片标题
  String title;

  ///是否已经签到
  bool hasSigned;

  //当前标识
  int index;

  //连续门槛
  int throttle;

  SignCard({
    required this.title,
    required this.hasSigned,
    required this.index,
    required this.throttle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Adaptor.width(38),
      height: Adaptor.height(48),
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.fromLTRB(
        Adaptor.width(4),
        Adaptor.width(2),
        Adaptor.width(4),
        Adaptor.width(6),
      ),
      decoration: BoxDecoration(
        color: hasSigned ? Color(0xffFD553A) : Color(0xfff5f5f5),
        borderRadius: BorderRadius.circular(Adaptor.width(3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              color: hasSigned ? Colors.white : Colors.black38,
              fontSize: Adaptor.sp(13),
            ),
          ),
          _getMarkInfo(),
        ],
      ),
    );
  }

  Widget _getMarkInfo() {
    if (hasSigned) {
      return SvgPicture.asset(Utils.getSvgUrl('ic_check.svg'),width: 12,height: 12);
    }
    return SvgPicture.asset(Utils.getSvgUrl('ic_noSign.svg'),width: 16,height:16,color: Colors.black38,);

  }
}
