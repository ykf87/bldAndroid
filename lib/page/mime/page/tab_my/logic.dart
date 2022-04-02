import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/mime/my_browse_record_entity.dart';
import 'package:SDZ/entity/mime/user_center_entity.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/event/user_center_get_data.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/utils/login_util.dart';
import 'package:SDZ/utils/sputils.dart';

import 'state.dart';
import 'dart:ui' as ui;
import 'package:path/path.dart' as path;

class Tab_myLogic extends GetxController {
  final state = Tab_myState();

  void initEvent() {
    state.loginEventBus = EventBusUtils.getInstance().on<LoginEvent>().listen((event) {
      if (event.mLogin == LoginEvent.LOGIN_TYPE_LOGIN) {
        state.isLogin = true;
        getData();
      } else if (event.mLogin == LoginEvent.LOGIN_TYPE_LOGINOUT) {
        state.isLogin = false;
      }
      update();
    });

    state.userCenterEventBus = EventBusUtils.getInstance().on<UserCenterEvent>().listen((event) {
      getData();
    });
  }

  ///个人中心数据
  void getData() {
    if(LoginUtil.isLogin()){
      ApiClient.instance.get(ApiUrl.getBLDBaseUrl()+ApiUrl.center, onSuccess: (data) {
        BaseEntity<UserCenterEntity> entity = BaseEntity.fromJson(data!);
        if (entity.isSuccess && entity.data != null) {
          state.userCenterEntity = entity.data!;
        }
        update();
      });
    }
  }
  //
  // saveScreen() async {
  //   RenderRepaintBoundary boundary = state.globalKey.currentContext!
  //       .findRenderObject() as RenderRepaintBoundary;
  //   ui.Image image = await boundary.toImage();
  //   ByteData? byteData =
  //       await (image.toByteData(format: ui.ImageByteFormat.png));
  //   if (byteData != null) {
  //     final result =
  //         await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
  //     print('json==$result');
  //     // SaveImgEntity entity = SaveImgEntity.fromJson(json);
  //     // print('照片==${entity.filePath}');
  //   }
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String appDocPath = appDocDir.path;
  //   var pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);
  //   final imageFile = File(path.join(appDocPath, 'dart.png'));
  //   imageFile.writeAsBytesSync(pngBytes!.buffer.asInt8List());
  // }
}
