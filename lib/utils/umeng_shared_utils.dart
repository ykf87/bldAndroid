import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/mime/my_browse_record_entity.dart';
import 'package:SDZ/entity/mime/my_collect_entity.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/widget/poster_shared_dialog/view.dart';
// import 'package:sharesdk_plugin/sharesdk_plugin.dart';
// import 'package:sharesdk_plugin/sharesdk_register.dart';
import 'package:SDZ/widget/shared_dialog.dart';

class UmengSharedUtils {
  static init() {
    // ShareSDKRegister register = ShareSDKRegister();
    //
    // register.setupWechat("wxf277cc2bbb58462c",
    //     "fbbc5e17b2441ff0d0872ec8cafc470c", "https://www.sandslee.com/");
    //
    // register.setupQQ("1109986888", "GEkiHSSxmay2zMHo");
    //
    // SharesdkPlugin.regist(register);

    submitPrivacyGrantResult();
  }

  static int SHARED_TYPE_TALENT_HOME = 1;//达人主页
  static int SHARED_TYPE_TALENT_CARD = 2;//名片


  static void showSharedDialog(BuildContext context,int? accountId,int sharedType,{MyBrowseRecordEntity? talentHomeEntity,MyCollectEntity? cardEntity}) {
    if(accountId == 0){
      ToastUtils.toast('数据获取失败，请重试');
      return;
    }
    showModalBottomSheet(
        backgroundColor:Colours.bg_b3000000,
        shape: RoundedRectangleBorder(
          // borderRadius: BorderRadius.all(
          //  Radius.circular(12.0)
          // ),
        ),
        context: context,
        builder: (BuildContext context) {
          return sharedDialog(accountId,sharedType,talentHomeEntity: talentHomeEntity,cardEntity: cardEntity,);
        });
  }

  //talentId：达人id
  static void showPosterSharedDialog(BuildContext context,int? talentId,int isFilter,{MyCollectEntity? cardEntity}) {
    showModalBottomSheet(
      isScrollControlled: true,
        backgroundColor:Colours.bg_b3000000,
        shape: RoundedRectangleBorder(
          // borderRadius: BorderRadius.all(
          //  Radius.circular(12.0)
          // ),
        ),
        context: context,
        builder: (BuildContext context) {
          return PosterSharedDialogPage(talentId,cardEntity,isFilter);
        });
  }
  //
  //
  // //隐私协议同意之后调用
  static void submitPrivacyGrantResult() {
    // SharesdkPlugin.uploadPrivacyPermissionStatus(1, (bool success) {
    //   if (success == true) {
    //     print("隐私协议授权提交结果成功");
    //   } else {
    //     print("隐私协议授权提交结果失败");
    //   }
    // });
  }
  //
  // static void sharedQQ() {
  //   SSDKMap params = SSDKMap()
  //     ..setQQ(
  //         "text",
  //         "title",
  //         "http://m.93lj.com/sharelink?mobid=ziqMNf",
  //         "",
  //         "",
  //         "",
  //         "",
  //         "",
  //         "http://wx4.sinaimg.cn/large/006tkBCzly1fy8hfqdoy6j30dw0dw759.jpg",
  //         "",
  //         "",
  //         "http://m.93lj.com/sharelink?mobid=ziqMNf",
  //         "",
  //         "",
  //         SSDKContentTypes.webpage,
  //         ShareSDKPlatforms.qq);
  //   SharesdkPlugin.share(ShareSDKPlatforms.qq, params, (SSDKResponseState state,
  //       dynamic userdata, dynamic contentEntity, SSDKError error) {
  //     // showAlert(state, error.rawData, context);
  //   });
  // }
  // static void sharedQQZone() {
  //   SSDKMap params = SSDKMap()
  //     ..setQQ(
  //         "text",
  //         "title",
  //         "http://m.93lj.com/sharelink?mobid=ziqMNf",
  //         "",
  //         "",
  //         "",
  //         "",
  //         "",
  //         "http://wx4.sinaimg.cn/large/006tkBCzly1fy8hfqdoy6j30dw0dw759.jpg",
  //         "",
  //         "",
  //         "http://m.93lj.com/sharelink?mobid=ziqMNf",
  //         "",
  //         "",
  //         SSDKContentTypes.webpage,
  //         ShareSDKPlatforms.qZone);
  //   SharesdkPlugin.share(ShareSDKPlatforms.qZone, params, (SSDKResponseState state,
  //       dynamic userdata, dynamic contentEntity, SSDKError error) {
  //     // showAlert(state, error.rawData, context);
  //   });
  // }
  //
  // static void sharedWechat() {
  //   SSDKMap params = SSDKMap()
  //     ..setGeneral(
  //         "title",
  //         "text",
  //         [
  //           "http://download.sdk.mob.com/web/images/2019/07/30/14/1564468183056/750_750_65.12.png"
  //         ],
  //         "http://download.sdk.mob.com/web/images/2019/07/30/14/1564468183056/750_750_65.12.png",
  //         "",
  //         "http://pic28.photophoto.cn/20130818/0020033143720852_b.jpg",
  //         "http://pic28.photophoto.cn/20130818/0020033143720852_b.jpg",
  //         "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
  //         "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
  //         "",
  //         SSDKContentTypes.image);
  //
  //   SharesdkPlugin.share(
  //       ShareSDKPlatforms.wechatSession,
  //       params,
  //       (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
  //           SSDKError error) {});
  // }
  //
  // ///朋友圈
  // static void sharedWeChatFavorites() {
  //   SSDKMap params = SSDKMap()
  //     ..setWechat(
  //         "text",
  //         "title",
  //         "www.baidu.com",
  //         "",
  //         null,
  //         "",
  //         "",
  //         "http://pic28.photophoto.cn/20130818/0020033143720852_b.jpg",
  //         null,
  //         "",
  //         "",
  //         "",
  //         "",
  //         SSDKContentTypes.webpage,
  //         ShareSDKPlatforms.wechatTimeline);
  //
  //   SharesdkPlugin.share(ShareSDKPlatforms.wechatTimeline, params,
  //           (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
  //           SSDKError error) {
  //       });
  // }
}
