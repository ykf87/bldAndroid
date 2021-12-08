import 'package:flutter/material.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/widget/double_click.dart';

/// 个人中心 顶部  上数量 下文字
class CountTitleWidget extends StatelessWidget {
  // 文字
  final String title;
  // 数量
  final String count;
  //是否可点击
  final bool enabled;
  //点击事件
  final GestureTapCallback onTap;

  // 构造函数
  const CountTitleWidget(
      {Key? key, required this.title, required this.count, this.enabled = true, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DoubleClick(
        onTap: enabled ? onTap : null,
        child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Column(children: <Widget>[
            Container(
              child: Text(count.toString(),style: TextStyle(color: Colours.bg_ffffff,fontSize: 20, fontWeight: FontWeight.bold),maxLines: 1,),
            ),
            Padding(padding: const EdgeInsets.only(top: 4), child: Text(title, style: TextStyle(fontSize: 12,color: Colours.text_main)))
          ]),
        ));
  }
}

