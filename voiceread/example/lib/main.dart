import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:voiceread/voiceread.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  double _iCPMOne = 0;
  double _iCPMTwo = 0;

  @override
  void initState() {
    super.initState();
  }

  init() {
    Voiceread.init(appId: '13513911', appSecret: 'qap93oxn2wnpait30y2cjyr177dljnyw', debug: true);
  }

  checkAdStatus() {
    Voiceread.checkAdStatus(resourceId: '13513973', listener: (eventType, params) {
      print("checkAdStatus, eventType = " + eventType + " , params = " + (params?.toString() ?? "null"));
      if(eventType == "onVerifySuccess") {

      } else if(eventType == "onError") {
        int errorCode = params!["errorCode"];
      }
    });
  }

  loadVoiceAd() {
    Voiceread.loadVoiceAd(resourceId: '13513973', listener: (eventType, params) {
      print("loadVoiceAd, eventType = " + eventType + " , params = " + (params?.toString() ?? "null"));
      if (eventType == "onAdLoadSuccess") {
        _iCPMOne = params!['iCPMOne'];
        _iCPMTwo = params['iCPMTwo'];
        int maxReadNum = params['maxReadNum'];
        int surplusReadNum = params['surplusReadNum'];
      } else if(eventType == "onAdLoadError") {
        int errorCode = params!["errorCode"];
        String errorMsg = params['errorMsg'];
      }
    });
  }

  showVoiceAd() {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            TextButton(onPressed: () {
              init();
            }, child: Text("初始化")),
            TextButton(onPressed: () {
              checkAdStatus();
            }, child: Text("检测广告状态")),
            TextButton(onPressed: () {
              loadVoiceAd();
            }, child: Text("加载广告")),
            TextButton(onPressed: () {
              showVoiceAd();
            }, child: Text("显示广告")),
          ],
        ),
      ),
    );
  }
}
