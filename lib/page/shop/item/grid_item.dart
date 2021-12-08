import 'package:flutter/material.dart';
import 'package:SDZ/res/colors.dart';

/// 图标 文字
class GridItem extends StatelessWidget {
  final ActionItem item;

  //点击事件
  final GestureTapCallback onTap;

  const GridItem({Key? key, required this.item, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46.0,
      child: new InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.account_balance_outlined),
              iconSize: 30,
              onPressed: () {},
            ),
            Text(
              item.title,
              style: TextStyle(color: Colours.text_131313, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}

class ActionItem {
  final String title;
  final String icon;

  const ActionItem(this.title, this.icon);
}
