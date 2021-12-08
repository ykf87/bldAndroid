import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class MySwiperPagination extends SwiperPlugin {
  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    return ConfigProvider(config: config, child: MySwiperDotWidget());
  }
}

class MySwiperDotWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MySwiperDotWidgetState();
}

class MySwiperDotWidgetState extends State<MySwiperDotWidget> {
  SwiperPluginConfig? config;

  double? page;

  @override
  void didChangeDependencies() {
    config = ConfigProvider.of(context)!.config;
    page = config?.pageController?.page;
    config?.pageController?.addListener(() {
      setState(() {
        page = config?.pageController?.page;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    double baseWidth = 6.0;
    double ratio = 3.0;
    int? itemCount = config?.itemCount;
    int? floor = page?.floor();
    int? ceil = page?.ceil();
    int? preIndex = floor! % itemCount!;
    int? nextIndex = ceil! % itemCount;
    double prePercent = page! - preIndex;
    double nextPercent = 1 - prePercent;

    double baseOpacity = 0.3;
    double offsetOpacity = 1.0 - baseOpacity;

    for (int i = 0; i < itemCount; ++i) {
      double width;
      double opacity;
      if (i == preIndex) {
        width = baseWidth * (1.0 + ratio * nextPercent);
        opacity = baseOpacity + offsetOpacity * nextPercent;
      } else if (i == nextIndex) {
        width = baseWidth * (1.0 + ratio * prePercent);
        opacity = baseOpacity + offsetOpacity * prePercent;
      } else {
        width = baseWidth;
        opacity = baseOpacity;
      }

      list.add(Container(
        key: Key("zhihupagination_$i"),
        margin: EdgeInsets.symmetric(horizontal: 3),
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(3), right: Radius.circular(3)),
          child: Container(
            color: Colors.white.withOpacity(opacity),
            width: width,
            height: 6,
          ),
        ),
      ));
    }
    return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: EdgeInsets.only(right: 18, bottom: 18),
            child: Row(mainAxisSize: MainAxisSize.min, children: list)));
  }

  @override
  void dispose() {
    config?.pageController?.dispose();
    super.dispose();
  }
}

class ConfigProvider extends InheritedWidget {
  final SwiperPluginConfig config;
  final Widget child;

  ConfigProvider({required this.config, required this.child}) : super(child: child);

  static ConfigProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ConfigProvider>();

  @override
  bool updateShouldNotify(ConfigProvider oldWidget) {
    return oldWidget.config != config;
  }
}