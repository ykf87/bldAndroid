import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/mime/my_browse_record_entity.dart';
import 'package:SDZ/entity/mime/my_collect_entity.dart';
import 'package:SDZ/entity/talent/q_r_code_entity.dart';
import 'package:SDZ/utils/OssUpDataUtil.dart';
import 'package:SDZ/utils/fluex_share.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/utils/umengshare.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:SDZ/utils/utils.dart';

import 'state.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class PosterSharedDialogLogic extends GetxController {
  final state = PosterSharedDialogState();
  GlobalKey repaintKey = GlobalKey();
  int DEAI_PICTURE_TYPE_SHARED = 1; //分享
  int DEAI_PICTURE_TYPE_SAVE = 2; //保存

  int SHARED_TYPE_WECHAT = 1; //微信分享
  int SHARED_TYPE_MOMENTS = 2; //朋友圈分享
  MyBrowseRecordEntity pageEntity = new MyBrowseRecordEntity();
  late List<MyCollectEntity> cardList = [];
  String QRCodeUrl = Utils.QRCodeUrl;

  ///获取名片的分享海报详情
  void getCardDetail(MyCollectEntity? cardEntity) {
    state.listResume.clear();
    //名片标签
    cardEntity?.skillTagList?.forEach((element) {
      state.listResume.add(element.skillLabel);
    });
    if (state.listResume.length > 0) {
      state.listResume.add('···');
    }
    cardList.clear();

    if (cardEntity != null) {
      //卡片分享
      cardList.add(cardEntity);
    }
    update();
  }

  ///获取达人名片详情
  void getTalentHomeData(int? talentid, int isFilter) {
    //获取达人主页数据
    Map<String, dynamic> map = new Map();
    map['isFilter'] = isFilter;
    ApiClient.instance.get('${ApiUrl.talentHomepage}/${talentid}', data: map,
        onSuccess: (data) {
      BaseEntity<MyBrowseRecordEntity> entity = BaseEntity.fromJson(data!);
      if (entity.isSuccess && entity.data != null) {
        pageEntity = entity.data!;
        state.listResume.clear();

        //达人标签
        pageEntity.skillTagList?.forEach((element) {
          state.listResume.add(element.skillLabel ?? '');
        });
        cardList.clear();

        cardList = pageEntity.cardList ?? [];
        for (int i = 0; i < cardList.length; i++) {
          for (int j = cardList.length - 1; j > i; j--) {
            if (cardList[i].cardType == cardList[j].cardType) {
              if (cardList[j].fansNum > cardList[i].fansNum) {
                cardList[i].fansNum = cardList[j].fansNum;
                cardList[i].likesNum = cardList[j].likesNum;
                cardList[i].followNum = cardList[j].followNum;
              }
              cardList.removeAt(j);
            }
          }
        }
        cardList.sort(
            (left, right) => left.getPosition().compareTo(right.getPosition()));
      }

      if (state.listResume.length > 0) {
        state.listResume.add('···');
      }
      update();
    });
  }

  savePicture() async {
    checkPermission();
    if (await Permission.storage.request().isGranted) {
      onCaputrePicture(DEAI_PICTURE_TYPE_SAVE);
    } else {
      ToastUtils.toast('请到设置中打开存储权限');
    }
  }

  // 检查是否有权限
  checkPermission() async {
    // 检查是否已有读写内存的权限
    bool status = await Permission.storage.isGranted;
    //判断如果还没拥有读写权限就申请获取权限
    if (!status) {
      return await Permission.storage.request().isGranted;
    }
  }

  //截图 type: 1：分享 2：保存到本地
  void onCaputrePicture(int type, {int? sharedPlatform}) async {
    try {
      if (type == 1) {
        // 检测是否安装微信
        var isWeChatInstalled = await fluwx.isWeChatInstalled;
        print('微信是否安装：${isWeChatInstalled}');
        if (!isWeChatInstalled) {
          ToastUtils.toast('请先安装微信');
          return;
        }
      }
      RenderRepaintBoundary? boundary = repaintKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      double pix = window.devicePixelRatio; // 获取当前设备的像素比
      var image = await boundary!.toImage(pixelRatio: pix);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      Directory tempDir = await getTemporaryDirectory();
      File? file = new File(
          '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png');
      print("===》" + file.path);
      if (!file.existsSync()) {
        file.createSync();
      }
      file.writeAsBytesSync(pngBytes); //写入文件

      if (type == DEAI_PICTURE_TYPE_SAVE) {
        saveToLocal(file);
      } else if (type == DEAI_PICTURE_TYPE_SHARED) {
        OssUpdataUtil.upload(null, (String url) {
          if (sharedPlatform == SHARED_TYPE_WECHAT) {
            FluWxShare.shareImage(WeChatScene.SESSION, url, url);
          } else {
            FluWxShare.shareImage(WeChatScene.TIMELINE, url, url);
          }
        }, file: file);
      }
    } catch (e) {
      print(e);
    }
  }

  //保存本地
  void saveToLocal(File file) async {
    var flag = await GallerySaver.saveImage(file.path);
    // print('result==$flag');
    if (flag == true) {
      ToastUtils.toast('保存成功');
    } else {
      ToastUtils.toast('保存失败');
    }
    // GallerySaver.saveImage(file.path).then((value) => ToastUtils.toast('保存成功'));

    //
    // final result = await ImageGallerySaver.saveFile(file.path);
    // print(result.toString());
    // if (result['isSuccess']) {
    //   ToastUtils.toast('保存成功');
    //   Get.back();
    // } else {
    //   ToastUtils.toast('保存失败');
    // }

    // if (Platform.isIOS) {
    //   if (result.isSuccess) {
    //     ToastUtils.toast('保存成功');
    //     Get.back();
    //   } else {
    //     ToastUtils.toast('保存失败');
    //   }
    // } else {
    //   print('result${result}');
    //   if (result != null) {
    //     ToastUtils.toast('保存成功');
    //     Get.back();
    //   } else {
    //     ToastUtils.toast('保存失败');
    //   }
    // }
  }
}
