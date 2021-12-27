import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:SDZ/core/utils/utils.dart';
import 'package:SDZ/generated/i18n.dart';
import 'package:SDZ/res/colors.dart';

///关于页面
class AboutWeFreePage extends StatefulWidget {
  @override
  _AboutWeFreePageState createState() => _AboutWeFreePageState();
}

class _AboutWeFreePageState extends State<AboutWeFreePage> {
  String _versionName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Utils.getPackageInfo().then((value) => {
          setState(() {
            _versionName = value.version;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('关于省得赚',
              style: TextStyle(color: Colours.text_121212, fontSize: 20)),
          leading: IconButton(
            color: Colors.black,
            tooltip: null,
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_outlined),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: SvgPicture.asset('assets/svg/ic_logo_about.svg',width: 96,height: 96)),
                Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Center(
                        child: Text("省得赚",
                            style: TextStyle(
                                color: Colors.white, fontSize: 16)))),
                Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Center(
                        child: Text(
                            "${I18n.of(context)!.versionName}: $_versionName",
                            style: TextStyle(
                                color:  Colors.white, fontSize: 14)))),
                Padding(padding: EdgeInsets.only(top: 22),
                    child: Text('最受欢迎的一站式数字化社交营销网络平台。\n平台目前粉丝覆盖率高达到7亿+，总互动量达70亿。达人聚焦在护肤、美妆、生活方式、探店、时尚、穿搭、母婴、等众多领域，粉丝覆盖小红书、抖音、逛逛、大众点评、得物等主流平台。通过数据驱动与智能匹配，让您直接邀请达人、与达人直接沟通；实现精准投放与效果跟踪，是全网铺量的首选',
                        style:TextStyle(color: Colours.text_main,fontSize: 14,height: 1.8)))
              ],
            ),
          ),
        ));
  }
}
