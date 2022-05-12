import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/page/mime/entity/reward_entity.dart';
import 'package:SDZ/utils/sputils.dart';
import 'package:voiceread/voiceread.dart';

///语音SDK

class VideoUtils {
  static double _iCPMOne = 0;
  static double _iCPMTwo = 0;

  static init() {
    Voiceread.init(
        appId: '43514108',
        appSecret: 'FYJo5V7G83U7C2POcBMlbyGkrW3s1hHu',
        debug: false);
  }

  static loadVoiceAd(Function callBack,{String? type = 'default',String? tid,String? taskId}) {
    print("TTTTTTTTT===uerid${SPUtils.getUserId()}");
    Voiceread.loadVoiceAd(
        resourceId: '1913514132',
        userId: SPUtils.getUserId(),
        mediaExtra: '{"type":"$type","tid":$tid}',
        listener: (eventType, params) {
          print("loadVoiceAd, eventType = " +
              eventType +
              " , params = " +
              (params?.toString() ?? "null"));
          if (eventType == "onAdLoadSuccess") {
            _iCPMOne = params!['iCPMOne'];
            _iCPMTwo = params['iCPMTwo'];
            int maxReadNum = params['maxReadNum'];
            int surplusReadNum = params['surplusReadNum'];
            showVoiceAd(callBack,taskId);
          } else if (eventType == "onAdLoadError") {
            int errorCode = params!["errorCode"];
            String errorMsg = params['errorMsg'];
          }
        });
  }

  static showVoiceAd(Function callBack,String? taskId) {
    bool isReward = false;
    String logId = '';
    Voiceread.showVoiceAd(
        // rewardInfo: [
        //   {"rewardCount":((_iCPMOne/1000) * 0.4).ceilToDouble().toInt(), "rewardName": "省币"},
        //   {"rewardCount": ((_iCPMTwo/1000) * 0.4).ceilToDouble(), "rewardName": "省币"}
        // ],
        listener: (eventType, params) {
          print("showVoiceAd, eventType = " +
              eventType +
              " , params = " +
              (params?.toString() ?? "null"));
          if (eventType == "onAdShow") {
          } else if (eventType == "onAdError") {
            int errorCode = params!["errorCode"];
          } else if (eventType == "onAdClose") {
            if (isReward) {
              callBack.call(logId);
              isReward = false;
            }
          } else if (eventType == "onRewardVerify") {
            isReward = true;
            logId = params!["logId"];
            double iCPM = params["iCPM"];
            int stepNum = params["stepNum"];
            // videoSuccess(taskId??'',logId: logId);
          }
        });
  }

  static  void videoSuccess(String id, {String? logId}) {
    Map<String, dynamic> map = new Map();
    map['tid'] = id;
    map['userId'] = SPUtils.getUserId();
    if (logId != null) {
      map['tagid'] = logId;
    }
    ApiClient.instance.post(ApiUrl.getBLDBaseUrl() + ApiUrl.videoSuccess,
        data: map, onSuccess: (data) {
          BaseEntity<RewardEntity> entity = BaseEntity.fromJson(data!);
          if (entity.isSuccess) {
          }
        }, onError: (msg) {
          ToastUtils.toast(msg);
        });
  }
}
