import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/base/base_stateful_widget.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/mime/user_center_entity.dart';
import 'package:SDZ/page/mime/page/withdraw/view.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/widget/double_click.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class MyWalletPage extends BaseStatefulWidget {
  @override
  BaseStatefulState<BaseStatefulWidget> getState() {
    return MyWalletPageState();
  }
}

class MyWalletPageState extends BaseStatefulState {
  final MyWalletLogic logic = Get.put(MyWalletLogic());
  final MyWalletState state = Get.find<MyWalletLogic>().state;
  UserCenterEntity? userCenterEntity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  String navigatorTitle() {
    return '我的钱包';
  }

  @override
  List<Widget> customActions() {
    // TODO: implement customActions
    return [
      // DoubleClick(
      //   onTap: () {
      //     // Get.to(WithdrawPage());
      //   },
      //   child: Center(
      //       child: Container(
      //           margin: EdgeInsets.only(right: 10),
      //           child: Text(
      //             '收支记录',
      //             style: TextStyle(color: Color(0xFFe9546b), fontSize: 14),
      //           ))),
      // ),
    ];
  }

  @override
  Widget initDefaultBuild(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 90,
          ),
          Image(
            image: AssetImage("assets/images/ic_wallet.png"),
            width: 80,
            height: 80,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '当前可用省币数量（个）',
            style: TextStyle(color: Colours.color_333333, fontSize: 14),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            (userCenterEntity?.jifen ?? 0).toString(),
            style: TextStyle(color: Colours.color_333333, fontSize: 36),
          ),
          FlatButton(
              onPressed: () {
                Get.to(WithdrawPage());
              },
              child: new Container(
                height: 45.0,
                margin: new EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                decoration: new BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(50.0)),
                    gradient: new LinearGradient(colors: [
                      const Color(0xFFe9546b),
                      const Color(0xFFd0465b)
                    ])),
                child: new Center(
                    child: new Text(
                  "提 现",
                  textScaleFactor: 1.1,
                  style: new TextStyle(fontSize: 16.0, color: Colors.white),
                )),
              ))
        ],
      ),
    );
  }

  ///个人中心数据
  void getData() {
    ApiClient.instance.get(ApiUrl.getBLDBaseUrl() + ApiUrl.center,
        onSuccess: (data) {
      BaseEntity<UserCenterEntity> entity = BaseEntity.fromJson(data!);
      if (entity.isSuccess && entity.data != null) {
       setState(() {
         userCenterEntity = entity.data;
       });
      }
    });
  }
}
