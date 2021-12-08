import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:svgaplayer_flutter/parser.dart';
import 'package:svgaplayer_flutter/player.dart';
import 'package:SDZ/constant/svg_path.dart';

/// @Author: ljx
/// @CreateDate: 2021/9/8 15:17
/// @Description: 自定义刷新头部
class WeFreeHeader extends Header {
  final Key? key;

  /// 是否显示推荐更新
  final bool? isShowRecommend;

  /// 是否加载成功
  final bool? isLoadSuccess;

  final LinkHeaderNotifier linkNotifier = LinkHeaderNotifier();

  WeFreeHeader({
    this.key,
    bool enableHapticFeedback = false,
    this.isShowRecommend = false,
    this.isLoadSuccess = true,
  }) : super(
    // extent: 140.0,
    // triggerDistance: 160.0,
    float: false,
    enableHapticFeedback: enableHapticFeedback,
    enableInfiniteRefresh: false,
    completeDuration: isShowRecommend! ? const Duration(milliseconds: 800) : const Duration(milliseconds: 200),
  );

  @override
  Widget contentBuilder(
      BuildContext context,
      RefreshMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration? completeDuration,
      bool enableInfiniteRefresh,
      bool success,
      bool noMore) {
    // 不能为水平方向以及反向
    assert(axisDirection == AxisDirection.down,
    'Widget can only be vertical and cannot be reversed');
    linkNotifier.contentBuilder(
        context,
        refreshState,
        pulledExtent,
        refreshTriggerPullDistance,
        refreshIndicatorExtent,
        axisDirection,
        float,
        completeDuration,
        enableInfiniteRefresh,
        success,
        noMore);
    return WeFreeHeaderWidget(
      key: key,
      linkNotifier: linkNotifier,
      isShowRecommend: isShowRecommend,
      isLoadSuccess: isLoadSuccess,
    );
  }
}

class WeFreeHeaderWidget extends StatefulWidget {
  final LinkHeaderNotifier linkNotifier;

  final bool? isShowRecommend;

  final bool? isLoadSuccess;

  const WeFreeHeaderWidget({
    Key? key,
    required this.linkNotifier,
    this.isShowRecommend,
    this.isLoadSuccess,
  }) : super(key: key);

  @override
  WeFreeHeaderWidgetState createState() {
    return WeFreeHeaderWidgetState();
  }
}

class WeFreeHeaderWidgetState extends State<WeFreeHeaderWidget> with TickerProviderStateMixin<WeFreeHeaderWidget>{
  RefreshMode get _refreshState => widget.linkNotifier.refreshState;
  double get _pulledExtent => widget.linkNotifier.pulledExtent;
  double get _riggerPullDistance =>
      widget.linkNotifier.refreshTriggerPullDistance;
  Duration get _completeDuration =>
      widget.linkNotifier.completeDuration!;
  AxisDirection get _axisDirection => widget.linkNotifier.axisDirection;
  SVGAAnimationController? svgaAnimationController;

  @override
  void initState() {
    super.initState();
    svgaAnimationController = SVGAAnimationController(vsync: this);
    loadAnimation();
  }

  @override
  void dispose() {
    svgaAnimationController?.dispose();
    super.dispose();
  }

  loadAnimation() async{
    if(svgaAnimationController?.videoItem != null) {
      return;
    }
    var svg = await SVGAParser.shared.decodeFromAssets(SvgPath.loading);
    svgaAnimationController?.videoItem = svg;
    svgaAnimationController?.repeat().whenComplete((){
      svgaAnimationController?.videoItem = null;
    });
  }

  bool _refreshFinish = false;
  set refreshFinish(bool finish) {
    if (_refreshFinish != finish) {
      if (finish) {
        // svgaAnimationController?.stop();
      }
      _refreshFinish = finish;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_refreshState == RefreshMode.refreshed) {
      refreshFinish = true;
    }
    return Container(
      width: double.infinity,
      height: _pulledExtent,
      child: stateWidget(),
    );
  }

  Widget stateWidget() {
    if(_refreshState == RefreshMode.inactive) {
      return Container();
    }
    if(_refreshState == RefreshMode.refreshed && widget.isShowRecommend!) {
      return Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 16, top: 2, right: 16, bottom: 2),
              height: 24,
              decoration: BoxDecoration(
                  color: Color(0xff252734),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Text(widget.isLoadSuccess! ? '推荐已更新' : '推荐更新失败，请稍后重试', style: TextStyle(fontSize: 14, color: Color(0xff858999)),),
            )
          ],
        ),
      );
    }
    return Center(
      child: Container(
        width: _pulledExtent/2,
        height: _pulledExtent/2,
        child: SVGAImage(svgaAnimationController!),
      ),
    );
  }
}