import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:SDZ/res/colors.dart';
import 'dart:ui' as ui;
import 'dart:ui';

///达人主页 tabbar 指示器
class TalentTabIndicator extends Decoration {
  /// Create an underline style selected tab indicator.
  ///
  /// The [borderSide] and [insets] arguments must not be null.
  const TalentTabIndicator({
    this.borderSide =
        const BorderSide(width: 5.0, color: Colours.color_main_red),
    this.insets = EdgeInsets.zero,
    this.maxWidth = -1,
    this.isCircle = false,
  })  : assert(borderSide != null),
        assert(insets != null);

  /// The color and weight of the horizontal line drawn below the selected tab.
  final BorderSide borderSide;

  /// Locates the selected tab's underline relative to the tab's boundary.
  ///
  /// The [TabBar.indicatorSize] property can be used to define the
  /// tab indicator's bounds in terms of its (centered) tab widget with
  /// [TabIndicatorSize.label], or the entire tab with [TabIndicatorSize.tab].
  final EdgeInsetsGeometry insets;

  /// 固定宽度
  final double maxWidth;

  /// 是否圆角
  final bool isCircle;

  @override
  Decoration lerpFrom(Decoration? a, double t) {
    if (a is UnderlineTabIndicator) {
      return UnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }
    return super.lerpFrom(a, t)!;
  }

  @override
  Decoration lerpTo(Decoration? b, double t) {
    if (b is UnderlineTabIndicator) {
      return UnderlineTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }
    return super.lerpTo(b, t)!;
  }

  @override
  _UnderlinePainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(this, onChanged!,
        maxWidth: maxWidth, isCircle: isCircle);
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(this.decoration, VoidCallback onChanged,
      {this.maxWidth = -1, this.isCircle = false})
      : assert(decoration != null),
        super(onChanged);

  final TalentTabIndicator decoration;

  /// 固定宽度
  final double maxWidth;

  /// 是否圆角
  final bool isCircle;

  BorderSide get borderSide => decoration.borderSide;

  EdgeInsetsGeometry get insets => decoration.insets;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    assert(rect != null);
    assert(textDirection != null);
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    if (maxWidth < 0) {
      return Rect.fromLTWH(
        indicator.left,
        indicator.bottom - borderSide.width,
        indicator.width,
        borderSide.width,
      );
    }
    //取中间坐标
    double cw = (indicator.left + indicator.right) / 2;
    return Rect.fromLTWH(cw - maxWidth / 2, indicator.bottom - borderSide.width,
        maxWidth, borderSide.width);
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator =
        _indicatorRectFor(rect, textDirection).deflate(borderSide.width / 2.0);
    final gradient = new SweepGradient(
      colors: [
        Colours.text_FF1F35_start,
        Colours.text_FF521D_end,
      ],
    );
    Paint paint = borderSide.toPaint()
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(rect);

    var startPoint =
        Offset(indicator.bottomLeft.dx + 16, configuration.size!.height-2);
    var controlPoint1 =
        Offset(indicator.bottomLeft.dx + 28, configuration.size!.height + 4);
    var controlPoint2 =
        Offset(indicator.bottomLeft.dx + 38, configuration.size!.height + 4);
    var endPoint =
        Offset(indicator.bottomLeft.dx + 50, configuration.size!.height-2);
    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(path, paint);

    // ui.Image _image;
    // Paint _paint = new Paint()
    //   ..color = Colors.white // 画笔颜色
    //   ..strokeCap = StrokeCap.round //画笔笔触类型
    //   ..isAntiAlias = true //是否启动抗锯齿
    //   ..strokeWidth = 6.0 //画笔的宽度
    //   ..style = PaintingStyle.fill // 样式
    //   ..blendMode = BlendMode.colorDodge; // 模式
    // load("assets/images/ic_zhenxiang_logo.png").then((i) {
    //   _image = i;
    //   canvas.drawImage(_image, offset, new Paint());
    // });

    //
    // Path path = new Path()..moveTo(offset.dx, 0.0);
    // final Rect rect = offset & configuration.size!;
    // path.arcTo(rect, 0.0, 3.14, false);
    // canvas.drawPath(path, _paint);
  }

  /// 通过assets路径，获取资源图片
  Future<ui.Image> load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}
