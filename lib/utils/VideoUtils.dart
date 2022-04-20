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

  static loadVoiceAd(Function callBack,{String? type = 'sign'}) {
    Voiceread.loadVoiceAd(
        resourceId: '1913514132',
        userId: SPUtils.getUserId(),
        mediaExtra: '{"type":"$type"}',
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
    String logId = '';
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
          } else if (eventType == "onAdClose") {
            if (isReward) {
              callBack.call(logId);
              isReward = false;
            }
            print("TTTTTTTTT===onAdClose");
          } else if (eventType == "onRewardVerify") {
            isReward = true;
            print("TTTTTTTTT===onRewardVerify");
            logId = params!["logId"];
            double iCPM = params["iCPM"];
            int stepNum = params["stepNum"];
          }
        });
  }
}
