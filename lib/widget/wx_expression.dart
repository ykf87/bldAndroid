import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SDZ/widget/common_widgets.dart';

///表情组件
class WeChatExpression extends StatelessWidget {
  ///一行表情数量
  final int crossAxisCount;

  //纵轴间距
  final double mainAxisSpacing;

  //横轴间距
  final double crossAxisSpacing;

  ///子Widget宽高比例
  final double childAspectRatio;

  ///大小比例,值的大小与表情的大小成反比
  final double bigSizeRatio;

  final CallClick _callClick;

  WeChatExpression(this._callClick,
      {this.crossAxisCount = 8,
      this.mainAxisSpacing = 0.0,
      this.crossAxisSpacing = 0.0,
      this.childAspectRatio = 1.0,
      this.bigSizeRatio = 8.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(32, 32, 32, 0.92),
      child: GridView.custom(
        padding: EdgeInsets.only(
            left: sWidth(8),
            top: sWidth(8),
            right: sWidth(8),
            bottom: sWidth(32)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: this.crossAxisCount,
          mainAxisSpacing: this.mainAxisSpacing,
          crossAxisSpacing: this.crossAxisSpacing,
        ),
        childrenDelegate: SliverChildBuilderDelegate((context, position) {
          return _getExpressionItemContainer(position);
        }, childCount: ExpressionData.EXPRESSION_SIZE),
      ),
    );
  }

  ///获取表情列表
  _getExpressionItemContainer(int index) {
    var expressionPath = ExpressionData.expressionPath[index];
    return AExpression(expressionPath, this.bigSizeRatio, this._callClick);
  }
}

///单个表情
// ignore: must_be_immutable
class AExpression extends StatelessWidget {
  Expression expression;

  ///大小比例,值的大小与表情的大小成反比
  final double bigSizeRatio;

  final CallClick _callClick;

  AExpression(this.expression, this.bigSizeRatio, this._callClick);

  @override
  Widget build(BuildContext context) {
    print(ExpressionData.basePath + expression.path);
    return Container(
      child: CupertinoButton(
        padding: EdgeInsets.all(bigSizeRatio),
        onPressed: () {
          _callClick(expression);
        },
        child: Image.asset(
          ExpressionData.basePath + expression.path,
          // width: sWidth(32),
          // height: sWidth(32),
        ),
      ),
    );
  }
}

///点击之后
typedef void CallClick(Expression expression);

///表情对象
class Expression {
  final String name;
  final String path;

  ///标识是否是emoji表情,true是,默认false
  final bool isEmoji;

  Expression(this.name, this.path, {this.isEmoji = false});
}

///数据类
class ExpressionData {
  ///基础路径
  static String basePath = "assets/images/expression/";

  ///表情路径
  static final List<Expression> expressionPath = [
    Expression('大笑', 'emoji_0.png'),
    Expression('可爱', 'emoji_01.png'),
    Expression('色', 'emoji_02.png'),
    Expression('嘘', 'emoji_03.png'),
    Expression('亲', 'emoji_04.png'),
    Expression('呆', 'emoji_05.png'),
    Expression('口水', 'emoji_06.png'),
    Expression('汗', 'emoji_145.png'),
    Expression('呲牙', 'emoji_07.png'),
    Expression('鬼脸', 'emoji_08.png'),
    Expression('害羞', 'emoji_09.png'),
    Expression('偷笑', 'emoji_10.png'),
    Expression('调皮', 'emoji_11.png'),
    Expression('可怜', 'emoji_12.png'),
    Expression('敲', 'emoji_13.png'),
    Expression('惊讶', 'emoji_14.png'),
    Expression('流感', 'emoji_15.png'),
    Expression('委屈', 'emoji_16.png'),
    Expression('流泪', 'emoji_17.png'),
    Expression('嚎哭', 'emoji_18.png'),
    Expression('惊恐', 'emoji_19.png'),
    Expression('怒', 'emoji_20.png'),
    Expression('酷', 'emoji_21.png'),
    Expression('不说', 'emoji_22.png'),
    Expression('鄙视', 'emoji_23.png'),
    Expression('阿弥陀佛', 'emoji_24.png'),
    Expression('奸笑', 'emoji_25.png'),
    Expression('睡着', 'emoji_26.png'),
    Expression('口罩', 'emoji_27.png'),
    Expression('努力', 'emoji_28.png'),
    Expression('抠鼻孔', 'emoji_29.png'),
    Expression('疑问', 'emoji_30.png'),
    Expression('怒骂', 'emoji_31.png'),
    Expression('晕', 'emoji_32.png'),
    Expression('呕吐', 'emoji_33.png'),
    Expression('拜一拜', 'emoji_160.png'),
    Expression('惊喜', 'emoji_161.png'),
    Expression('流汗', 'emoji_162.png'),
    Expression('卖萌', 'emoji_163.png'),
    Expression('默契眨眼', 'emoji_164.png'),
    Expression('烧香拜佛', 'emoji_165.png'),
    Expression('晚安', 'emoji_166.png'),
    Expression('强', 'emoji_34.png'),
    Expression('弱', 'emoji_35.png'),
    Expression('OK', 'emoji_36.png'),
    Expression('拳头', 'emoji_37.png'),
    Expression('胜利', 'emoji_38.png'),
    Expression('鼓掌', 'emoji_39.png'),
    Expression('握手', 'emoji_200.png'),
    Expression('发怒', 'emoji_40.png'),
    Expression('骷髅', 'emoji_41.png'),
    Expression('便便', 'emoji_42.png'),
    Expression('火', 'emoji_43.png'),
    Expression('溜', 'emoji_44.png'),
    Expression('爱心', 'emoji_45.png'),
    Expression('心碎', 'emoji_46.png'),
    Expression('钟情', 'emoji_47.png'),
    Expression('唇', 'emoji_48.png'),
    Expression('戒指', 'emoji_49.png'),
    Expression('钻石', 'emoji_50.png'),
    Expression('太阳', 'emoji_51.png'),
    Expression('有时晴', 'emoji_52.png'),
    Expression('多云', 'emoji_53.png'),
    Expression('雷', 'emoji_54.png'),
    Expression('雨', 'emoji_55.png'),
    Expression('雪花', 'emoji_56.png'),
    Expression('爱人', 'emoji_57.png'),
    Expression('帽子', 'emoji_58.png'),
    Expression('皇冠', 'emoji_59.png'),
    Expression('篮球', 'emoji_60.png'),
    Expression('足球', 'emoji_61.png'),
    Expression('垒球', 'emoji_62.png'),
    Expression('网球', 'emoji_63.png'),
    Expression('台球', 'emoji_64.png'),
    Expression('咖啡', 'emoji_65.png'),
    Expression('啤酒', 'emoji_66.png'),
    Expression('干杯', 'emoji_67.png'),
    Expression('柠檬汁', 'emoji_68.png'),
    Expression('餐具', 'emoji_69.png'),
    Expression('汉堡', 'emoji_70.png'),
    Expression('鸡腿', 'emoji_71.png'),
    Expression('面条', 'emoji_72.png'),
    Expression('冰淇淋', 'emoji_73.png'),
    Expression('沙冰', 'emoji_74.png'),
    Expression('生日蛋糕', 'emoji_75.png'),
    Expression('蛋糕', 'emoji_76.png'),
    Expression('糖果', 'emoji_77.png'),
    Expression('葡萄', 'emoji_78.png'),
    Expression('西瓜', 'emoji_79.png'),
    Expression('光碟', 'emoji_80.png'),
    Expression('手机', 'emoji_81.png'),
    Expression('电话', 'emoji_82.png'),
    Expression('电视', 'emoji_83.png'),
    Expression('声音开启', 'emoji_84.png'),
    Expression('声音关闭', 'emoji_85.png'),
    Expression('铃铛', 'emoji_86.png'),
    Expression('锁头', 'emoji_87.png'),
    Expression('放大镜', 'emoji_88.png'),
    Expression('灯泡', 'emoji_89.png'),
    Expression('锤头', 'emoji_90.png'),
    Expression('烟', 'emoji_91.png'),
    Expression('炸弹', 'emoji_92.png'),
    Expression('枪', 'emoji_93.png'),
    Expression('刀', 'emoji_94.png'),
    Expression('药', 'emoji_95.png'),
    Expression('打针', 'emoji_96.png'),
    Expression('钱袋', 'emoji_97.png'),
    Expression('钞票', 'emoji_98.png'),
    Expression('银行卡', 'emoji_99.png'),
    Expression('手柄', 'emoji_100.png'),
    Expression('麻将', 'emoji_101.png'),
    Expression('调色板', 'emoji_102.png'),
    Expression('电影', 'emoji_103.png'),
    Expression('麦克风', 'emoji_104.png'),
    Expression('耳机', 'emoji_105.png'),
    Expression('音乐', 'emoji_106.png'),
    Expression('吉他', 'emoji_107.png'),
    Expression('火箭', 'emoji_108.png'),
    Expression('飞机', 'emoji_109.png'),
    Expression('火车', 'emoji_110.png'),
    Expression('公交', 'emoji_111.png'),
    Expression('轿车', 'emoji_112.png'),
    Expression('出租车', 'emoji_113.png'),
    Expression('警车', 'emoji_114.png'),
    Expression('自行车', 'emoji_115.png'),
  ];

  ///kv
  static final Map<String, String> expressionKV = {};

  ///初始化
  static void init() {
    for (var value in expressionPath) {
      expressionKV[value.name] = value.path;
    }
  }

  ///格式化消息
  static String format(String msg) {
    return msg;
  }

  ///表情总长度
  // ignore: non_constant_identifier_names
  static final int EXPRESSION_SIZE = expressionPath.length;
}

///带有表情的文本
///备注:这里本想用自定义View直接写,因为项目太紧也没仔细研究,
///如果有人写出来也麻烦copy我一份学习学习
///这里就直接用Wrap配合Text与Image直接拼接的消息,测试了一下也不会卡;
class ExpressionText extends StatelessWidget {
  final String _text;
  final TextStyle _textStyle;

  //最大行数,默认-1,不限制
  final int maxLine;

  const ExpressionText(this._text, this._textStyle,
      {Key? key, this.maxLine = -1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (maxLine > 0)
          ? Text.rich(
              TextSpan(
                children: _getContent(),
              ),
              strutStyle: StrutStyle(height: 2),
              // style: TextStyle(wordSpacing: sWidth(30)),
              maxLines: maxLine,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            )
          : Text.rich(
              TextSpan(
                // style: TextStyle(wordSpacing: sWidth(30)),
                children: _getContent(),
              ),
              strutStyle: StrutStyle(height: 1.5),
            ),
    );
  }

  ///使用正则解析表情文本,使用了Text.rich替换掉了Wrap
  _getContent() {
    if (ExpressionData.expressionKV.length == 0) {
      ExpressionData.init();
    }
    List<InlineSpan> stack = [];

    List<int> indexList = [];

    //正则校验是否含有表情
    RegExp exp = new RegExp(r'\[.{1,4}?\]');

    if (exp.hasMatch(_text)) {
      var array = exp.allMatches(_text).toList();
      for (RegExpMatch r in array) {
        var substring = _text.substring(r.start, r.end);
        var select = substring.substring(1, substring.length - 1);
        if (ExpressionData.expressionKV.containsKey(select)) {
          indexList.add(r.start);
          indexList.add(r.end);
        }
      }
      int afterX = 0;
      for (int x = 0; x < indexList.length; x = x + 2) {
        int y = x + 1;
        var indexX = indexList[x];
        var indexY = indexList[y];
        var substring = _text.substring(afterX, indexX);
        afterX = indexY;
        stack.add(TextSpan(
          text: substring,
          style: _textStyle,
        ));
        var xy = _text.substring(indexX, indexY);
        var selectXy = xy.substring(1, xy.length - 1);
        var expressionKV = ExpressionData.expressionKV[selectXy];
        stack.add(WidgetSpan(
          child: Padding(
            padding: EdgeInsets.only(left: sWidth(3),right: sWidth(2)),
            child: Image.asset(
              'assets/images/expression/$expressionKV',
              width: sWidth(22),
              height: sWidth(22),
            ),
          ),
        ));
      }
      var substring = _text.substring(afterX);
      if (substring.length > 0) {
        stack.add(TextSpan(
          text: substring,
          style: _textStyle,
        ));
      }
    } else {
      stack.add(TextSpan(
        text: _text,
        style: _textStyle,
      ));
    }

    return stack;
  }
}
