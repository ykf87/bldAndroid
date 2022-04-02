import 'package:SDZ/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
                    child: Image(
                      image: AssetImage("assets/images/sdz_logo.png"),width: 96,height: 96,
                    ),
                ),
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
                    child: Text('最受欢迎的领券及做任务赢现金平台。\n平台目前有饿了吗、美团、淘宝、pdd、京东的优惠券，还有充电费花费的优惠活动，还可以在福利中心做任务赢取现金',
                        style:TextStyle(color: Colours.text_main,fontSize: 14,height: 1.8)))
              ],
            ),
          ),
        ));
  }
}
