import 'package:voiceread/voiceread.dart';

///语音SDK

class VideoUtils{
 static double _iCPMOne = 0;
 static double _iCPMTwo = 0;
 static loadVoiceAd() {
    Voiceread.loadVoiceAd(resourceId: '1913514132', listener: (eventType, params) {
      print("loadVoiceAd, eventType = " + eventType + " , params = " + (params?.toString() ?? "null"));
      if (eventType == "onAdLoadSuccess") {
        _iCPMOne = params!['iCPMOne'];
        _iCPMTwo = params['iCPMTwo'];
        int maxReadNum = params['maxReadNum'];
        int surplusReadNum = params['surplusReadNum'];
        showVoiceAd();
      } else if(eventType == "onAdLoadError") {
        int errorCode = params!["errorCode"];
        String errorMsg = params['errorMsg'];
      }
    });
  }

 static showVoiceAd() {
    Voiceread.showVoiceAd(rewardInfo: [
      {"rewardCount": _iCPMOne * 10, "rewardName": "金币"},
      {"rewardCount": _iCPMTwo * 10, "rewardName": "金币"}
    ],listener: (eventType, params) {
      print("showVoiceAd, eventType = " + eventType + " , params = " + (params?.toString() ?? "null"));
      if (eventType == "onAdShow") {
      } else if(eventType == "onAdError") {
        int errorCode = params!["errorCode"];
      } else if(eventType == "onAdClose") {

      } else if(eventType == "onRewardVerify") {
        String logId = params!["logId"];
        double iCPM = params["iCPM"];
        int stepNum = params["stepNum"];
      }
    });
  }
}