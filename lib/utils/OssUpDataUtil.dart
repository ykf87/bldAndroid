import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/OSSEntityEntity.dart';
import 'package:dio/dio.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/base/empty_entity.dart';
import 'package:SDZ/entity/user_entity.dart';
import 'package:SDZ/event/login_event.dart';
import 'package:SDZ/event/user_center_get_data.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:SDZ/entity/mime/ali_oss_entity.dart';
import 'package:SDZ/utils/wf_log_util.dart';
import 'event_bus_util.dart';

class OssUpdataUtil {
  static String? accessKeySecret;
  static String? accessKeyId;
  static String? securityToken;
  static String? bucket;
  static String? host;

  //获取验证文本域
  static String _policyText =
      '{"expiration": "2021-08-17T03:47:54Z","conditions": [["content-length-range", 0, 1048576000]]}'; //UTC时间+8=北京时间

  static void upload(XFile? xfile, Function callBack, {File? file}) {
    // EasyLoading.show(status: '上传中...');
    ApiClient.instance.get(ApiUrl.getOssConfig, onSuccess: (data) {
      BaseEntity<AliOssEntity> entity = BaseEntity.fromJson(data!);
      if (entity.isSuccess) {
        accessKeySecret = entity.data!.accessKeySecret;
        accessKeyId = entity.data!.accessKeyId;
        securityToken = entity.data!.securityToken;
        bucket = '${entity.data!.bucket}/';
        host = entity.data!.domain;
        _policyText =
            '{"expiration": "${entity.data!.expiration}","conditions": [["content-length-range", 0, 1048576000]]}';
        uploadToOss(xfile, callBack, file: file);

        return;
      } else {
        ToastUtils.toast('上传失败重试');
      }
      EasyLoading.dismiss();
    }, onError: (msg) {
      ToastUtils.toast('上传失败重试');
      EasyLoading.dismiss();
    });
  }

  // 组装数据，开始上传
  static void uploadToOss(XFile? xfile, Function callBack, {File? file}) async {
    String path = '';
    if (xfile != null) {
      path = xfile.path;
    } else if (file != null) {
      path = file.path;
    }

    String pathName = '${getImageRandonName(path)}';
    FormData formdata = new FormData.fromMap({
      // 'key':pathName,
      'key': bucket! + pathName,
      'policy': getSplicyBase64(_policyText),
      'OSSAccessKeyId': accessKeyId,
      'success_action_status': '200',
      'signature': getSignature(_policyText),
      'x-oss-security-token': securityToken,
      'file': MultipartFile.fromFileSync(path)
    });

    var options = BaseOptions(
      method: "post",
      contentType: "multipart/form-data",
      receiveTimeout: 5000,
      followRedirects: true,
    );
    options.responseType = ResponseType.plain;
    Dio _dio = Dio(options);
    try {
      Response response = await _dio.post(host!, data: formdata);
      if (response.statusCode == 200) {
        var url = '$host/$bucket$pathName';
        // var url = '$host/$pathName';
        callBack.call(url);
      } else {
        ToastUtils.toast('上传失败重试');
      }
      EasyLoading.dismiss();
    } on DioError catch (e) {
      EasyLoading.dismiss();
      WFLogUtil.d(e.message);
      WFLogUtil.d(e.response!.data);
      WFLogUtil.d(e.response!.headers);
      WFLogUtil.d(e.response);
    }
  }

  //回调 0：成功 1：失败
  static int CODE_SUCCESS = 0;
  static int CODE_FAil = 1;

  static Future<String>? upImg(String url, Function callBack) {
    Map<String, dynamic> map = new Map();
    map['avatar'] = url;
    map['nickname'] = SPUtils.getNickName();
    ApiClient.instance.put(ApiUrl.info, data: map, onSuccess: (data) {
      BaseEntity<EmptyEntity> entity = BaseEntity.fromJson(data!);
      if (entity.isSuccess) {
        SPUtils.setAvatar(url);
        EventBusUtils.getInstance().fire(UserCenterEvent());
        callBack.call(CODE_SUCCESS);
      } else {
        callBack.call(CODE_FAil);
      }
    });
  }

  static String getImageRandonName(String imagePage) {
    String s = getImageNameByPath(imagePage);
    return "Android_" + getDate() + "_" + s;
  }

  /*
  * 根据图片本地路径获取图片名称
  * */
  static String getImageNameByPath(String filePath) {
    // ignore: null_aware_before_operator
    return filePath.substring(filePath.lastIndexOf("/") + 1, filePath.length);
  }

  // 获取plice的base64
  static getSplicyBase64(String policyText) {
    //进行utf8编码
    List<int> policyText_utf8 = utf8.encode(policyText);
    //进行base64编码
    String policy_base64 = base64.encode(policyText_utf8);
    return policy_base64;
  }

  /// 获取签名
  static String getSignature(String policyText) {
    //进行utf8编码
    List<int> policyText_utf8 = utf8.encode(policyText);
    //进行base64编码
    String policy_base64 = base64.encode(policyText_utf8);
    //再次进行utf8编码
    List<int> policy = utf8.encode(policy_base64);
    //进行utf8 编码
    List<int> key = utf8.encode(accessKeySecret!);
    //通过hmac,使用sha1进行加密
    List<int> signature_pre = Hmac(sha1, key).convert(policy).bytes;
    //最后一步，将上述所得进行base64 编码
    String signature = base64.encode(signature_pre);
    return signature;
  }

  static String getFileType(String path) {
    List<String> array = path.split('.');
    return array[array.length - 1];
  }

  /// 获取日期
  static String getDate() {
    DateTime now = DateTime.now();
    return '${now.year}${now.month}${now.day}';
  }
}
