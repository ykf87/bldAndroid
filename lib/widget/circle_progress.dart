
import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 圆形进度条
class CircleProgressWidget extends StatefulWidget {

  final ProgressSytle progress;

  CircleProgressWidget({Key? key, required this.progress}): super(key: key);

  @override
  _CircleProgressState createState() => _CircleProgressState();
}

class ProgressSytle {
  ///当前进度
  double? value;
  ///进度条颜色
  Color color;
  ///未完成进度条颜色
  Color backgroundColor;
  ///半径
  double radius;
  ///线宽
  double strokeWidth;
  ///文本样式
  TextStyle style;
  ///进度显示内容
  String text;
  ///顺时针
  bool clockwise;

  ProgressSytle(
      {
        this.value,
        this.color = Colors.blue,
        this.backgroundColor = Colors.grey,
        this.radius = 20.0,
        this.style = const TextStyle(color: Colors.blue, fontSize: 14),
        this.strokeWidth = 4.0,
        this.text = '',
        this.clockwise = true
      });
}

class _CircleProgressState extends State<CircleProgressWidget> {
  @override
  Widget build(BuildContext context) {
    var progress = Container(
      width: widget.progress.radius * 2,
      height: widget.progress.radius * 2,
      child: CustomPaint(
        painter: ProgressPainter(widget.progress),
      ),
    );
    String txt = "${(100 * widget.progress.value!).toStringAsFixed(0)}%";
    var text = Text(
      widget.progress.text.isEmpty ? txt : widget.progress.text, //widget.progress.value == 1.0 ? widget.progress.text : txt,
      style: widget.progress.style,
    );
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[progress,text],
    );
  }
}

class ProgressPainter extends CustomPainter {

  ProgressSytle _progress;
  Paint? _paint;
  double? _radius;
  
  ProgressPainter(this._progress) {
    _paint = Paint();
    _radius = _progress.radius - _progress.strokeWidth/2;
  }
  
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    canvas.clipRect(rect);
    canvas.translate(_progress.strokeWidth/2, _progress.strokeWidth/2);
    
    drawProgress(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
  
  drawProgress(Canvas canvas) {
    canvas.save();
    _paint!
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..color = _progress.backgroundColor
      ..strokeWidth = _progress.strokeWidth;
    canvas.drawCircle(Offset(_radius!, _radius!), _radius!, _paint!);
    
    _paint!
      ..color = _progress.color
      ..isAntiAlias = true
      ..strokeWidth = _progress.strokeWidth
      ..strokeCap = StrokeCap.round;
    double sweepAngle = _progress.value! * 360;
    /// 90 / 180 * pi 逆时针  -90 / 180 * pi 顺时针
    canvas.drawArc(Rect.fromLTRB(0, 0, _radius! * 2, _radius! * 2), _progress.clockwise ? -90 / 180 * pi : 90 / 180 * pi, sweepAngle / 180 * pi, false, _paint!);
    canvas.restore();
  }
}