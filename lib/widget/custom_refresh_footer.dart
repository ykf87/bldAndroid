import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:SDZ/res/colors.dart';

/// @Author: ljx
/// @CreateDate: 2021/9/8 16:51
/// @Description: 自定义刷新底部

class WeFreeFooter extends Footer {
  /// Key
  final Key? key;

  /// 方位
  final AlignmentGeometry? alignment;

  /// 提示加载文字
  final String? loadText;

  /// 准备加载文字
  final String? loadReadyText;

  /// 正在加载文字
  final String? loadingText;

  /// 加载完成文字
  final String? loadedText;

  /// 加载失败文字
  final String? loadFailedText;

  /// 没有更多文字
  final String? noMoreText;

  /// 显示额外信息(默认为时间)
  final bool showInfo;

  /// 更多信息
  final String? infoText;

  /// 背景颜色
  final Color bgColor;

  /// 字体颜色
  final Color textColor;

  /// 更多信息文字颜色
  final Color infoColor;

  WeFreeFooter({
    double extent = 60.0,
    double triggerDistance = 70.0,
    bool float = false,
    Duration? completeDuration = const Duration(milliseconds: 200),
    bool enableInfiniteLoad = true,
    bool enableHapticFeedback = true,
    bool overScroll = false,
    bool safeArea = true,
    EdgeInsets? padding,
    this.key,
    this.alignment,
    this.loadText,
    this.loadReadyText,
    this.loadingText,
    this.loadedText,
    this.loadFailedText,
    this.noMoreText,
    this.showInfo: false,
    this.infoText,
    this.bgColor: Colors.transparent,
    this.textColor: Colours.color_6A6E7E,
    this.infoColor: Colors.teal,
  }) : super(
    extent: extent,
    triggerDistance: triggerDistance,
    float: float,
    completeDuration: completeDuration,
    enableInfiniteLoad: enableInfiniteLoad,
    enableHapticFeedback: enableHapticFeedback,
    overScroll: overScroll,
    safeArea: safeArea,
    padding: padding,
  );

  @override
  Widget contentBuilder(
      BuildContext context,
      LoadMode loadState,
      double pulledExtent,
      double loadTriggerPullDistance,
      double loadIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration? completeDuration,
      bool enableInfiniteLoad,
      bool success,
      bool noMore) {
    return WeFreeFooterWidget(
      key: key,
      weFreeFooter: this,
      loadState: loadState,
      pulledExtent: pulledExtent,
      loadTriggerPullDistance: loadTriggerPullDistance,
      loadIndicatorExtent: loadIndicatorExtent,
      axisDirection: axisDirection,
      float: float,
      completeDuration: completeDuration,
      enableInfiniteLoad: enableInfiniteLoad,
      success: success,
      noMore: noMore,
    );
  }
}

class WeFreeFooterWidget extends StatefulWidget {
  final WeFreeFooter weFreeFooter;
  final LoadMode loadState;
  final double pulledExtent;
  final double loadTriggerPullDistance;
  final double loadIndicatorExtent;
  final AxisDirection axisDirection;
  final bool float;
  final Duration? completeDuration;
  final bool enableInfiniteLoad;
  final bool success;
  final bool noMore;

  WeFreeFooterWidget(
      {Key? key,
        required this.loadState,
        required this.weFreeFooter,
        required this.pulledExtent,
        required this.loadTriggerPullDistance,
        required this.loadIndicatorExtent,
        required this.axisDirection,
        required this.float,
        this.completeDuration,
        required this.enableInfiniteLoad,
        required this.success,
        required this.noMore})
      : super(key: key);

  @override
  WeFreeFooterWidgetState createState() => WeFreeFooterWidgetState();
}

class WeFreeFooterWidgetState extends State<WeFreeFooterWidget>
    with TickerProviderStateMixin<WeFreeFooterWidget> {
  // 是否到达触发加载距离
  bool _overTriggerDistance = false;

  bool get overTriggerDistance => _overTriggerDistance;

  set overTriggerDistance(bool over) {
    if (_overTriggerDistance != over) {
      _overTriggerDistance
          ? _readyController.forward()
          : _restoreController.forward();
    }
    _overTriggerDistance = over;
  }

  /// 文本
  String get _loadText {
    return widget.weFreeFooter.loadText ?? '上拉可以加载';
  }

  String get _loadReadyText {
    return widget.weFreeFooter.loadReadyText ?? '释放立即加载';
  }

  String get _loadingText {
    return widget.weFreeFooter.loadingText ?? '正在加载...';
  }

  String get _loadedText {
    return widget.weFreeFooter.loadedText ?? '加载完成';
  }

  String get _loadFailedText {
    return widget.weFreeFooter.loadFailedText ?? '加载失败';
  }

  /// 没有更多文字
  String get _noMoreText {
    return widget.weFreeFooter.noMoreText ?? '我是有底线的';
  }

  String get _infoText {
    return widget.weFreeFooter.infoText ?? '';
  }

  // 动画
  late AnimationController _readyController;
  late Animation<double> _readyAnimation;
  late AnimationController _restoreController;
  late Animation<double> _restoreAnimation;

  // Icon旋转度
  double _iconRotationValue = 1.0;

  // 显示文字
  String get _showText {
    if (widget.noMore) return _noMoreText;
    if (widget.enableInfiniteLoad) {
      if (widget.loadState == LoadMode.loaded ||
          widget.loadState == LoadMode.inactive ||
          widget.loadState == LoadMode.drag) {
        return _finishedText;
      } else {
        return _loadingText;
      }
    }
    switch (widget.loadState) {
      case LoadMode.load:
        return _loadingText;
      case LoadMode.armed:
        return _loadingText;
      case LoadMode.loaded:
        return _finishedText;
      case LoadMode.done:
        return _finishedText;
      default:
        if (overTriggerDistance) {
          return _loadReadyText;
        } else {
          return _loadText;
        }
    }
  }

  // 加载结束文字
  String get _finishedText {
    if (!widget.success) return _loadFailedText;
    if (widget.noMore) return _noMoreText;
    return _loadedText;
  }

  // 加载结束图标
  IconData get _finishedIcon {
    if (!widget.success) return Icons.error_outline;
    if (widget.noMore) return Icons.hourglass_empty;
    return Icons.done;
  }

  // 更新时间
  late DateTime _dateTime;

  // 获取更多信息
  String get _infoTextStr {
    if (widget.loadState == LoadMode.loaded) {
      _dateTime = DateTime.now();
    }
    String fillChar = _dateTime.minute < 10 ? "0" : "";
    return _infoText.replaceAll(
        "%T", "${_dateTime.hour}:$fillChar${_dateTime.minute}");
  }

  @override
  void initState() {
    super.initState();
    // 初始化时间
    _dateTime = DateTime.now();
    // 初始化动画
    _readyController = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _readyAnimation = new Tween(begin: 0.5, end: 1.0).animate(_readyController)
      ..addListener(() {
        setState(() {
          if (_readyAnimation.status != AnimationStatus.dismissed) {
            _iconRotationValue = _readyAnimation.value;
          }
        });
      });
    _readyAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _readyController.reset();
      }
    });
    _restoreController = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _restoreAnimation =
    new Tween(begin: 1.0, end: 0.5).animate(_restoreController)
      ..addListener(() {
        setState(() {
          if (_restoreAnimation.status != AnimationStatus.dismissed) {
            _iconRotationValue = _restoreAnimation.value;
          }
        });
      });
    _restoreAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _restoreController.reset();
      }
    });
  }

  @override
  void dispose() {
    _readyController.dispose();
    _restoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 是否为垂直方向
    bool isVertical = widget.axisDirection == AxisDirection.down ||
        widget.axisDirection == AxisDirection.up;
    // 是否反向
    bool isReverse = widget.axisDirection == AxisDirection.up ||
        widget.axisDirection == AxisDirection.left;
    // 是否到达触发加载距离
    overTriggerDistance = widget.loadState != LoadMode.inactive &&
        widget.pulledExtent >= widget.loadTriggerPullDistance;
    return Stack(
      children: <Widget>[
        Positioned(
          top: !isVertical
              ? 0.0
              : !isReverse
              ? 0.0
              : null,
          bottom: !isVertical
              ? 0.0
              : isReverse
              ? 0.0
              : null,
          left: isVertical
              ? 0.0
              : !isReverse
              ? 0.0
              : null,
          right: isVertical
              ? 0.0
              : isReverse
              ? 0.0
              : null,
          child: Container(
            alignment: widget.weFreeFooter.alignment ??
                (isVertical
                    ? !isReverse
                    ? Alignment.topCenter
                    : Alignment.bottomCenter
                    : isReverse
                    ? Alignment.centerRight
                    : Alignment.centerLeft),
            width: !isVertical
                ? widget.loadIndicatorExtent > widget.pulledExtent
                ? widget.loadIndicatorExtent
                : widget.pulledExtent
                : double.infinity,
            height: isVertical
                ? widget.loadIndicatorExtent > widget.pulledExtent
                ? widget.loadIndicatorExtent
                : widget.pulledExtent
                : double.infinity,
            color: widget.weFreeFooter.bgColor,
            child: SizedBox(
              height: isVertical ? widget.loadIndicatorExtent : double.infinity,
              width: !isVertical ? widget.loadIndicatorExtent : double.infinity,
              child: isVertical
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildContent(isVertical, isReverse),
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildContent(isVertical, isReverse),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 构建显示内容
  List<Widget> _buildContent(bool isVertical, bool isReverse) {
    return isVertical
        ? <Widget>[
      // Expanded(
      //   flex: 2,
      //   child: Container(
      //     alignment: Alignment.centerRight,
      //     padding: EdgeInsets.only(
      //       right: 10.0,
      //     ),
      //     child: (widget.loadState == LoadMode.load ||
      //         widget.loadState == LoadMode.armed) &&
      //         !widget.noMore
      //         ? Container(
      //       width: 20.0,
      //       height: 20.0,
      //       child: CircularProgressIndicator(
      //         strokeWidth: 2.0,
      //         valueColor: AlwaysStoppedAnimation(
      //           widget.weFreeFooter.textColor,
      //         ),
      //       ),
      //     )
      //         : widget.loadState == LoadMode.loaded ||
      //         widget.loadState == LoadMode.done ||
      //         (widget.enableInfiniteLoad &&
      //             widget.loadState != LoadMode.loaded) ||
      //         widget.noMore
      //         ? Icon(
      //       _finishedIcon,
      //       color: widget.noMore ? Colors.transparent : widget.weFreeFooter.textColor,
      //     )
      //         : Transform.rotate(
      //       child: Icon(
      //         !isReverse
      //             ? Icons.arrow_upward
      //             : Icons.arrow_downward,
      //         color: widget.weFreeFooter.textColor,
      //       ),
      //       angle: 2 * pi * _iconRotationValue,
      //     ),
      //   ),
      // ),
      Expanded(
        flex: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Expanded( flex: 1, child: widget.noMore ? Row(
                  children: [
                    Expanded(child: Container()),
                    Container(
                      width: 32,
                      child: Divider(color: widget.weFreeFooter.textColor, thickness: 0.5, ),
                    )
                  ],
                ) : Container(),),
                Container(
                  margin: const EdgeInsets.only(left: 12, right: 12),
                  child: Text(
                    _showText,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: widget.weFreeFooter.textColor,
                    ),
                  ),
                ),
                Expanded( flex: 1, child: widget.noMore ? Row(
                  children: [
                    Container(
                      width: 32,
                      child: Divider(color: widget.weFreeFooter.textColor, thickness: 0.5, ),
                    ),
                    Expanded(child: Container()),
                  ],
                ) : Container(),),
              ],
            ),
            widget.weFreeFooter.showInfo
                ? Container(
              margin: EdgeInsets.only(
                top: 2.0,
              ),
              child: Text(
                _infoTextStr,
                style: TextStyle(
                  fontSize: 12.0,
                  color: widget.weFreeFooter.infoColor,
                ),
              ),
            )
                : Container(),
          ],
        ),
      ),
      // Expanded(
      //   flex: 2,
      //   child: SizedBox(),
      // ),
    ]
        : <Widget>[
      Container(
        child: widget.loadState == LoadMode.load ||
            widget.loadState == LoadMode.armed
            ? Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation(
              widget.weFreeFooter.textColor,
            ),
          ),
        )
            : widget.loadState == LoadMode.loaded ||
            widget.loadState == LoadMode.done ||
            (widget.enableInfiniteLoad &&
                widget.loadState != LoadMode.loaded) ||
            widget.noMore
            ? Icon(
          _finishedIcon,
          color: widget.noMore ? Colors.transparent : widget.weFreeFooter.textColor,
        )
            : Transform.rotate(
          child: Icon(
            !isReverse ? Icons.arrow_back : Icons.arrow_forward,
            color: widget.weFreeFooter.textColor,
          ),
          angle: 2 * pi * _iconRotationValue,
        ),
      ),
    ];
  }
}