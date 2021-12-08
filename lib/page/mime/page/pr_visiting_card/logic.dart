import 'package:date_format/date_format.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:SDZ/api/api_client.dart';
import 'package:SDZ/api/api_url.dart';
import 'package:SDZ/core/utils/toast.dart';
import 'package:SDZ/entity/base/base_entity.dart';
import 'package:SDZ/entity/mime/pr_card_info_entity.dart';
import 'package:SDZ/entity/mime/pr_list_skill_entity.dart';
import 'package:SDZ/event/user_center_get_data.dart';
import 'package:SDZ/res/colors.dart';
import 'package:SDZ/utils/event_bus_util.dart';
import 'package:SDZ/utils/wf_log_util.dart';
import '../../../../entity/mime/base_info_entity.dart';
import 'package:SDZ/page/shop/widget/camera_dialog.dart';
import 'package:SDZ/utils/OssUpDataUtil.dart';

import 'entity/skill_entity.dart';
import 'state.dart';

class PrVisitingCardLogic extends GetxController {
  final state = PrVisitingCardState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    EventBusUtils.getInstance().fire(UserCenterEvent());
  }

  //获取PR名片信息
  void getPRData() {
    if (state.carID == 0) {
      return;
    }
    ApiClient.instance.get("${ApiUrl.prCard}/${state.carID}",
        onSuccess: (data) {
      BaseEntity<PrCardInfoEntity> entity = BaseEntity.fromJson(data!);
      if (entity.data == null) {
        state.canEdit = true;
        update();
        return;
      }
      state.prCardInfoEntity = entity.data;
      state.selcetIdentityValue = state.prCardInfoEntity!.identityType;
      state.controllerCompany.text = state.prCardInfoEntity!.companyName;
      state.controllerJob.text = state.prCardInfoEntity!.professionalTitle;
      state.remark = state.prCardInfoEntity!.remark??'';
      state.cardAvatar = state.prCardInfoEntity!.cardAvatar;
      if (state.prCardInfoEntity!.status == 1 || state.prCardInfoEntity!.status == 4) {
        //审核不通过和新建
        state.canEdit = true;
      } else {
        state.canEdit = false;
      }
      for (int i = 0; i < state.allSkillList.length; i++) {
        for (int j = 0; j < state.prCardInfoEntity!.skills.length; j++) {
          if (state.allSkillList[i].skillId ==
              state.prCardInfoEntity!.skills[j].skillId) {
            state.allSkillList[i].isSelect = true;
            continue;
          }
        }
      }
      update();
    });
  }

  String get remark => state.remark ?? '';

  //获取PR擅长领域
  void getSkillList() {
    ApiClient.instance.get(ApiUrl.prskills, onSuccess: (data) {
      BaseEntity<List<PrListSkillEntity>> entity = BaseEntity.fromJson(data!);
      state.allSkillList = entity.data!;
      WFLogUtil.d('state.allSkillList==${state.allSkillList.length}');
      getPRData();
      update();
    });
  }

  //提交PR名片信息
  void modifySkillList() {
    if(state.prCardInfoEntity?.status == 2){
      return;
    }
    Map<String, dynamic> map = Map();
    map['identityType'] = state.selcetIdentityValue;
    map['companyName'] = state.controllerCompany.text;
    map['professionalTitle'] = state.controllerJob.text;
    map['cardAvatar'] = state.cardAvatar;
    map['skills'] = state.selectList;
    if (state.carID != 0) {
      map['cardId'] = state.carID;
    }

    ApiClient.instance.put(ApiUrl.modifyPRCard, data: map, onSuccess: (data) {
      ToastUtils.toast('提交成功');
      EventBusUtils.getInstance().fire(UserCenterEvent());
      Get.back();
    });
  }

  //选择身份
  void selectIdentity(int select) {
    if (state.prCardInfoEntity?.status == 2) {
      return;
    }
    state.focusNodecompny.unfocus();
    state.selcetIdentityValue = select;
    update();
  }

  //选择技能
  void selectSkill(int index) {
    if (state.prCardInfoEntity?.status == 2 ||
        state.prCardInfoEntity?.status == 3) {
      return;
    }
    state.allSkillList[index].isSelect = !state.allSkillList[index].isSelect;
    update();
  }

  //上传名片
  void selectImgCard(BuildContext context) {
    if (state.prCardInfoEntity?.status == 2 ||
        state.prCardInfoEntity?.status == 3) {
      return;
    }
    showModalBottomSheet(
        context: context,
        backgroundColor:Colours.bg_b3000000,
        builder: (BuildContext context) {
          return CameraDialog(callBack: (var file) {
            OssUpdataUtil.upload(file, (String url) {
              state.cardAvatar = url;
              update();
            });
          });
        });
  }

  void commit() {
    state.selectList.clear();
    if (state.selcetIdentityValue == 0) {
      ToastUtils.toast('请选择您的身份');
      return;
    }
    if (state.controllerCompany.text.length < 2) {
      ToastUtils.toast('请完善您的公司名称');
      return;
    }
    if (state.controllerJob.text.length < 2) {
      ToastUtils.toast('请完善您的职位信息');
      return;
    }
    state.allSkillList.forEach((element) {
      if (element.isSelect) {
        state.selectList.add(element.skillId);
      }
    });
    if (state.selectList.length == 0) {
      ToastUtils.toast('请至少选择一个擅长领域');
      return;
    }
    if (state.cardAvatar == null) {
      ToastUtils.toast('请上传您的名片');
      return;
    }

    modifySkillList();
  }
}
