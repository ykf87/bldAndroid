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

  static loadVoiceAd(Function callBack) {
    Voiceread.loadVoiceAd(
        resourceId: '1913514132',
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
            showVoiceAd(callBack);
          } else if (eventType == "onAdLoadError") {
            int errorCode = params!["errorCode"];
            String errorMsg = params['errorMsg'];
          }
        });
  }

  static showVoiceAd(Function callBack) {
    bool isReward = false;
    Voiceread.showVoiceAd(
        rewardInfo: [
          {"rewardCount": _iCPMOne * 10, "rewardName": "金币"},
          {"rewardCount": _iCPMTwo * 10, "rewardName": "金币"}
        ],
        listener: (eventType, params) {
          print("showVoiceAd, eventType = " +
              eventType +
              " , params = " +
              (params?.toString() ?? "null"));
          if (eventType == "onAdShow") {
          } else if (eventType == "onAdError") {
            int errorCode = params!["errorCode"];
            print("TTTTTTTTT===onAdShow");
            if (isReward) {
              callBack.call();
              isReward = false;
            }
          } else if (eventType == "onAdClose") {
            print("TTTTTTTTT===onAdClose");
          } else if (eventType == "onRewardVerify") {
            isReward = true;
            print("TTTTTTTTT===onRewardVerify");
            String logId = params!["logId"];
            double iCPM = params["iCPM"];
            int stepNum = params["stepNum"];
          }
        });
  }
}
