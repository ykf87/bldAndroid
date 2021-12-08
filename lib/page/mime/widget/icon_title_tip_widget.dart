import 'package:flutter/material.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/res/dimens.dart';

/// 图标 文字 红点数字
class IconTitleTipWidget extends StatelessWidget {
  // 文字
  final String title;

  final String icon;

  // 数量
  final int count;

  //是否可点击
  final bool enabled;

  //点击事件
  final GestureTapCallback onTap;

  const IconTitleTipWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.count,
      this.enabled = true,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  onTap();
                },
                icon: Icon(Icons.account_balance_outlined),
                iconSize: 30,
              ),
              Positioned(
                right: 0,
                child:count ==0? SizedBox.shrink(): DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).errorColor,
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.5, vertical: 2.0),
                    child: Text(
                      count.toString(),
                      style: TextStyle(
                          color: Colors.white, fontSize: Dimens.font_sp12),
                    ),
                  ),
                ),
              )
            ],
          ),
          Text(
            title,
            style: TextStyle(color: Colours.text_131313, fontSize: 12),
          )
        ],
      ),
    );
  }
}
