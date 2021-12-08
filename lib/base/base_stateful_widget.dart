import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/color_util.dart';
import 'package:SDZ/widget/double_click.dart';

abstract class BaseStatefulWidget extends StatefulWidget {

  const BaseStatefulWidget({Key? key}): super(key: key);

  @override
  BaseStatefulState createState() => getState();

  BaseStatefulState getState();
}

abstract class BaseStatefulState<T extends BaseStatefulWidget> extends State<T> {

  ///界面进入,初始化数据
  void initData() => {};

  ///界面销毁
  void onDispose() => {};

  ///界面构建
  Widget initDefaultBuild(BuildContext context);

  ///导航栏标题
  String navigatorTitle() => "";

  ///是否拦截导航栏返回事件
  bool interceptNavigatorBackClick() => false;

  ///导航栏返回事件回调
  void initNavigatorClickListener() => {};

  ///导航栏标题样式
  TextStyle initNavigatorTextStyle() => TextStyle(
      color: Colors.white,
      fontSize: 20
  );

  ///是否自定义导航栏
  bool isCustomNavigator() => false;

  ///自定义导航栏
  PreferredSizeWidget? initCustomNavigator() => AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
  );

  ///背景色
  Color getPageBackgroundColor() => Colors.white;

  ///布局是否从状态栏下面开始
  bool isPrimary() => true;

  @override
  void initState() {
    super.initState();
    initData();
  }

  ///dispose
  @override
  void dispose() {
    focusNode.dispose();
    onDispose();
    super.dispose();
  }

  FocusNode focusNode = FocusNode();

  ///build
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      primary: isPrimary(),
      // backgroundColor: getPageBackgroundColor(),
      ///固定在底部widget不会被键盘顶起
      resizeToAvoidBottomInset: false,
      appBar: isCustomNavigator() ? initCustomNavigator() : AppBar(
        ///隐藏底部阴影
        elevation: 0,
        // backgroundColor: Colours.color_10121A,
        leading: IconButton(
          color: Colors.white,
          tooltip: null,
          onPressed: () {
            onCloseKeyboard();
            ///拦截导航栏事件
            if(interceptNavigatorBackClick()) {
              initNavigatorClickListener();
              return;
            }
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_outlined),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        centerTitle: true,
        title: Text(
            navigatorTitle(),
            textAlign: TextAlign.center,
            style: initNavigatorTextStyle(),
        ),
        brightness: Brightness.dark,
      ),
      body: DoubleClick(
        ///解决onTap不响应
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onCloseKeyboard();
        },
        child: initDefaultBuild(context),
      ),
    );
  }

  /// 隐藏软键盘
  void onCloseKeyboard() {
    focusNode.unfocus();
    ///全局处理点击空白处隐藏软键盘
    FocusScopeNode focusScopeNode = FocusScope.of(context);
    if(!focusScopeNode.hasPrimaryFocus && focusScopeNode.focusedChild != null) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
  }
}